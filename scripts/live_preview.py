#!/usr/bin/env python3
from __future__ import annotations

import argparse
import base64
import hashlib
import http.server
import json
import os
import posixpath
import shlex
import socket
import socketserver
import subprocess
import sys
import threading
import time
import urllib.parse
from pathlib import Path


WS_GUID = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11"
LIVE_WS_PATH = "/__live/ws"
LIVE_CLIENT = r"""
<script>
(() => {
  if (window.__virtqioLivePreview) return;
  window.__virtqioLivePreview = true;

  let socket = null;
  let reconnectTimer = 0;
  let refreshing = false;

  function connect() {
    clearTimeout(reconnectTimer);
    const protocol = location.protocol === "https:" ? "wss:" : "ws:";
    socket = new WebSocket(`${protocol}//${location.host}/__live/ws`);

    socket.addEventListener("message", (event) => {
      let message = {};
      try {
        message = JSON.parse(event.data);
      } catch {
        return;
      }
      if (message.type === "build-success") {
        softRefresh();
      } else if (message.type === "build-failure") {
        console.warn("[virtqio-live] build failed");
      }
    });

    socket.addEventListener("close", () => {
      reconnectTimer = setTimeout(connect, 800);
    });
  }

  function snapshotState() {
    const main = document.querySelector("main");
    const anchor = findScrollAnchor(main);
    return {
      x: scrollX,
      y: scrollY,
      anchorId: anchor?.id || null,
      anchorTop: anchor?.top || 0,
      collapses: [...document.querySelectorAll(".collapse.show")]
        .map((node) => node.id)
        .filter(Boolean),
      details: [...document.querySelectorAll("details[open]")]
        .map((node) => node.id)
        .filter(Boolean),
      focusId: document.activeElement?.id || null,
    };
  }

  function findScrollAnchor(root) {
    if (!root) return null;
    let best = null;
    for (const node of root.querySelectorAll("[id]")) {
      const rect = node.getBoundingClientRect();
      if (rect.top <= 120) {
        best = { id: node.id, top: rect.top };
      } else if (best) {
        break;
      }
    }
    return best;
  }

  async function softRefresh() {
    if (refreshing) return;
    refreshing = true;
    const state = snapshotState();

    try {
      const url = new URL(location.href);
      url.searchParams.set("__live_ts", Date.now().toString());
      const response = await fetch(url, { cache: "no-store" });
      if (!response.ok) throw new Error(`fetch failed: ${response.status}`);
      const html = await response.text();
      const doc = new DOMParser().parseFromString(html, "text/html");
      const nextMain = doc.querySelector("main");
      const main = document.querySelector("main");
      if (!main || !nextMain) {
        location.reload();
        return;
      }

      document.title = doc.title;
      syncHeadStyles(doc);
      main.replaceWith(nextMain);
      restoreState(state);
      await typesetMath(nextMain);
      restoreScroll(state);
    } catch (error) {
      console.warn("[virtqio-live] soft refresh failed", error);
      location.reload();
    } finally {
      refreshing = false;
    }
  }

  function syncHeadStyles(doc) {
    const currentStyles = [...document.head.querySelectorAll("style")];
    const nextStyles = [...doc.head.querySelectorAll("style")];
    if (currentStyles.length !== nextStyles.length) return;
    for (let index = 0; index < currentStyles.length; index += 1) {
      currentStyles[index].textContent = nextStyles[index].textContent;
    }
  }

  function restoreState(state) {
    for (const id of state.collapses) {
      const node = document.getElementById(id);
      if (!node) continue;
      node.classList.add("show");
      for (const trigger of document.querySelectorAll(`[data-bs-target="#${cssEscape(id)}"], [href="#${cssEscape(id)}"]`)) {
        trigger.setAttribute("aria-expanded", "true");
        trigger.classList.remove("collapsed");
      }
    }
    for (const id of state.details) {
      const node = document.getElementById(id);
      if (node) node.open = true;
    }
    if (state.focusId) {
      document.getElementById(state.focusId)?.focus?.({ preventScroll: true });
    }
    restoreScroll(state);
  }

  function restoreScroll(state) {
    if (state.anchorId) {
      const anchor = document.getElementById(state.anchorId);
      if (anchor) {
        const top = anchor.getBoundingClientRect().top;
        scrollTo(state.x, scrollY + top - state.anchorTop);
        return;
      }
    }
    scrollTo(state.x, state.y);
  }

  function cssEscape(value) {
    if (window.CSS?.escape) return CSS.escape(value);
    return value.replace(/["\\]/g, "\\$&");
  }

  async function typesetMath(root) {
    if (!window.MathJax?.typesetPromise) return;
    if (window.MathJax.typesetClear) {
      window.MathJax.typesetClear([root]);
    }
    await window.MathJax.typesetPromise([root]);
  }

  connect();
})();
</script>
"""


