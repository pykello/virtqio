#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import difflib
import re
import shutil
import subprocess
import sys
import tempfile
from dataclasses import dataclass, asdict, field
from pathlib import Path
from typing import Any

import fitz
import pymupdf4llm
import yaml


SSG_MATH_SHORTHAND_REFERENCE = """
Prefer SSG math shorthand inside $...$ where it is clearer than raw LaTeX:
- number systems: bb{R}, bb{N}, bb{Z}, bb{Q}, bb{C}
- sets: set(x | condition), union, inter, subset, subseteq
- absolute value and norms: abs(x), norm(x), norm[2](x)
- sequences and limits: seq(a_n), lim[n -> inf](a_n)
- indexed operators: sum(a_k), sum[k=1..n](a_k), sum[k=1..inf](a_k), prod(a_k), prod[k=1..n](a_k)
- relations and symbols: in, notin, <=, >=, !=, ->, inf, eps, del
- Greek names: alpha, beta, gamma, theta, lambda, omega
Existing LaTeX is allowed when shorthand would be awkward.
"""

_CODex_DEFAULT_COMMAND = "__codex_default__"
_DEFAULT_RENDER_DPI = 300
_CACHE_VERSION = 1

_TESSERACT_CMD = shutil.which("tesseract")

PROSE_WORDS = {
    "adapt",
    "all",
    "and",
    "argument",
    "axioms",
    "deduce",
    "for",
    "from",
    "if",
    "in",
    "let",
    "line",
    "only",
    "prove",
    "show",
    "such",
    "that",
    "then",
    "the",
    "there",
    "use",
    "using",
    "which",
}


@dataclass
class LearningItem:
    kind: str
    number: str
    title: str
    section: str
    statement: str
    status: str = "todo"


@dataclass
class LearningPart:
    marker: str
    title: str
    statement: str


@dataclass
class Sheet:
    number: int
    pdf: str
    title: str
    section: str
    extracted_markdown: str
    items: list[LearningItem]
    source_markdowns: dict[str, str] = field(default_factory=dict)
    ocr_markdown: str = ""
    page_image_paths: list[str] = field(default_factory=list)


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Generate virtqio learning-project pages from PDF problem sheets."
    )
    parser.add_argument("config", type=Path, help="Learning project YAML config.")
    parser.add_argument(
        "--llm-command",
        help=(
            "Optional command that reads extracted JSON on stdin and writes refined "
            "JSON on stdout. This lets a local or remote LLM do NLP without tying "
            "the repo to one provider."
        ),
    )
    parser.add_argument(
        "--write-json",
        action="store_true",
        help="Also write extracted intermediate JSON beside the generated pages.",
    )
    parser.add_argument(
        "--no-enhance-math",
        action="store_true",
        help="Do not run the deterministic math-cleanup pass on extracted statements.",
    )
    parser.add_argument(
        "--disable-ocr",
        action="store_true",
        help="Do not render page images for Codex OCR and do not run local OCR heuristics.",
    )
    parser.add_argument(
        "--sheets",
        help="Comma-separated sheet numbers to generate, useful for debugging extraction.",
    )
    parser.add_argument(
        "--fast",
        action="store_true",
        help="Rewrite pages from cached sheet data only; skip PDF extraction, OCR, and Codex.",
    )
    parser.add_argument(
        "--refresh-cache",
        action="store_true",
        help="Ignore cached sheet data and refresh it from PDFs/LLM output.",
    )
    args = parser.parse_args()
    use_codex_by_default = args.llm_command is None
    if use_codex_by_default and not args.fast:
        if not is_codex_available():
            raise RuntimeError(
                "codex CLI is not available. Install/ authenticate codex or pass --llm-command explicitly."
            )
        llm_command: str | None = _CODex_DEFAULT_COMMAND
    else:
        llm_command = args.llm_command

    project_path = args.config
    project = load_yaml(project_path)
    repo_root = project_path.parent.parent
    output_dir = repo_root / project["output_dir"]
    cache_dir = repo_root / ".learning-cache" / project["id"]
    selected_sheets = parse_sheet_filter(args.sheets)
    enhance_math = not args.no_enhance_math
    sources = [
        source
        for source in project["sources"]
        if selected_sheets is None or int(source["sheet"]) in selected_sheets
    ]
    with tempfile.TemporaryDirectory(prefix="learning-projects-") as scratch_dir:
        scratch_root = Path(scratch_dir)
        sheets: list[Sheet] = []
        extracted_sheets: list[Sheet] = []
        for source in sources:
            cached_sheet = None if args.refresh_cache else load_cached_sheet(cache_dir, output_dir, source)
            if cached_sheet is not None:
                sheets.append(cached_sheet)
                continue
            if args.fast:
                raise RuntimeError(
                    f"No valid cache entry for sheet {source['sheet']}; run without --fast first."
                )
            extracted = extract_sheet(
                source,
                enhance_math=enhance_math,
                use_ocr=not args.disable_ocr,
                scratch_dir=scratch_root,
            )
            sheets.append(extracted)
            extracted_sheets.append(extracted)

        if llm_command and extracted_sheets:
            refined_by_number = {
                sheet.number: sheet for sheet in refine_with_llm(llm_command, project, extracted_sheets)
            }
            sheets = [
                refined_by_number.get(sheet.number, sheet)
                if any(extracted.number == sheet.number for extracted in extracted_sheets)
                else sheet
                for sheet in sheets
            ]

        if not args.fast:
            for sheet in sheets:
                write_cached_sheet(cache_dir, sheet)

        write_project_pages(project, output_dir, sheets)
        if args.write_json:
            write_intermediate_json(output_dir, project, sheets)

    print(f"Generated {len(sheets)} sheets in {output_dir}")
    return 0


def load_yaml(path: Path) -> dict[str, Any]:
    with path.open() as handle:
        return yaml.safe_load(handle)


def parse_sheet_filter(value: str | None) -> set[int] | None:
    if not value:
        return None
    return {int(part.strip()) for part in value.split(",") if part.strip()}


