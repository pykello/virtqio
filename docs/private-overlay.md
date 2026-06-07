# Private Content

Private content lives in a nested git repo at:

```text
content/private
```

The top-level `virtqio` repo ignores that directory. If the directory exists,
`make` builds it as normal site content under `/private`. If it does not exist,
the build continues without private pages.

Create the local private repo with:

```sh
mkdir -p content/private
cd content/private
git init
```

Example:

```text
content/private/index.md
content/private/notes/example.md
```

builds as:

```text
/private/index.html
/private/notes/example.html
```

The Makefile prunes nested `.git` directories while discovering content, so
the nested repo metadata is not treated as site input.

## Cloudflare Pages

Cloudflare Pages only checks out the public `virtqio` repo. To include private
content in deployments, set a build-time environment variable:

```text
VIRTQIO_PRIVATE_REPO_URL
```

When this variable is present, `deploy.sh` clones that repo into
`content/private` before running `make`.

If `content/private` already exists during a Cloudflare Pages build,
`deploy.sh` replaces it. Outside Cloudflare, it refuses to overwrite an
existing local private repo.

Optionally pin a branch or tag:

```text
VIRTQIO_PRIVATE_REPO_REF
```

For a public private-content repo, the URL can be ordinary HTTPS:

```text
https://github.com/OWNER/virtqio-private.git
```

For an actual private GitHub repo, keep the URL token-free:

```text
VIRTQIO_PRIVATE_REPO_URL=https://github.com/OWNER/virtqio-private.git
```

Then set a separate secret:

```text
VIRTQIO_PRIVATE_REPO_TOKEN
```

`deploy.sh` injects that token into the GitHub clone URL at build time. The
token should have read-only access to the private content repo.

In Cloudflare Pages, add these under the Pages project settings for build-time
variables:

```text
VIRTQIO_PRIVATE_REPO_URL    plain variable
VIRTQIO_PRIVATE_REPO_TOKEN  secret
VIRTQIO_PRIVATE_REPO_REF    optional plain variable
```

For GitHub, the token can be a fine-grained personal access token scoped only
to the private content repo with read-only `Contents` access.

The deployment build command remains:

```sh
./deploy.sh
```
