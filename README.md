# virtqio

Personal website and technical notes.

Built with [ssg](https://github.com/pykello/ssg), a small static site generator focused on technical content.

## Build

### Prerequisites

- Rust (stable)
- [pandoc](https://pandoc.org/)

### Local development

```bash
# Build ssg
git clone https://github.com/pykello/ssg.git
cd ssg && cargo build --release
export PATH="$PATH:$(pwd)/target/release"
cd ..

# Build the site
make
```

The output will be in `build/`. You can serve it with:

```bash
make serve
```

## Structure

- `content/en/` and `content/fa/` — English and Persian content
- `config.en.yaml` / `config.fa.yaml` — site configuration
- `templates/` — Tera HTML templates
- `Makefile` — build rules (uses `ssg-content` and `ssg-list`)

## Deployment

See `deploy.sh` for a self-contained build script that installs dependencies and builds the site.

## License

MIT