def load_cached_sheet(cache_dir: Path, output_dir: Path, source: dict[str, Any]) -> Sheet | None:
    cache_path = sheet_cache_path(cache_dir, int(source["sheet"]))
    if not cache_path.exists():
        return load_intermediate_cached_sheet(output_dir, source)
    try:
        payload = json.loads(cache_path.read_text())
    except (OSError, json.JSONDecodeError):
        return None
    if payload.get("cache_version") != _CACHE_VERSION:
        return None
    try:
        signature = source_signature(source)
    except OSError:
        return None
    if payload.get("source_signature") != signature:
        return None
    try:
        sheet = sheet_from_json(payload["sheet"])
    except (KeyError, TypeError, ValueError):
        return None
    sheet.page_image_paths = []
    return sheet


def load_intermediate_cached_sheet(output_dir: Path, source: dict[str, Any]) -> Sheet | None:
    intermediate_path = output_dir / "extracted.json"
    if not intermediate_path.exists():
        return None
    try:
        payload = json.loads(intermediate_path.read_text())
        sheet_number = int(source["sheet"])
        signature = source_signature(source)
    except (OSError, json.JSONDecodeError, KeyError, ValueError):
        return None
    for sheet_payload in payload.get("sheets", []):
        if int(sheet_payload.get("number", -1)) != sheet_number:
            continue
        if sheet_payload.get("pdf") != signature["pdf"]:
            continue
        try:
            sheet = sheet_from_json(sheet_payload)
        except (TypeError, ValueError):
            return None
        sheet.page_image_paths = []
        return sheet
    return None


def write_cached_sheet(cache_dir: Path, sheet: Sheet) -> None:
    cache_dir.mkdir(parents=True, exist_ok=True)
    cache_sheet = sheet_to_json(sheet)
    cache_sheet["page_image_paths"] = []
    payload = {
        "cache_version": _CACHE_VERSION,
        "source_signature": source_signature({"sheet": sheet.number, "pdf": sheet.pdf}),
        "sheet": cache_sheet,
    }
    sheet_cache_path(cache_dir, sheet.number).write_text(json.dumps(payload, indent=2))


def sheet_cache_path(cache_dir: Path, sheet_number: int) -> Path:
    return cache_dir / f"sheet-{sheet_number:02d}.json"


def source_signature(source: dict[str, Any]) -> dict[str, Any]:
    pdf_path = Path(source["pdf"]).expanduser()
    resolved = pdf_path.resolve()
    stat = resolved.stat()
    return {
        "sheet": int(source["sheet"]),
        "pdf": str(resolved),
        "size": stat.st_size,
        "mtime_ns": stat.st_mtime_ns,
    }


def extract_sheet(
    source: dict[str, Any],
    *,
    enhance_math: bool,
    use_ocr: bool,
    scratch_dir: Path,
) -> Sheet:
    sheet_number = int(source["sheet"])
    pdf_path = Path(source["pdf"]).expanduser()
    if not pdf_path.exists():
        raise FileNotFoundError(pdf_path)

    llm_markdown = clean_extracted_markdown(pymupdf4llm.to_markdown(str(pdf_path)))
    text_markdown = clean_extracted_text(extract_pdf_text(pdf_path))
    ocr_markdown = ""
    page_images: list[str] = []
    if use_ocr:
        page_images = render_pdf_page_images(
            pdf_path,
            scratch_dir / f"sheet-{sheet_number:02d}",
        )
        ocr_markdown = extract_ocr_markdown(page_images)
    source_markdowns = {
        "fitz_text": text_markdown,
        "pymupdf4llm": llm_markdown,
    }
    if ocr_markdown:
        source_markdowns["ocr_text"] = ocr_markdown

    markdown = choose_best_extraction(source_markdowns)
    section = infer_section(markdown, sheet_number)
    items = split_exercises(markdown, sheet_number, section)
    if enhance_math:
        items = enhance_items_math(items)

    return Sheet(
        number=sheet_number,
        pdf=str(pdf_path),
        title=f"Sheet {sheet_number}",
        section=section,
        extracted_markdown=markdown,
        source_markdowns=source_markdowns,
        ocr_markdown=ocr_markdown,
        page_image_paths=page_images,
        items=items,
    )


def clean_extracted_markdown(markdown: str) -> str:
    cleaned: list[str] = []
    for line in markdown.splitlines():
        stripped = line.strip()
        if not stripped:
            cleaned.append("")
            continue
        if re.match(r"^Page \d+ of \d+$", stripped):
            continue
        if stripped == "Mathematical Institute, University of Oxford":
            continue
        if "picture" in stripped and "intentionally omitted" in stripped:
            cleaned.append("[Formula or figure omitted by PDF extraction.]")
            continue
        line = line.replace("\x00", "")
        cleaned.append(line.rstrip())
    return collapse_blank_lines("\n".join(cleaned)).strip()


def extract_pdf_text(pdf_path: Path) -> str:
    with fitz.open(pdf_path) as document:
        return "\n".join(page.get_text("text") for page in document)


def choose_best_extraction(candidates: dict[str, str]) -> str:
    scored = [
        (name, text)
        for name, text in candidates.items()
        if text and text.strip()
    ]
    if not scored:
        return ""
    best = min(scored, key=lambda item: extraction_artifact_score(item[1]))[0]
    return candidates[best]


def extract_ocr_markdown(page_images: list[str]) -> str:
    if not page_images:
        return ""
    if not _TESSERACT_CMD:
        return ""
    lines: list[str] = []
    for index, image_path in enumerate(page_images, start=1):
        try:
            completed = subprocess.run(
                [
                    _TESSERACT_CMD,
                    image_path,
                    "stdout",
                    "--psm",
                    "6",
                ],
                capture_output=True,
                text=True,
                check=True,
            )
            page_text = completed.stdout.strip()
        except (subprocess.CalledProcessError, FileNotFoundError):
            return ""
        if not page_text:
            continue
        lines.append(f"Page {index}")
        lines.append(page_text)
        lines.append("")
    return "\n".join(lines).strip()


def render_pdf_page_images(pdf_path: Path, output_dir: Path) -> list[str]:
    output_dir.mkdir(parents=True, exist_ok=True)
    page_images: list[str] = []
    matrix = fitz.Matrix(2, 2)
    try:
        zoom = _DEFAULT_RENDER_DPI / 72.0
        matrix = fitz.Matrix(zoom, zoom)
    except Exception:
        matrix = fitz.Matrix(2, 2)

    with fitz.open(pdf_path) as document:
        for page_number, page in enumerate(document, start=1):
            pix = page.get_pixmap(matrix=matrix)
            image_path = output_dir / f"page-{page_number:02d}.png"
            pix.save(str(image_path))
            if image_path.exists():
                page_images.append(str(image_path))
    return page_images


