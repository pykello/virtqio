# Access Protection

Cloudflare Pages uses `functions/_middleware.js` to protect the site with HTTP
Basic Auth.

Configure these Pages environment variables in Cloudflare:

```text
SITE_PASSWORD=<simple site password>
PRIVATE_PASSWORD=<strong private password>
```

Behavior:

- `/private` and `/private/*` require `PRIVATE_PASSWORD`.
- all other paths accept `SITE_PASSWORD`.
- all other paths also accept `PRIVATE_PASSWORD`, so a direct visit to
  `/private` can still load shared assets such as `/static/...`.
- the Basic Auth username is ignored. Leave it blank if the browser allows it,
  or enter any value.
- setting either password to `__allow_all__` disables authentication for that
  scope.

If a required password is missing, the middleware fails closed with `500`
instead of serving content.
