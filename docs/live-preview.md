# Live Preview

Use the live preview server when editing content and templates locally:

```sh
make live
```

The server listens at:

```text
http://127.0.0.1:8000/
```

It watches `content/`, `templates/`, `static/`, the config files, and the
`Makefile`. On change it waits briefly for writes to settle, then runs the
default Make target:

```sh
make
```

This does not clean and does not force all targets. Make rebuilds whatever is
out of date, so ordinary page edits should complete quickly.

The Makefile declares page dependencies on templates, configs, and files inside
metadata-backed content directories. Learning project progress pages also
depend on their `sheets/` Markdown files. This keeps the live preview script
simple: it only watches for changes and runs `make`.

Connected browsers are notified through a WebSocket. After a successful build,
the browser fetches the current page, swaps the `<main>` element in place, keeps
open Bootstrap collapses and `<details>` elements open, restores the scroll
position, and asks MathJax to typeset the new content.

The script automatically prepends sibling SSG build directories to `PATH` when
they exist:

```text
../ssg/target/release
../ssg/target/debug
```

This lets `make` find the local `ssg-content` and `ssg-list` binaries without
editing your shell profile.

When learning pages exist, the Makefile checks `ssg-content --version` for the
required learning directive features. If you want to pin a specific SSG binary,
pass it explicitly:

```sh
make SSG_CONTENT=../ssg/target/release/ssg-content SSG_LIST=../ssg/target/release/ssg-list
```

Useful options:

```sh
python3 scripts/live_preview.py --port 8110
python3 scripts/live_preview.py --no-initial-build
python3 scripts/live_preview.py --build-cmd "make -B"
python3 scripts/live_preview.py --interval 0.2 --debounce 0.3
python3 scripts/live_preview.py --watch content/en/notes --watch templates
```