def is_codex_available() -> bool:
    return shutil.which("codex") is not None


def codex_refinement_prompt() -> str:
    return """
You are a specialist at OCR and math cleanup for an SSG educational workflow.
You receive a JSON object on stdin with:
- project metadata
- sheets, where each sheet has:
  - extracted markdown (`extracted_markdown`)
  - candidate raw sources in `source_markdowns`
  - attached page image file paths in `page_image_paths`
  - current `items` with kind, number, title, section, and statement

Your goal is to produce the best possible transcription for each sheet while making the
smallest possible edit.
Copy the input `extracted_markdown` and `items` first, then apply only local corrections
for clearly broken OCR artifacts.
Only use page images as evidence when the nearby text is clearly unreadable in the text sources.

Return a JSON object with the same top-level shape:
- keep `project`
- keep `sheets` as an array of sheet objects
For each sheet, output:
- `number`, `pdf`, `title`, `section`, `extracted_markdown`
- `items` (exercise objects with kind, number, title, section, statement, status)
- optional: `source_markdowns`, `ocr_markdown`, `page_image_paths`

Editing constraints:
- Keep exercise numbers, headings, and order. Do not reorder content.
- Preserve meaning; do not solve any exercise.
- Do not invent missing results or hidden formulas.
- Never algebraically rewrite expressions or replace valid mathematical content with a different formula.
- If a part is unreadable after best effort, use exactly:
  [Formula or figure omitted by PDF extraction.]
- Use the attached images to fix math and transcription errors only when a source token is clearly corrupted.
- Apply SSG shorthand/compact math where it improves rendering.
- For sums and products, use supported operator syntax, for example
  `$sum(a_k)$`, `$sum[k=1..inf](a_k)$`, or `$prod[k=1..n](a_k)$`;
  never use bare `$sum a_k$` or malformed `sum[k >= 1] a_k`.
- Do not change section titles unless there is obvious OCR corruption.

Output requirements:
- strict JSON only; no markdown, no commentary.
- valid for `sheet_from_json` and `sheet_to_json` shapes.
"""


def codex_refinement_schema() -> dict[str, Any]:
    return {
        "type": "object",
        "required": ["project", "sheets"],
        "properties": {
            "project": {"type": "object"},
            "sheets": {
                "type": "array",
                "items": {
                    "type": "object",
                    "required": ["number", "pdf", "title", "section", "extracted_markdown", "items"],
                        "properties": {
                            "number": {"type": "integer"},
                            "pdf": {"type": "string"},
                            "title": {"type": "string"},
                            "section": {"type": "string"},
                            "extracted_markdown": {"type": "string"},
                            "source_markdowns": {"type": "object", "additionalProperties": {"type": "string"}},
                            "ocr_markdown": {"type": "string"},
                            "page_image_paths": {"type": "array", "items": {"type": "string"}},
                            "items": {
                                "type": "array",
                                "items": {
                                "type": "object",
                                "required": ["kind", "number", "title", "section", "statement", "status"],
                                "properties": {
                                    "kind": {"type": "string"},
                                    "number": {"type": "string"},
                                    "title": {"type": "string"},
                                    "section": {"type": "string"},
                                    "statement": {"type": "string"},
                                    "status": {"type": "string"},
                                },
                            },
                        },
                    },
                },
            },
        },
    }


def build_codex_command(output_path: Path, image_paths: list[str], prompt: str) -> list[str]:
    command = [
        "codex",
        "exec",
        "--sandbox",
        "workspace-write",
        "--output-last-message",
        str(output_path),
    ]
    for image_path in image_paths:
        command.extend(["--image", image_path])
    command.append(prompt)
    return command


def extraction_artifact_score(text: str) -> int:
    return (
        text.count("[Formula or figure omitted by PDF extraction.]") * 10
        + text.count("][") * 3
        + text.count("$ $") * 3
        + text.count("�") * 5
        + len(re.findall(r"\$[^$\n]*\$\s+\$[^$\n]*\$", text))
    )


def clean_extracted_text(text: str) -> str:
    lines = [normalize_pdf_text_line(line) for line in text.splitlines()]
    lines = [line for line in lines if keep_pdf_text_line(line)]
    lines = merge_pdf_text_lines(lines)
    return collapse_blank_lines("\n".join(lines)).strip()


def normalize_pdf_text_line(line: str) -> str:
    line = line.replace("\x12", "(").replace("\x13", ")")
    line = line.replace("\x14", "[").replace("\x15", "]")
    line = re.sub(r"[\x00-\x08\x0b-\x1f]", "", line)
    return re.sub(r"\s+", " ", line).strip()


def keep_pdf_text_line(line: str) -> bool:
    if not line:
        return True
    lower = line.lower()
    if line == "Analysis I" or line in {"—", "MT22"}:
        return False
    if re.fullmatch(r"Sheet \d+", line):
        return False
    if "mathematical institute, university of oxford" in lower:
        return False
    if re.fullmatch(r"Page \d+ of \d+", line):
        return False
    if re.fullmatch(r"Analysis I: Sheet \d+ — MT22", line):
        return False
    return True


def merge_pdf_text_lines(lines: list[str]) -> list[str]:
    merged: list[str] = []
    paragraph: list[str] = []
    pending_marker: str | None = None

    def flush_paragraph() -> None:
        nonlocal paragraph
        if paragraph:
            merged.append(" ".join(paragraph).strip())
            paragraph = []

    for line in lines:
        if not line:
            flush_paragraph()
            if merged and merged[-1] != "":
                merged.append("")
            continue

        exercise_start = re.match(r"^(\d+)\.(?:\s+(.*))?$", line)
        subpart_start = re.match(r"^\(([a-z]|[ivxlcdm]+)\)(?:\s+(.*))?$", line)

        if exercise_start:
            flush_paragraph()
            rest = exercise_start.group(2)
            if rest:
                merged.append(f"{exercise_start.group(1)}. {rest}".rstrip())
            else:
                merged.append(f"{exercise_start.group(1)}.")
            continue

        if subpart_start:
            flush_paragraph()
            marker = f"({subpart_start.group(1)})"
            rest = subpart_start.group(2)
            if rest:
                merged.append(f"   - {marker} {rest}".rstrip())
            else:
                pending_marker = marker
            continue

        if pending_marker:
            flush_paragraph()
            merged.append(f"   - {pending_marker} {line}".rstrip())
            pending_marker = None
            continue

        if is_display_formula_line(line):
            flush_paragraph()
            merged.append(f"${format_math_fragment(line)}$")
            continue

        paragraph.append(line)

    flush_paragraph()
    return merged


