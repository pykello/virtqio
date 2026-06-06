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

Generate only selected sheets while debugging:

```sh
python3 scripts/learning/generate_project.py /path/to/<project>.yaml --sheets 3,5 --write-json
```

Skip OCR/image rendering:

```sh
python3 scripts/learning/generate_project.py /path/to/<project>.yaml --disable-ocr --write-json
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
