# Learning Projects

Learning projects generate proof/work pages from PDF problem sheets. The
generator lives at:

```sh
scripts/learning/generate_project.py
```

It extracts PDF text, optionally uses Codex with rendered page images to repair
math-heavy OCR, writes Markdown pages under `content/`, and creates progress
tracking blocks understood by `ssg`.

## Project Config

Create a YAML file anywhere convenient. It does not need to live inside the
virtqio checkout, which is useful when the config points at local PDFs that
should not be committed. For example:

```yaml
id: analysis-i
title: Analysis I
description: >
  A learning project for working through Analysis I problem sheets by writing
  every proof and solution.
source_title: "Oxford M2: Analysis I - Sequences and Series (2022-23)"
source_url: https://courses.maths.ox.ac.uk/course/view.php?id=608
output_dir: content/en/learning/analysis-i
sources:
  - sheet: 1
    title: "Chapter 1: Intervals"
    pdf: pdfs/AnalysisI_Sheet1.pdf
  - sheet: 2
    pdf: ~/Downloads/AnalysisI_Sheet2.pdf
```

Fields:

- `id`: stable project id used for generated tracking item ids.
- `title`: project title shown on generated pages.
- `description`: optional text shown on the project tracker page.
- `source_title`: optional public source title shown on each generated sheet.
- `source_url`: optional public URL linked from `source_title`.
- `output_dir`: generated Markdown destination. Relative paths are resolved
  from the virtqio repository root; absolute paths are also accepted.
- `sources`: ordered PDF sheets. `pdf` can use `~`. Relative PDF paths are
  resolved from the YAML config file's directory.
- `sources[].title`: optional generated page title for that source. This is
  useful when sources are book chapters instead of problem sheets.
- `sources[].section`: optional page section label. Book-style parsers default
  this to `sources[].title`; sheet-style parsers infer it from the PDF text.
- `sources[].item_parser`: optional parser mode. Use `book` for split book
  chapters so the generator tracks numbered `Problem`, `Exercise`, and
  proof-as-exercise `Proposition` entries instead of sheet-style numbered
  questions. Use `numbered_exercises` for book chapters whose exercises live
  in an `N.M Exercises` section and are numbered like `N.1`, `N.2`, and so on.
  Use `chapter_problem_sections` for textbook chapters whose end matter has
  sections such as `Review Questions`, `Exercises`, and `Computer Problems`
  numbered like `N.1`, `N.2`, and so on.
- `sources[].extractor`: optional extraction mode. Omit it or use `auto` to try
  `pymupdf4llm`, fitz text, and OCR candidates. Use `text` for PDFs where
  `pymupdf4llm` is known to time out or produce worse output; this uses fitz
  text directly and skips OCR image rendering for that source.

Generated pages and `extracted.json` never include local PDF file paths. The
`pdf` values are only used by the extraction script and ignored cache; use
`source_title` and `source_url` for the human-readable citation.

The script defaults `--repo-root` to the virtqio checkout containing
`scripts/learning/generate_project.py`. Override it only when running the
script from a copied location or generating into another checkout:

```sh
python3 /path/to/virtqio/scripts/learning/generate_project.py \
  /path/to/private-learning/analysis-i.yaml \
  --repo-root /path/to/virtqio \
  --write-json
```

Example external config layout:

```text
~/projects/virtqio-learning/
  analysis-i.yaml
  pdfs/
    AnalysisI_Sheet1.pdf
    AnalysisI_Sheet2.pdf
    AnalysisI_Sheet3.pdf
```

## Running

First run, or refresh after changing PDFs:

```sh
python3 scripts/learning/generate_project.py /path/to/<project>.yaml --write-json
```

Fast rewrite from cache:

```sh
python3 scripts/learning/generate_project.py /path/to/<project>.yaml --fast --write-json
```

Force fresh extraction/refinement:

```sh
python3 scripts/learning/generate_project.py /path/to/<project>.yaml --refresh-cache --write-json
```

Force Codex/LLM refinement for every extracted cache miss:

```sh
python3 scripts/learning/generate_project.py /path/to/<project>.yaml \
  --refresh-cache --refine-policy always --write-json
```

Disable Codex/LLM refinement:

```sh
python3 scripts/learning/generate_project.py /path/to/<project>.yaml \
  --refine-policy never --write-json
```

Generate only selected sheets while debugging:

```sh
python3 scripts/learning/generate_project.py /path/to/<project>.yaml --sheets 3,5 --write-json
```

Skip OCR/image rendering:

```sh
python3 scripts/learning/generate_project.py /path/to/<project>.yaml --disable-ocr --write-json
```

Skip generated-output validation:

```sh
python3 scripts/learning/generate_project.py /path/to/<project>.yaml --no-validate --write-json
```

The generator prints progress messages to stderr for cache checks, PDF/OCR
extraction, Codex refinement, normalization, writes, and validation. Each
completed phase includes elapsed time. Use `--quiet-progress` when running in a
script that should only emit the final generated-path line.

## Local OCR Data

The generator uses Tesseract when it is available. To avoid depending on system
language packages, virtqio keeps English OCR data at:

```text
scripts/learning/tessdata/eng.traineddata
```

When `TESSDATA_PREFIX` is not already set and that file exists, the generator
sets `TESSDATA_PREFIX` to `scripts/learning/tessdata` before running
Tesseract or `pymupdf4llm`. If you want to use a system or custom tessdata
directory, set `TESSDATA_PREFIX` yourself and the script will leave it alone.

If the local file is missing, install it with:

```sh
mkdir -p scripts/learning/tessdata
curl -L -o scripts/learning/tessdata/eng.traineddata \
  https://raw.githubusercontent.com/tesseract-ocr/tessdata_fast/main/eng.traineddata
```

## Cache

Generated sheet data is cached in:

```text
.learning-cache/<project-id>/sheet-XX.json
```

The cache is ignored by Git. A cached sheet is reused only when the PDF path,
size, and `mtime_ns` match. `--fast` requires valid cached sheets and does not
read PDFs, render page images, run local OCR, or call Codex.

The ignored `.learning-cache` entries keep local PDF signatures so `--fast` can
verify cache validity. The generated `extracted.json` is sanitized for commit
and does not expose local PDF addresses.

Each run also writes ignored progress metadata:

```text
.learning-cache/<project-id>/runs/<run-id>.jsonl
.learning-cache/<project-id>/runs/<run-id>.summary.json
.learning-cache/<project-id>/stages/sheet-XX.json
```

The JSONL file is appended while generation is running, so it can be tailed
during long OCR/Codex work. The run summary records options, phase totals, and
validation counts. The per-sheet stage files record source signatures, item
counts, generated tracking ids, phase timings, and sheet-specific validation
issues.

## Safe Regeneration

Generated sheet pages are merge-aware. When a sheet already exists, the
generator matches existing `:::learning-item` blocks by stable `id` and
preserves:

- manually changed item status values;
- existing `:::proof[Solution]` blocks;
- unmatched items that contain local status or proof work.

Unmatched items with local work are moved under an `Orphaned Local Work`
heading instead of being deleted. Placeholder todo items that no longer appear
in the source are dropped.

## Validation

Generation validates the structured IR and written Markdown by default.
Structural issues fail generation, including:

- duplicate generated item ids;
- missing generated item ids in the written Markdown;
- empty item or part statements;
- missing progress index or `:::learning-progress` block.

Extraction-quality concerns are warnings rather than failures. These include
common OCR artifacts such as `a_nd`, `o_r`, `i_s`, replacement characters, and
matrix box-drawing glyphs. Use `--no-validate` only when debugging the generator
or when you intentionally need to inspect broken intermediate output.

## Expanding Projects