class ThreadingHTTPServer(socketserver.ThreadingMixIn, http.server.HTTPServer):
    daemon_threads = True
    allow_reuse_address = True

    def __init__(self, server_address, handler_class, *, build_dir: Path):
        super().__init__(server_address, handler_class)
        self.build_dir = build_dir
        self.clients: set[socket.socket] = set()
        self.clients_lock = threading.Lock()

    def add_client(self, client: socket.socket) -> None:
        with self.clients_lock:
            self.clients.add(client)

    def remove_client(self, client: socket.socket) -> None:
        with self.clients_lock:
            self.clients.discard(client)

    def broadcast(self, payload: dict[str, object]) -> None:
        frame = encode_ws_text(json.dumps(payload))
        stale: list[socket.socket] = []
        with self.clients_lock:
            clients = list(self.clients)
        for client in clients:
            try:
                client.sendall(frame)
            except OSError:
                stale.append(client)
        for client in stale:
            self.remove_client(client)


class LivePreviewHandler(http.server.SimpleHTTPRequestHandler):
    server: ThreadingHTTPServer

    def __init__(self, request, client_address, server):
        super().__init__(
            request,
            client_address,
            server,
            directory=str(server.build_dir),
        )

    def do_GET(self) -> None:
        parsed = urllib.parse.urlsplit(self.path)
        if parsed.path == LIVE_WS_PATH:
            self.handle_websocket()
            return

        if self.redirect_directory_request(parsed):
            return

        html_path = self.html_file_path(parsed)
        if html_path is not None:
            self.send_injected_html(html_path)
            return

        super().do_GET()

    def log_message(self, format: str, *args) -> None:
        print(f"[http] {self.address_string()} {format % args}", file=sys.stderr)

    def html_file_path(self, parsed: urllib.parse.SplitResult) -> Path | None:
        file_path = self.request_file_path(parsed)
        if file_path is None:
            return None
        if file_path.is_dir():
            file_path = file_path / "index.html"
        elif parsed.path == "/":
            file_path = self.server.build_dir / "index.html"

        if file_path.suffix != ".html" or not file_path.is_file():
            return None
        return file_path

    def redirect_directory_request(self, parsed: urllib.parse.SplitResult) -> bool:
        file_path = self.request_file_path(parsed)
        if file_path is None or not file_path.is_dir() or parsed.path.endswith("/"):
            return False

        target = urllib.parse.urlunsplit(
            (parsed.scheme, parsed.netloc, f"{parsed.path}/", parsed.query, parsed.fragment)
        )
        self.send_response(301)
        self.send_header("Location", target)
        self.end_headers()
        return True

    def request_file_path(self, parsed: urllib.parse.SplitResult) -> Path | None:
        path = posixpath.normpath(urllib.parse.unquote(parsed.path))
        parts = [part for part in path.split("/") if part and part != "."]
        if any(part == ".." for part in parts):
            return None

        file_path = self.server.build_dir.joinpath(*parts)
        return file_path

    def send_injected_html(self, file_path: Path) -> None:
        html = file_path.read_text(encoding="utf-8")
        marker = "</body>"
        if marker in html:
            html = html.replace(marker, f"{LIVE_CLIENT}\n{marker}", 1)
        else:
            html = f"{html}\n{LIVE_CLIENT}\n"
        data = html.encode("utf-8")

        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Cache-Control", "no-store")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def handle_websocket(self) -> None:
        key = self.headers.get("Sec-WebSocket-Key")
        if not key:
            self.send_error(400, "Missing Sec-WebSocket-Key")
            return

        accept = websocket_accept(key)
        self.request.sendall(
            (
                "HTTP/1.1 101 Switching Protocols\r\n"
                "Upgrade: websocket\r\n"
                "Connection: Upgrade\r\n"
                f"Sec-WebSocket-Accept: {accept}\r\n"
                "\r\n"
            ).encode("ascii")
        )

        self.server.add_client(self.request)
        try:
            read_websocket_until_closed(self.request)
        finally:
            self.server.remove_client(self.request)


