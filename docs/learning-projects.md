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

Create a YAML file under `learning-projects/`:

```yaml
id: analysis-i
title: Analysis I
description: >
  A learning project for working through Analysis I problem sheets by writing
  every proof and solution.
output_dir: content/en/learning/analysis-i
sources:
  - sheet: 1
    pdf: ~/Downloads/AnalysisI_Sheet1.pdf
  - sheet: 2
    pdf: ~/Downloads/AnalysisI_Sheet2.pdf
```

Fields:

- `id`: stable project id used for generated tracking item ids.
- `title`: project title shown on generated pages.
- `description`: optional text shown on the project tracker page.
- `output_dir`: generated Markdown destination.
- `sources`: ordered PDF sheets. `pdf` can use `~`.

## Running

First run, or refresh after changing PDFs:

```sh
python3 scripts/learning/generate_project.py learning-projects/<project>.yaml --write-json
```

Fast rewrite from cache:

```sh
python3 scripts/learning/generate_project.py learning-projects/<project>.yaml --fast --write-json
```

Force fresh extraction/refinement:

```sh
python3 scripts/learning/generate_project.py learning-projects/<project>.yaml --refresh-cache --write-json
```

Generate only selected sheets while debugging:

```sh
python3 scripts/learning/generate_project.py learning-projects/<project>.yaml --sheets 3,5 --write-json
```

Skip OCR/image rendering:

```sh
python3 scripts/learning/generate_project.py learning-projects/<project>.yaml --disable-ocr --write-json
```

## Cache

Generated sheet data is cached in:

```text
.learning-cache/<project-id>/sheet-XX.json
```

The cache is ignored by Git. A cached sheet is reused only when the PDF path,
size, and `mtime_ns` match. `--fast` requires valid cached sheets and does not
read PDFs, render page images, run local OCR, or call Codex.

If `.learning-cache` is missing but the project already has an
`extracted.json`, a normal run can seed the cache from that intermediate file.

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

## Codex OCR Pass

By default, the script assumes the `codex` CLI is installed and authenticated.
For each cache miss, it renders PDF pages to temporary images and asks Codex to
repair OCR/math formatting. If a Codex call times out, fails, or returns
malformed JSON, that sheet falls back to deterministic extraction.

To use a different refiner, pass `--llm-command`. The command reads the JSON
payload from stdin and writes refined JSON to stdout.