Learning projects are incremental. To add more PDFs, append them to the
external YAML config and run the generator again. Existing cached sheets are
reused when their PDF signatures still match, so a normal run only extracts and
refines the new or changed sources:

```sh
python3 scripts/learning/generate_project.py /path/to/<project>.yaml --write-json
```

If you only want to process the newly added PDFs, pass their sheet numbers:

```sh
python3 scripts/learning/generate_project.py /path/to/<project>.yaml --sheets 4,5 --write-json
```

Selected-sheet runs preserve existing sheet Markdown and merge new sheet data
into `extracted.json`. The progress tracker scans the generated `sheets/`
directory, so it expands automatically as new sheet files appear.

## Book PDFs

For book-style PDFs, first split the source file into chapter PDFs. The helper
script uses an embedded PDF outline when available. If the PDF has no outline,
it scans page text for `CHAPTER N` headings and writes one PDF per chapter:

```sh
python3 scripts/learning/split_book.py /path/to/book.pdf \
  --output-dir /path/to/private-learning/book/pdfs \
  --chapters 1,2,3
```

The script also writes `chapters.json` in the output directory with detected
chapter titles and page ranges. Add the generated chapter PDFs to the external
learning-project YAML, using `title` to make generated pages read like chapter
pages:

```yaml
id: advanced-calculus
title: Advanced Calculus ProblemText
source_title: "A ProblemText in Advanced Calculus"
output_dir: content/en/learning/advanced-calculus
sources:
  - sheet: 1
    title: "Chapter 1: Intervals"
    item_parser: book
    pdf: pdfs/chapter-01.pdf
```

To expand the project later, split more chapters, append them to the YAML, and
run the generator with `--sheets` for the new chapter numbers.

## Output

The generator writes:

```text
content/en/learning/<project>/
  index.md
  extracted.json
  sheets/
    sheet-01.md
    sheet-02.md
```

`index.md` is the progress tracker page. It contains a `:::learning-progress`
block that scans `sheets/`.

Each generated sheet contains `:::learning-item` blocks. If an exercise has
parts such as `(a)`, `(b)`, `(i)`, or `(ii)`, each part gets a separate tracked
item and its own `:::proof[Solution]` block.

## Structured IR

The generator treats extracted content as a structured intermediate
representation before writing Markdown. Each sheet contains normalized items
with:

- `kind`: usually `exercise` or `theorem`;
- `number`: the source number, such as `4` or `17.3`;
- `title`: the parent item title, such as `Exercise 4`;
- `statement`: the single-part statement, or optional unsplit source text;
- `preamble`: shared text that belongs before multipart items;
- `parts`: structured subparts with `marker`, `title`, and `statement`;
- `status`: the generated status, normally `todo`.

The Markdown writer consumes this normalized IR. Multipart items get a parent
heading and each part gets its own stable `learning-item` id. Cached JSON uses
the same shape, so LLM-refined and locally parsed sheets can be regenerated by
the same writer.

## Codex OCR Pass

By default, `--refine-policy auto` renders PDF pages for cache misses but only
calls Codex when local extraction leaves structural validation errors, known OCR
artifact warnings, omitted-formula placeholders, or malformed extraction
markers. This keeps clean sheets fast while preserving Codex for the cases that
need OCR/math repair. The progress output records `refine queued` or
`refine skip` for each extracted sheet, and the same events are stored in the
ignored run metadata.

Use `--refine-policy always` to ask Codex to repair every extracted cache miss,
which matches the older behavior. Use `--refine-policy never` to skip LLM
refinement entirely.

When a sheet is queued for the default Codex refiner, the script assumes the
`codex` CLI is installed and authenticated. If a Codex call times out, fails,
or returns malformed JSON, that sheet falls back to deterministic extraction.

To use a different refiner, pass `--llm-command`. The command reads the JSON
payload from stdin and writes refined JSON to stdout.