class BuildWatcher(threading.Thread):
    def __init__(
        self,
        *,
        repo_root: Path,
        watch_paths: list[Path],
        build_cmd: list[str],
        env: dict[str, str],
        server: ThreadingHTTPServer,
        interval: float,
        debounce: float,
        initial_build: bool,
    ):
        super().__init__(daemon=True)
        self.repo_root = repo_root
        self.watch_paths = watch_paths
        self.build_cmd = build_cmd
        self.env = env
        self.server = server
        self.interval = interval
        self.debounce = debounce
        self.initial_build = initial_build
        self.stop_event = threading.Event()
        self.snapshot = snapshot_paths(self.watch_paths)

    def run(self) -> None:
        if self.initial_build:
            self.run_build("initial")
            self.snapshot = snapshot_paths(self.watch_paths)

        pending_since: float | None = None
        while not self.stop_event.is_set():
            time.sleep(self.interval)
            current = snapshot_paths(self.watch_paths)
            if current != self.snapshot:
                self.snapshot = current
                pending_since = time.monotonic()
                continue
            if pending_since is not None and time.monotonic() - pending_since >= self.debounce:
                pending_since = None
                self.run_build("change")
                self.snapshot = snapshot_paths(self.watch_paths)

    def stop(self) -> None:
        self.stop_event.set()

    def run_build(self, reason: str) -> None:
        command_label = " ".join(shlex.quote(part) for part in self.build_cmd)
        print(f"[live] build start ({reason}): {command_label}", flush=True)
        self.server.broadcast(
            {"type": "build-start", "reason": reason, "command": command_label}
        )
        started = time.monotonic()
        result = subprocess.run(
            self.build_cmd,
            cwd=self.repo_root,
            env=self.env,
            text=True,
        )
        elapsed_ms = round((time.monotonic() - started) * 1000)
        if result.returncode == 0:
            print(f"[live] build success ({elapsed_ms} ms)", flush=True)
            self.server.broadcast({"type": "build-success", "elapsedMs": elapsed_ms})
        else:
            print(
                f"[live] build failed with exit code {result.returncode} ({elapsed_ms} ms)",
                file=sys.stderr,
                flush=True,
            )
            self.server.broadcast(
                {
                    "type": "build-failure",
                    "returnCode": result.returncode,
                    "elapsedMs": elapsed_ms,
                }
            )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Serve virtqio with WebSocket live preview and rebuild-on-change."
    )
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", type=int, default=8000)
    parser.add_argument("--build-dir", type=Path, default=Path("build"))
    parser.add_argument("--build-cmd", default="make")
    parser.add_argument("--interval", type=float, default=0.1)
    parser.add_argument("--debounce", type=float, default=0.15)
    parser.add_argument("--no-initial-build", action="store_true")
    parser.add_argument(
        "--watch",
        action="append",
        type=Path,
        help="Path to watch. Can be passed multiple times.",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    repo_root = Path.cwd().resolve()
    build_dir = resolve_repo_path(repo_root, args.build_dir)
    watch_paths = [resolve_repo_path(repo_root, path) for path in (args.watch or default_watch_paths())]
    env = build_environment(repo_root)
    build_cmd = shlex.split(args.build_cmd)

    server = ThreadingHTTPServer(
        (args.host, args.port),
        LivePreviewHandler,
        build_dir=build_dir,
    )
    watcher = BuildWatcher(
        repo_root=repo_root,
        watch_paths=watch_paths,
        build_cmd=build_cmd,
        env=env,
        server=server,
        interval=args.interval,
        debounce=args.debounce,
        initial_build=not args.no_initial_build,
    )
    watcher.start()

    print(f"[live] serving {build_dir} at http://{args.host}:{args.port}/")
    print(f"[live] watching: {', '.join(str(path.relative_to(repo_root)) if path.is_relative_to(repo_root) else str(path) for path in watch_paths)}")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\n[live] stopping")
    finally:
        watcher.stop()
        server.shutdown()
        server.server_close()
    return 0


def default_watch_paths() -> list[Path]:
    return [
        Path("content"),
        Path("templates"),
        Path("static"),
        Path("config.en.yaml"),
        Path("config.fa.yaml"),
        Path("Makefile"),
    ]


def resolve_repo_path(repo_root: Path, path: Path) -> Path:
    path = path.expanduser()
    if path.is_absolute():
        return path
    return (repo_root / path).resolve()


def build_environment(repo_root: Path) -> dict[str, str]:
    env = os.environ.copy()
    ssg_root = (repo_root.parent / "ssg").resolve()
    path_entries = [
        ssg_root / "target" / "release",
        ssg_root / "target" / "debug",
    ]
    existing = [str(path) for path in path_entries if path.is_dir()]
    if existing:
        env["PATH"] = os.pathsep.join(existing + [env.get("PATH", "")])
    return env


def snapshot_paths(paths: list[Path]) -> dict[str, tuple[int, int]]:
    snapshot: dict[str, tuple[int, int]] = {}
    for path in paths:
        if path.is_file():
            add_file_snapshot(snapshot, path)
        elif path.is_dir():
            for root, dirs, files in os.walk(path):
                dirs[:] = [name for name in dirs if not should_skip_dir(name)]
                for file_name in files:
                    add_file_snapshot(snapshot, Path(root) / file_name)
    return snapshot


def should_skip_dir(name: str) -> bool:
    return name in {
        ".git",
        "build",
        "__pycache__",
        ".learning-cache",
        "node_modules",
    }


def add_file_snapshot(snapshot: dict[str, tuple[int, int]], path: Path) -> None:
    try:
        stat = path.stat()
    except OSError:
        return
    snapshot[str(path)] = (stat.st_mtime_ns, stat.st_size)


def websocket_accept(key: str) -> str:
    digest = hashlib.sha1(f"{key}{WS_GUID}".encode("ascii")).digest()
    return base64.b64encode(digest).decode("ascii")


def encode_ws_text(text: str) -> bytes:
    payload = text.encode("utf-8")
    header = bytearray([0x81])
    length = len(payload)
    if length < 126:
        header.append(length)
    elif length < 65536:
        header.extend([126, (length >> 8) & 0xFF, length & 0xFF])
    else:
        header.append(127)
        header.extend(length.to_bytes(8, "big"))
    return bytes(header) + payload


def encode_ws_control(opcode: int, payload: bytes = b"") -> bytes:
    return bytes([0x80 | opcode, len(payload)]) + payload


def read_websocket_until_closed(sock: socket.socket) -> None:
    while True:
        try:
            header = recv_exact(sock, 2)
        except OSError:
            return
        if not header:
            return

        opcode = header[0] & 0x0F
        masked = bool(header[1] & 0x80)
        length = header[1] & 0x7F
        if length == 126:
            length = int.from_bytes(recv_exact(sock, 2), "big")
        elif length == 127:
            length = int.from_bytes(recv_exact(sock, 8), "big")

        mask = recv_exact(sock, 4) if masked else b""
        payload = recv_exact(sock, length) if length else b""
        if masked:
            payload = bytes(byte ^ mask[index % 4] for index, byte in enumerate(payload))

        if opcode == 0x8:
            return
        if opcode == 0x9:
            sock.sendall(encode_ws_control(0xA, payload))


def recv_exact(sock: socket.socket, length: int) -> bytes:
    data = bytearray()
    while len(data) < length:
        chunk = sock.recv(length - len(data))
        if not chunk:
            return b""
        data.extend(chunk)
    return bytes(data)


if __name__ == "__main__":
    raise SystemExit(main())