def is_display_formula_line(line: str) -> bool:
    if len(line) > 80:
        return False
    if not re.search(r"[<>=+\-*/^|{}()[\]∈∉∪∩√⩽⩾≤≥]", line):
        return False
    words = re.findall(r"[A-Za-z]{4,}", line)
    return len(words) == 0


def collapse_blank_lines(text: str) -> str:
    return re.sub(r"\n{3,}", "\n\n", text)


def infer_section(markdown: str, sheet_number: int) -> str:
    for heading in re.findall(r"^##\s+\**(.+?)\**\s*$", markdown, re.MULTILINE):
        normalized = re.sub(r"[*_]", "", heading).strip()
        if not normalized:
            continue
        lower = normalized.lower()
        if "analysis i" in lower or f"sheet {sheet_number}" in lower:
            continue
        return normalized
    for line in markdown.splitlines():
        normalized = re.sub(r"[*_]", "", line).strip()
        lower = normalized.lower()
        if not normalized:
            continue
        if "analysis i" in lower or f"sheet {sheet_number}" in lower:
            continue
        if re.match(r"^\d+\.", normalized):
            break
        if len(normalized) > 8:
            return normalized
    return f"Sheet {sheet_number}"


def split_exercises(markdown: str, sheet_number: int, section: str) -> list[LearningItem]:
    starts = list(re.finditer(r"(?m)^\s*(?:-\s*)?(\d+)\.(?:\s+|$)", markdown))
    if not starts:
        return [
            LearningItem(
                kind="exercise",
                number="1",
                title="Exercise 1",
                section=section,
                statement=strip_sheet_headers(markdown).strip(),
            )
        ]

    items: list[LearningItem] = []
    for index, match in enumerate(starts):
        number = match.group(1)
        end = starts[index + 1].start() if index + 1 < len(starts) else len(markdown)
        statement = markdown[match.start() : end].strip()
        statement = strip_sheet_headers(statement).strip()
        if re.fullmatch(rf"{number}\\.", statement):
            statement = f"{number}.\n[Formula or figure omitted by PDF extraction.]"
        if not statement:
            continue
        items.append(
            LearningItem(
                kind="exercise",
                number=number,
                title=f"Exercise {number}",
                section=section,
                statement=statement,
            )
        )
    return items


def strip_sheet_headers(text: str) -> str:
    lines = []
    for line in text.splitlines():
        stripped = re.sub(r"[*_]", "", line).strip()
        lower = stripped.lower()
        if lower == "## analysis i" or "analysis i: sheet" in lower:
            continue
        if re.match(r"^##\s+.*sheet\s+\d+", line, re.IGNORECASE):
            continue
        lines.append(line)
    return collapse_blank_lines("\n".join(lines))


def enhance_items_math(items: list[LearningItem]) -> list[LearningItem]:
    return [
        LearningItem(
            kind=item.kind,
            number=item.number,
            title=item.title,
            section=item.section,
            statement=enhance_statement_math(item.statement),
            status=item.status,
        )
        for item in items
    ]


def enhance_statement_math(statement: str) -> str:
    return "\n".join(enhance_math_line(line) for line in statement.splitlines())


def enhance_math_line(line: str) -> str:
    if line.strip() == "[Formula or figure omitted by PDF extraction.]":
        return line
    if is_complex_extraction_line(line):
        return minimal_cleanup_line(line)

    line = normalize_unicode_math(line)
    line = normalize_plain_number_systems(line)
    line = normalize_plain_powers(line)
    line = wrap_plain_subpart_math(line)

    line = re.sub(
        r"\b([RNZQC])\[(>=|<=|>|<|=)\]\[(\d+)\]",
        lambda m: f"$bb{{{m.group(1)}}}_{{{m.group(2)} {m.group(3)}}}$",
        line,
    )
    line = re.sub(
        r"\b([RNZQC])\[(\d+)\]",
        lambda m: f"$bb{{{m.group(1)}}}^{m.group(2)}$",
        line,
    )
    line = re.sub(
        r"_\s*\|\s*([A-Za-z][A-Za-z0-9]*)\s*\|\s*_",
        lambda m: f"$abs({format_identifier(m.group(1))})$",
        line,
    )
    line = re.sub(
        r"_([A-Za-zαβγδεθλμω]+)_\[(\d+|[A-Za-zαβγδεθλμω]+)\]",
        lambda m: f"${format_identifier(m.group(1))}^{format_identifier(m.group(2))}$",
        line,
    )
    line = re.sub(
        r"_([A-Za-zαβγδεθλμω]+)\[([+\-]?\d+|[+\-]?[A-Za-zαβγδεθλμω]+)\]_",
        lambda m: f"${format_identifier(m.group(1))}^{{{format_math_fragment(m.group(2))}}}$",
        line,
    )
    line = re.sub(
        r"_([A-Za-zαβγδεθλμω]+)\s*!\s*_\s*=\s*([0-9A-Za-zαβγδεθλμω]+)",
        lambda m: f"${format_identifier(m.group(1))} != {format_identifier(m.group(2))}$",
        line,
    )
    line = re.sub(
        r"_\s*(<=|>=|!=|=|<|>)\s*([A-Za-zαβγδεθλμω]+)_\[(\d+)\]",
        lambda m: f"${m.group(1)} {format_identifier(m.group(2))}^{m.group(3)}$",
        line,
    )
    line = re.sub(
        r"_\[sqrt\]\s*([A-Za-z0-9]+)_?",
        lambda m: f"$\\sqrt{{{format_identifier(m.group(1))}}}$",
        line,
    )
    line = re.sub(
        r"_sqrt_\s*(\d+|[A-Za-z]+)",
        lambda m: f"$\\sqrt{{{format_identifier(m.group(1))}}}$",
        line,
    )
    line = re.sub(
        r"\b([a-zA-Z])\[(\d+)\]",
        lambda m: f"${format_identifier(m.group(1))}^{m.group(2)}$",
        line,
    )

    line = cleanup_extraction_brackets(line)
    line = re.sub(r"_([^_\n]+)_", replace_italic_math, line)
    line = wrap_relation_fragments(line)
    line = compact_inline_math(line)
    return line


