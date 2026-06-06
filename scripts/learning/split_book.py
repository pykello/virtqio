#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import re
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Any

import fitz


@dataclass
class Chapter:
    number: int
    title: str
    start_page: int
    end_page: int


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Split a book PDF into chapter PDFs for learning projects."
    )
    parser.add_argument("pdf", type=Path, help="Source book PDF.")
    parser.add_argument(
        "--output-dir",
        type=Path,
        required=True,
        help="Directory where chapter PDFs are written.",
    )
    parser.add_argument(
        "--chapters",
        help="Comma-separated chapter numbers to write. Defaults to all chapters.",
    )
    parser.add_argument(
        "--manifest",
        type=Path,
        help="Optional JSON manifest path. Defaults to <output-dir>/chapters.json.",
    )
    args = parser.parse_args()

    pdf_path = args.pdf.expanduser().resolve()
    output_dir = args.output_dir.expanduser().resolve()
    output_dir.mkdir(parents=True, exist_ok=True)
    selected = parse_chapter_filter(args.chapters)
    manifest_path = (
        args.manifest.expanduser().resolve()
        if args.manifest
        else output_dir / "chapters.json"
    )

    with fitz.open(pdf_path) as document:
        chapters = detect_chapters(document)
        if not chapters:
            raise RuntimeError("Could not detect chapters from outline or page text.")
        selected_chapters = [
            chapter
            for chapter in chapters
            if selected is None or chapter.number in selected
        ]
        if not selected_chapters:
            raise RuntimeError("No detected chapters match --chapters.")
        for chapter in selected_chapters:
            write_chapter_pdf(document, chapter, output_dir)

    manifest = {
        "source_pdf": str(pdf_path),
        "chapters": [asdict(chapter) for chapter in chapters],
    }
    manifest_path.write_text(json.dumps(manifest, indent=2))
    print(f"Wrote {len(selected_chapters)} chapter PDFs to {output_dir}")
    return 0


def parse_chapter_filter(value: str | None) -> set[int] | None:
    if not value:
        return None
    return {int(part.strip()) for part in value.split(",") if part.strip()}


def detect_chapters(document: fitz.Document) -> list[Chapter]:
    outline_chapters = detect_outline_chapters(document)
    if outline_chapters:
        return outline_chapters
    return detect_text_chapters(document)


def detect_outline_chapters(document: fitz.Document) -> list[Chapter]:
    entries = []
    for level, title, page, *_rest in document.get_toc(simple=False):
        match = re.match(r"\s*(?:Chapter\s+)?(\d+)\.?\s*(.*)", title, re.I)
        if level == 1 and match:
            entries.append((int(match.group(1)), clean_title(match.group(2)), page))
    return chapters_from_starts(entries, document.page_count)


def detect_text_chapters(document: fitz.Document) -> list[Chapter]:
    entries: list[tuple[int, str, int]] = []
    for index, page in enumerate(document, start=1):
        lines = [line.strip() for line in page.get_text("text").splitlines()]
        lines = [line for line in lines if line]
        for line_index, line in enumerate(lines[:12]):
            match = re.fullmatch(r"CHAPTER\s+(\d+)", line, re.I)
            if not match:
                continue
            title = next_title_line(lines, line_index + 1)
            entries.append((int(match.group(1)), title, index))
            break
    return chapters_from_starts(entries, document.page_count)


def next_title_line(lines: list[str], start_index: int) -> str:
    title_lines: list[str] = []
    for line in lines[start_index:]:
        if re.match(r"^\d+(?:\.\d+)*\.?\s+", line):
            break
        if re.fullmatch(r"\d+", line):
            continue
        if len(line) <= 2:
            continue
        if title_lines and not is_heading_title_line(line):
            break
        title_lines.append(line)
        if len(title_lines) >= 3:
            break
    return clean_title(" ".join(title_lines)) or "Untitled"


def is_heading_title_line(line: str) -> bool:
    letters = re.sub(r"[^A-Za-z]", "", line)
    if not letters:
        return False
    uppercase = sum(1 for char in letters if char.isupper())
    return uppercase / len(letters) > 0.75


def chapters_from_starts(
    starts: list[tuple[int, str, int]],
    page_count: int,
) -> list[Chapter]:
    if not starts:
        return []
    deduped: list[tuple[int, str, int]] = []
    seen: set[int] = set()
    for number, title, page in sorted(starts, key=lambda item: item[2]):
        if number in seen:
            continue
        seen.add(number)
        deduped.append((number, title, page))

    chapters: list[Chapter] = []
    for index, (number, title, start_page) in enumerate(deduped):
        next_start = deduped[index + 1][2] if index + 1 < len(deduped) else page_count + 1
        chapters.append(
            Chapter(
                number=number,
                title=title,
                start_page=start_page,
                end_page=next_start - 1,
            )
        )
    return chapters


def clean_title(title: str) -> str:
    title = re.sub(r"\s+", " ", title).strip(" .")
    return title.title() if title.isupper() else title


def write_chapter_pdf(document: fitz.Document, chapter: Chapter, output_dir: Path) -> None:
    chapter_pdf = fitz.open()
    chapter_pdf.insert_pdf(
        document,
        from_page=chapter.start_page - 1,
        to_page=chapter.end_page - 1,
    )
    path = output_dir / f"chapter-{chapter.number:02d}.pdf"
    chapter_pdf.save(path)
    chapter_pdf.close()


if __name__ == "__main__":
    raise SystemExit(main())
