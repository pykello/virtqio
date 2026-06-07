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
`Makefile`. On change it runs:

```sh
make -B
```

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

Useful options:

```sh
python3 scripts/live_preview.py --port 8110
python3 scripts/live_preview.py --no-initial-build
python3 scripts/live_preview.py --build-cmd "make"
python3 scripts/live_preview.py --watch content/en/notes --watch templates
```