def is_complex_extraction_line(line: str) -> bool:
    if "�" in line:
        return True
    if line.count("[") >= 5:
        return True
    return False


def minimal_cleanup_line(line: str) -> str:
    line = line.replace("\x00", "")
    line = line.replace("⩽", "<=").replace("≤", "<=")
    line = line.replace("⩾", ">=").replace("≥", ">=")
    line = line.replace("−", "-").replace("–", "-")
    line = line.replace("→", "->")
    line = line.replace("�", "[unreadable math symbol]")
    return line


def normalize_unicode_math(text: str) -> str:
    replacements = {
        "⩽": "<=",
        "≤": "<=",
        "⩾": ">=",
        "≥": ">=",
        "̸": "!",
        "−": "-",
        "–": "-",
        "→": "->",
        "∞": "inf",
        "∈": " in ",
        "∉": " notin ",
        "∪": " union ",
        "∩": " inter ",
        "√": "sqrt",
        "ε": "eps",
        "α": "alpha",
        "β": "beta",
        "γ": "gamma",
        "θ": "theta",
        "λ": "lambda",
        "ω": "omega",
        "· · ·": "...",
        "�": "[unreadable math symbol]",
    }
    for old, new in replacements.items():
        text = text.replace(old, new)
    text = re.sub(r"!\s*=", "!=", text)
    text = re.sub(r"\s{2,}", " ", text)
    return text


def normalize_plain_number_systems(line: str) -> str:
    line = re.sub(
        r"\b([RNZQC])\s*(>=|<=|>|<|=)\s*(\d+)\b",
        lambda m: f"$bb{{{m.group(1)}}}_{{{m.group(2)} {m.group(3)}}}$",
        line,
    )
    line = re.sub(
        r"\b([RNZC])(\d+)\b",
        lambda m: f"$bb{{{m.group(1)}}}^{m.group(2)}$",
        line,
    )
    line = re.sub(r"(?<!\{)\b([RNZQC])\b(?!\})", lambda m: f"$bb{{{m.group(1)}}}$", line)
    return line


def normalize_plain_powers(line: str) -> str:
    return re.sub(r"\b([a-z])(\d+)\b", lambda m: f"{m.group(1)}^{m.group(2)}", line)


def wrap_plain_subpart_math(line: str) -> str:
    match = re.match(r"^(\s*-\s+\([a-zivxlcdm]+\)\s+)(.+?)([.;])?$", line)
    if not match:
        return line
    prefix, body, punctuation = match.groups()
    body = body.strip()
    if is_math_fragment(body) and not has_prose_words(body):
        return f"{prefix}${format_math_fragment(body)}${punctuation or ''}"
    return line


def cleanup_extraction_brackets(text: str) -> str:
    text = re.sub(r"\[([A-Za-z][A-Za-z ]*)\]", r" \1 ", text)
    text = re.sub(r"\[([.,;:!?])\]", r"\1", text)
    text = text.replace("[(]", "(").replace("[)]", ")")
    text = text.replace("[{]", "{").replace("[}]", "}")
    text = text.replace("[|]", "|")
    return text


def replace_italic_math(match: re.Match[str]) -> str:
    fragment = match.group(1).strip()
    if not is_math_fragment(fragment):
        return match.group(0)
    formatted = format_math_fragment(fragment)
    return f"${formatted}$"


def is_math_fragment(fragment: str) -> bool:
    if not fragment:
        return False
    if len(fragment) > 48:
        return False
    if has_prose_words(fragment):
        return False
    if re.search(r"[<>=+\-*/^|{}()[\],]", fragment):
        return True
    words = re.findall(r"[A-Za-z]+", fragment)
    if len(words) == 1 and is_math_identifier(words[0]):
        return True
    return bool(words) and all(
        word in {"in", "notin", "eps", "inf", "sqrt"} or is_math_identifier(word)
        for word in words
    )


def has_prose_words(fragment: str) -> bool:
    words = re.findall(r"[A-Za-z]{2,}", fragment)
    return any(word.lower() in PROSE_WORDS for word in words)


def is_math_identifier(value: str) -> bool:
    if value in {
        "in",
        "notin",
        "eps",
        "del",
        "inf",
        "alpha",
        "beta",
        "gamma",
        "theta",
        "lambda",
        "omega",
    }:
        return True
    return bool(re.fullmatch(r"[A-Za-z]{1,3}", value))


def format_math_fragment(fragment: str) -> str:
    fragment = normalize_unicode_math(fragment)
    fragment = cleanup_extraction_brackets(fragment)
    fragment = fragment.strip()
    protected = {
        "in",
        "notin",
        "eps",
        "del",
        "inf",
        "alpha",
        "beta",
        "gamma",
        "theta",
        "lambda",
        "omega",
    }
    if fragment in protected:
        return fragment
    fragment = re.sub(
        r"\b([RNZQC])\s*(>=|<=|>|<|=)\s*(\d+)\b",
        lambda m: f"bb{{{m.group(1)}}}_{{{m.group(2)} {m.group(3)}}}",
        fragment,
    )
    fragment = re.sub(
        r"\b([RNZC])(\d+)\b",
        lambda m: f"bb{{{m.group(1)}}}^{m.group(2)}",
        fragment,
    )
    fragment = re.sub(r"(?<!\{)\b([RNZQC])\b(?!\})", lambda m: f"bb{{{m.group(1)}}}", fragment)
    fragment = re.sub(
        r"\b([A-Za-z])([0-9]+)\b",
        lambda m: f"{m.group(1)}^{m.group(2)}",
        fragment,
    )
    fragment = re.sub(
        r"\b(?!in\b|inf\b)([A-Za-z])([nmkrs])\b",
        lambda m: f"{m.group(1)}_{m.group(2)}",
        fragment,
    )
    fragment = re.sub(
        r"\b([A-Za-z])([nmkrs])([A-Za-z])\b",
        lambda m: f"{m.group(1)}_{m.group(2)}{m.group(3)}",
        fragment,
    )
    for name in ["eps", "alpha", "beta", "gamma", "theta", "lambda", "omega", "inf"]:
        fragment = re.sub(rf"\b{name}\b", name, fragment)
    return fragment


