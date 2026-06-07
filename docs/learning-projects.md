# Learning Projects

Learning projects are proof/work pages built from external sources such as
problem sheets or textbook chapters. The generated pages live in virtqio, but
the source PDFs and project notes can live outside this repository.

The old Python PDF-to-learning generator has been removed. Math-heavy
extraction was too fragile to maintain as a growing set of parser rules. The
current workflow is to use a fresh Codex session with the playbook in:

```text
../virtqio-learning/playbook
```

That playbook defines the Markdown contract, math style, extraction workflow,
and quality checks for creating or extending a learning project.

## Output Layout

A learning project should be written under:

```text
content/en/learning/<project-id>/
  index.md
  sheets/
    sheet-01.md
    sheet-02.md
```

`index.md` is the progress tracker page and should contain a
`:::learning-progress` block that scans the `sheets/` directory. There is no
separate landing page.

Each source PDF sheet or chapter should become one Markdown page. The page
should include:

- the public source title and URL, when available;
- sections from the source;
- `:::learning-item` blocks for theorems, exercises, review questions, and
  computer problems;
- empty `:::proof[Proof]` or `:::proof[Solution]` blocks for the user to fill.

Do not include local PDF paths in generated Markdown.

## Multipart Items

Problems with parts should usually get one tracked item per part. Include a
plain parent heading when the problem has shared setup text:

```md
## Exercise 4

Shared preamble from the source.

:::learning-item type=exercise id="sheet-01-exercise-4-a" section="Exercises" status=todo title="4(a)"
Part statement.

:::proof[Solution]

:::
:::
```

This lets the progress tracker count each part independently while keeping the
source context visible.

## Incremental Projects

Learning projects are meant to be extended over time. To add more sheets or
chapters:

1. Keep existing generated pages in place.
2. Add new `sheet-XX.md` files under the same `sheets/` directory.
3. Preserve existing `status` values and proof/solution blocks.
4. Rebuild virtqio and inspect the generated HTML.

A new Codex session should read the playbook before editing the project. The
copyable prompt is:

```text
../virtqio-learning/playbook/05-session-prompt.md
```

## Book PDFs

For book-style PDFs, use the small chapter-splitting helper before asking Codex
to create the Markdown pages:

```sh
python3 scripts/learning/split_book.py /path/to/book.pdf \
  --output-dir /path/to/private-learning/book/pdfs \
  --chapters 1,2,3
```

The helper uses an embedded PDF outline when available. If the PDF has no
outline, it scans page text for `CHAPTER N` headings and writes one PDF per
chapter. It also writes `chapters.json` with detected titles and page ranges.

The split chapter PDFs are still local inputs. Generated Markdown should cite
the public source title and URL instead of local paths.

## Verification

After adding or changing learning pages, rebuild virtqio:

```sh
cd /home/hadi/projects/virtqio
PATH=/home/hadi/projects/ssg/target/release:$PATH make -B
```

Then inspect the generated HTML for:

- raw OCR artifacts;
- malformed math;
- missing proof or solution placeholders;
- duplicated item labels;
- missing multipart tracking items.
