const AUTH_REALM = 'virtq.io - username ignored';
const ALLOW_ALL = '__allow_all__';

export async function onRequest({ request, env, next }) {
  const url = new URL(request.url);
  const privatePath = isPrivatePath(url.pathname);
  const passwords = passwordsForPath(privatePath, env);

  if (passwords.length === 0) {
    return new Response('Authentication password is not configured.', {
      status: 500,
      headers: {
        'Cache-Control': 'no-store',
      },
    });
  }

  if (passwords.some((password) => password === ALLOW_ALL)) {
    return next();
  }

  if (!(await hasValidPassword(request, passwords))) {
    return unauthorized();
  }

  const response = await next();
  const protectedResponse = new Response(response.body, response);
  protectedResponse.headers.set('Cache-Control', 'no-store');
  return protectedResponse;
}

function isPrivatePath(pathname) {
  return pathname === '/private' || pathname.startsWith('/private/');
}

function passwordsForPath(privatePath, env) {
  if (privatePath) {
    return env.PRIVATE_PASSWORD ? [env.PRIVATE_PASSWORD] : [];
  }

  const passwords = [];
  if (env.SITE_PASSWORD) passwords.push(env.SITE_PASSWORD);
  if (env.PRIVATE_PASSWORD) passwords.push(env.PRIVATE_PASSWORD);
  return passwords;
}

async function hasValidPassword(request, expectedPasswords) {
  const authorization = request.headers.get('Authorization');
  if (!authorization) return false;

  const match = authorization.match(/^Basic\s+(.+)$/i);
  if (!match) return false;

  let decoded = '';
  try {
    decoded = atob(match[1]);
  } catch {
    return false;
  }

  const separator = decoded.indexOf(':');
  const actualPassword = separator >= 0 ? decoded.slice(separator + 1) : decoded;

  for (const expectedPassword of expectedPasswords) {
    if (await timingSafeEqual(actualPassword, expectedPassword)) {
      return true;
    }
  }
  return false;
}

async function timingSafeEqual(actual, expected) {
  const encoder = new TextEncoder();
  const actualDigest = await crypto.subtle.digest('SHA-256', encoder.encode(actual));
  const expectedDigest = await crypto.subtle.digest('SHA-256', encoder.encode(expected));
  const actualBytes = new Uint8Array(actualDigest);
  const expectedBytes = new Uint8Array(expectedDigest);

  let diff = 0;
  for (let i = 0; i < actualBytes.length; i += 1) {
    diff |= actualBytes[i] ^ expectedBytes[i];
  }
  return diff === 0;
}

function unauthorized() {
  return new Response('Authentication required.', {
    status: 401,
    headers: {
      'WWW-Authenticate': `Basic realm="${AUTH_REALM}", charset="UTF-8"`,
      'Cache-Control': 'no-store',
    },
  });
}