def format_identifier(identifier: str) -> str:
    identifier = normalize_unicode_math(identifier).strip()
    protected = {
        "in",
        "notin",
        "eps",
        "del",
        "inf",
        "eps",
        "alpha",
        "beta",
        "gamma",
        "theta",
        "lambda",
        "omega",
    }
    if identifier in protected:
        return identifier
    if len(identifier) == 2 and identifier[1] in "nmkrs":
        return f"{identifier[0]}_{identifier[1]}"
    return identifier


def wrap_relation_fragments(line: str) -> str:
    line = re.sub(
        r"(?<!\$)\b([A-Za-z](?:\s*\+\s*[A-Za-z])+)\s*(<=|>=|!=|=|<|>)\s*([A-Za-z](?:\s*\+\s*[A-Za-z])+)\b",
        lambda m: f"${format_math_fragment(m.group(1))} {m.group(2)} {format_math_fragment(m.group(3))}$",
        line,
    )
    line = re.sub(
        r"(?<!\$)\b([A-Za-z]{1,4}(?:_[A-Za-z])?(?:\^\d+)?|\d+)\s*(<=|>=|!=|->|<|>)\s*([A-Za-z]{1,4}(?:_[A-Za-z])?(?:\^\d+)?|\d+)(?!\$)",
        lambda m: f"${m.group(1)} {m.group(2)} {m.group(3)}$",
        line,
    )
    return line


def compact_inline_math(line: str) -> str:
    operators = r"=|<=|>=|!=|->|<|>|\+|-|\*|/"
    previous = None
    while previous != line:
        previous = line
        line = re.sub(
            r"\$([^$\n]+)\$\s*\(\s*\$([^$\n]+)\$\s*\)",
            lambda m: f"${m.group(1).strip()}({m.group(2).strip()})$",
            line,
        )
        line = re.sub(
            r"\(\s*\$([^$\n]+)\$\s*\)",
            lambda m: f"$({m.group(1).strip()})$",
            line,
        )
        line = re.sub(
            rf"\$([^$\n]+)\$\s*({operators})\s*\$([^$\n]+)\$",
            lambda m: f"${m.group(1).strip()} {m.group(2)} {m.group(3).strip()}$",
            line,
        )
        line = re.sub(
            rf"\$([^$\n]+)\$\s*\$\s*({operators})\s*([^$\n]+)\$",
            lambda m: f"${m.group(1).strip()} {m.group(2)} {m.group(3).strip()}$",
            line,
        )
        line = re.sub(
            rf"\$([^$\n]+?)\s*({operators})\$\s*([0-9]+)",
            lambda m: f"${m.group(1).strip()} {m.group(2)} {m.group(3)}$",
            line,
        )
        line = re.sub(
            rf"\$([^$\n]+)\$\s*({operators})\s*([0-9]+)",
            lambda m: f"${m.group(1).strip()} {m.group(2)} {m.group(3)}$",
            line,
        )
        line = re.sub(
            rf"([0-9]+)\s*({operators})\s*\$([^$\n]+)\$",
            lambda m: f"${m.group(1)} {m.group(2)} {m.group(3).strip()}$",
            line,
        )
    return line


def refine_with_llm(command: str, project: dict[str, Any], sheets: list[Sheet]) -> list[Sheet]:
    payload = {
        "project": project,
        "instructions": (
            "Clean up the extracted exercise/theorem statements for a static site. "
            "Preserve the original mathematical meaning, do not solve anything, "
            "do not invent formulas that were omitted by extraction, and use SSG "
            "math shorthand inside $...$ for concise readable math."
        ),
        "ssg_math_shorthand": SSG_MATH_SHORTHAND_REFERENCE,
        "sheets": [sheet_to_json(sheet) for sheet in sheets],
    }
    if command == _CODex_DEFAULT_COMMAND:
        refined_sheets: list[Sheet] = []
        for sheet in sheets:
            sheet_payload = dict(payload)
            sheet_payload["sheets"] = [sheet_to_json(sheet)]
            sheet_payload["task"] = (
                "OCR and transcription cleanup using page images as primary evidence."
            )
            payload_json = json.dumps(sheet_payload, ensure_ascii=False)
            with tempfile.TemporaryDirectory(prefix="learning-codex-") as tmp:
                output_path = Path(tmp) / "codex-refined.json"
                image_paths = sorted({path for path in sheet.page_image_paths if path})
                command = build_codex_command(
                    output_path,
                    image_paths,
                    codex_refinement_prompt(),
                )
                try:
                    raw_output = run_codex_command(command, payload_json)
                except RuntimeError:
                    print(
                        f"warning: Codex refinement failed for sheet {sheet.number}; using local extraction.",
                        file=sys.stderr,
                    )
                    refined_sheets.append(sheet)
                    continue
            try:
                refined = parse_refinement_response(raw_output, output_path)
            except (ValueError, json.JSONDecodeError):
                print(
                    f"warning: Codex refinement returned malformed JSON for sheet {sheet.number}; using local extraction.",
                    file=sys.stderr,
                )
                refined_sheets.append(sheet)
                continue
            candidates = refined.get("sheets", [])
            if not candidates:
                refined_sheets.append(sheet)
                continue
            refined_sheets.extend([merge_refined_sheet(sheet_from_json(candidate), sheet) for candidate in candidates])
        return refined_sheets

    payload_json = json.dumps(payload, ensure_ascii=False)
    try:
        completed = subprocess.run(
            command,
            input=payload_json,
            text=True,
            shell=True,
            check=True,
            capture_output=True,
        )
        raw_output = completed.stdout
    except subprocess.CalledProcessError as exc:
        raise RuntimeError(exc.stderr or exc.stdout) from exc
    refined = parse_refinement_response(raw_output, None)
    return [sheet_from_json(sheet) for sheet in refined["sheets"]]


def run_codex_command(command: list[str], payload_json: str) -> str:
    try:
        completed = subprocess.run(
            command,
            input=payload_json,
            text=True,
            check=True,
            capture_output=True,
            timeout=180,
        )
    except subprocess.TimeoutExpired as exc:
        raise RuntimeError("Codex refinement timed out.") from exc
    except subprocess.CalledProcessError as exc:
        raise RuntimeError(exc.stderr or exc.stdout) from exc
    return completed.stdout


def parse_refinement_response(raw_output: str, output_path: Path | None) -> dict[str, Any]:
    if output_path is not None and output_path.exists():
        try:
            candidate_payload = output_path.read_text()
            response_payload = extract_json(candidate_payload)
            repaired_payload = repair_json_payload(response_payload)
            return json.loads(repaired_payload)
        except Exception:
            pass
    response_payload = extract_json(raw_output)
    repaired_payload = repair_json_payload(response_payload)
    try:
        return json.loads(repaired_payload)
    except json.JSONDecodeError:
        repaired = re.sub(
            r"(?<!\\)\\(?![\"\\\\/bfnrtu])",
            r"\\\\",
            repaired_payload,
        )
        return json.loads(repaired)


def repair_json_payload(payload: str) -> str:
    payload = payload.strip()
    payload = re.sub(r",(\s*[}\]])", r"\1", payload)
    return payload


def unescape_text_artifacts(text: str) -> str:
    if not isinstance(text, str):
        return text
    return text.replace("\b", "\\b")


def merge_refined_sheet(refined: Sheet, original: Sheet) -> Sheet:
    def normalize_statement(statement: str) -> str:
        statement = unescape_text_artifacts(statement)
        statement = statement.strip()
        if statement and re.fullmatch(r"\d+\.\s*", statement):
            statement = f"{statement}\n[Formula or figure omitted by PDF extraction.]"
        statement = statement.replace("ℝ", "bb{R}").replace("ℂ", "bb{C}")
        return normalize_supported_math_shorthand(statement)

    def accept_refinement(item_original: str, item_refined: str, number: str) -> str:
        original = unescape_text_artifacts(item_original).strip()
        refined = unescape_text_artifacts(item_refined).strip()
        if is_minimal_or_missing_statement(original):
            return refined if refined else f"{number}.\n[Formula or figure omitted by PDF extraction.]"
        if not refined:
            return original
        if not refined.startswith(f"{number}."):
            return original
        if similarity_ratio(original, refined) < 0.95:
            return original
        if contains_garbled_ocr(refined) and not contains_garbled_ocr(original):
            return original
        return refined

    refined_extracted_markdown = normalize_statement(
        refined.extracted_markdown or original.extracted_markdown
    )
    markdown_items = split_exercises(
        refined_extracted_markdown,
        refined.number,
        normalize_statement(refined.section or original.section),
    )

    refined_items_by_number = {
        item.number: item for item in (refined.items if refined.items else [])
    }
    merged_items: list[LearningItem] = []
    for original_item in original.items:
        candidate = refined_items_by_number.get(original_item.number)
        if candidate is None:
            merged_items.append(original_item)
            continue
        merged_items.append(
            LearningItem(
                kind=candidate.kind,
                number=candidate.number,
                title=candidate.title,
                section=candidate.section,
                status=candidate.status or original_item.status,
                statement=accept_refinement(
                    original_item.statement,
                    normalize_statement(candidate.statement),
                    candidate.number,
                ),
            )
        )

    for candidate in (refined.items or []):
        if all(existing.number != candidate.number for existing in original.items):
            merged_items.append(candidate)

    item_sets = [original.items, merged_items]
    if markdown_items:
        item_sets.append(markdown_items)
    best_items = min(item_sets, key=items_artifact_score)

    return Sheet(
        number=refined.number,
        pdf=unescape_text_artifacts(refined.pdf) or original.pdf,
        title=normalize_statement(refined.title or original.title),
        section=normalize_statement(refined.section or original.section),
        extracted_markdown=refined_extracted_markdown,
        items=best_items,
        source_markdowns=unescape_text_artifacts_json_object(refined.source_markdowns)
        if refined.source_markdowns
        else original.source_markdowns,
        ocr_markdown=refined.ocr_markdown or original.ocr_markdown,
        page_image_paths=(
            refined.page_image_paths
            if refined.page_image_paths
            else original.page_image_paths
        ),
    )


def items_artifact_score(items: list[LearningItem]) -> int:
    text = "\n\n".join(item.statement for item in items)
    return (
        extraction_artifact_score(text)
        + text.count("\nX\n") * 20
        + text.count("\nZ ") * 20
        + text.count("$sqrt$") * 10
        + text.count("$$") * 10
        + text.count("�") * 20
        + len(re.findall(r"\$[^$\n]{0,4}\$", text)) * 2
        + len(re.findall(r"\b(?:an|bn|cn|sn|ak|zn)\b", text)) * 2
    )


def normalize_supported_math_shorthand(text: str) -> str:
    replacements = [
        (r"\$sum\s+a_k\$", "$sum[k=1..inf](a_k)$"),
        (r"\$sum\s+\(a_k\)\^2\$", "$sum[k=1..inf]((a_k)^2)$"),
        (r"\$sum\s+\(a_k\)\^3\$", "$sum[k=1..inf]((a_k)^3)$"),
        (r"\$sum\s+a_k/\(1\+a_k\)\$", "$sum[k=1..inf](a_k/(1+a_k))$"),
        (r"\$sum\s+a_k/s_k\$", "$sum[k=1..inf](a_k/s_k)$"),
    ]
    for pattern, replacement in replacements:
        text = re.sub(pattern, replacement, text)
    text = re.sub(
        r"\$sum\[k\s*>=\s*1\]\s+([^$\n]+)\$",
        lambda match: f"$sum[k=1..inf]({match.group(1).strip()})$",
        text,
    )
    text = re.sub(
        r"\$sum\[k=1\.\.inf\]\s+([^$\n]+)\$",
        lambda match: f"$sum[k=1..inf]({match.group(1).strip()})$",
        text,
    )
    return text


def unescape_text_artifacts_json_object(data: Any) -> dict[str, Any]:
    if isinstance(data, dict):
        return {
            unescape_text_artifacts(key): unescape_text_artifacts_json_object(value)
            for key, value in data.items()
        }
    if isinstance(data, list):
        return [unescape_text_artifacts_json_object(item) for item in data]
    if isinstance(data, str):
        return unescape_text_artifacts(data)
    return data


def is_minimal_or_missing_statement(statement: str) -> bool:
    return bool(
        re.fullmatch(
            rf"{re.escape(statement.split('.')[0].strip())}\.\s*(?:$|\n\s*\[Formula or figure omitted by PDF extraction\.\])",
            statement.strip(),
        )
    )


def contains_garbled_ocr(statement: str) -> bool:
    return bool(
        re.search(
            r"\bX\b|\bZ\b|∞\s*X|√\s*[A-Za-z]|\b[a-z]_[a-z]_[a-z]\b|(\n|\\n)(\s*[a-zA-Z]{1,2}\s*){2,}\n",
            statement.replace("\n", "\n"),
        )
    )


def similarity_ratio(left: str, right: str) -> float:
    left = re.sub(r"\s+", " ", left.strip())
    right = re.sub(r"\s+", " ", right.strip())
    if not left or not right:
        return 0.0
    return difflib.SequenceMatcher(None, left, right).ratio()


def extract_json(text: str) -> str:
    stripped = text.strip()
    if stripped.startswith("```"):
        match = re.search(r"```(?:json)?\s*(\{.*\})\s*```", stripped, re.S)
        if not match:
            raise ValueError("Could not find JSON output in LLM response.")
        return match.group(1)
    if stripped.startswith("{") and stripped.endswith("}"):
        return stripped
    for match in re.finditer(r"\{.*\}", stripped, re.S):
        candidate = match.group(0)
        try:
            json.loads(candidate)
        except json.JSONDecodeError:
            continue
        return candidate
    return stripped


def write_project_pages(project: dict[str, Any], output_dir: Path, sheets: list[Sheet]) -> None:
    sheets_dir = output_dir / "sheets"
    sheets_dir.mkdir(parents=True, exist_ok=True)
    write_progress(project, output_dir)
    old_progress = output_dir / "progress.md"
    if old_progress.exists():
        old_progress.unlink()
    for sheet in sheets:
        write_sheet(project, sheets_dir, sheet)


def write_progress(project: dict[str, Any], output_dir: Path) -> None:
    title = project["title"]
    description = project.get("description", "").strip()
    description_block = f"\n{description}\n" if description else ""
    content = f"""# {title}
{description_block}
:::learning-progress root="sheets" title="{title} Progress"
:::
"""
    (output_dir / "index.md").write_text(content)


def write_sheet(project: dict[str, Any], sheets_dir: Path, sheet: Sheet) -> None:
    slug = sheet_slug(sheet.number)
    lines = [
        f"# {project['title']}: {sheet.title}",
        "",
        f"Source: `{sheet.pdf}`",
        "",
        f"Section: **{sheet.section}**",
        "",
        "[Project progress](../index.html)",
        "",
    ]
    for item in sheet.items:
        preamble, parts = split_item_into_parts(item)
        lines.extend([f"## {item.title}", ""])
        if parts:
            if preamble:
                lines.extend([preamble, ""])
            for part in parts:
                part_slug = slugify_part_marker(part.marker)
                item_id = (
                    f"{project['id']}-sheet-{sheet.number:02d}-"
                    f"{item.kind}-{item.number}-{part_slug}"
                )
                lines.extend(
                    learning_item_block(
                        item=item,
                        item_id=item_id,
                        title=part.title,
                        statement=part.statement,
                    )
                )
        else:
            item_id = f"{project['id']}-sheet-{sheet.number:02d}-{item.kind}-{item.number}"
            lines.extend(
                learning_item_block(
                    item=item,
                    item_id=item_id,
                    title=item.title,
                    statement=item.statement,
                )
            )
    (sheets_dir / f"{slug}.md").write_text("\n".join(lines).strip() + "\n")


def learning_item_block(
    *,
    item: LearningItem,
    item_id: str,
    title: str,
    statement: str,
) -> list[str]:
    statement = normalize_supported_math_shorthand(statement.strip())
    return [
        (
            f':::learning-item type={item.kind} id="{item_id}" '
            f'section="{item.section}" status={item.status} title="{title}"'
        ),
        statement,
        ":::",
        "",
        ":::proof[Solution]",
        "Write the solution here, then change the tracked item status to done.",
        ":::",
        "",
    ]


def split_item_into_parts(item: LearningItem) -> tuple[str, list[LearningPart]]:
    lines = item.statement.strip().splitlines()
    starts: list[tuple[int, str, str]] = []
    part_pattern = re.compile(
        r"^\s*(?:-\s*)?\(([a-z]|[ivxlcdm]+)\)\s*(.*)$",
        re.IGNORECASE,
    )
    for index, line in enumerate(lines):
        match = part_pattern.match(line)
        if match:
            starts.append((index, match.group(1).lower(), match.group(2).strip()))
    if not starts:
        return "", []

    first_part_line = starts[0][0]
    preamble = "\n".join(lines[:first_part_line]).strip()
    parts: list[LearningPart] = []
    for start_index, (line_index, marker, first_line) in enumerate(starts):
        end_line = starts[start_index + 1][0] if start_index + 1 < len(starts) else len(lines)
        part_lines = [first_line] if first_line else []
        part_lines.extend(lines[line_index + 1 : end_line])
        part_statement = f"({marker}) " + "\n".join(part_lines).strip()
        title = f"{item.title}({marker})"
        parts.append(
            LearningPart(
                marker=marker,
                title=title,
                statement=part_statement.strip(),
            )
        )
    return preamble, parts


def slugify_part_marker(marker: str) -> str:
    return re.sub(r"[^a-z0-9]+", "-", marker.lower()).strip("-")


def write_intermediate_json(output_dir: Path, project: dict[str, Any], sheets: list[Sheet]) -> None:
    payload = {"project": project, "sheets": [sheet_to_json(sheet) for sheet in sheets]}
    (output_dir / "extracted.json").write_text(json.dumps(payload, indent=2))


def sheet_slug(number: int) -> str:
    return f"sheet-{number:02d}"


def sheet_to_json(sheet: Sheet) -> dict[str, Any]:
    data = asdict(sheet)
    data["items"] = [asdict(item) for item in sheet.items]
    return data


def sheet_from_json(data: dict[str, Any]) -> Sheet:
    return Sheet(
        number=int(data["number"]),
        pdf=data.get("pdf", ""),
        title=data.get("title", f"Sheet {data['number']}"),
        section=data.get("section", f"Sheet {data['number']}"),
        extracted_markdown=data.get("extracted_markdown", ""),
        items=[LearningItem(**item) for item in data.get("items", [])],
        source_markdowns=data.get("source_markdowns", {}),
        ocr_markdown=data.get("ocr_markdown", ""),
        page_image_paths=data.get("page_image_paths", []),
    )


if __name__ == "__main__":
    sys.exit(main())
