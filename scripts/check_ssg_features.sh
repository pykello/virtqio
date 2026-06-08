#!/bin/sh
set -eu

binary=${1:-ssg-content}
shift || true

if ! version_output=$("$binary" --version 2>/dev/null); then
    echo "Unable to run $binary --version" >&2
    echo "Set SSG_CONTENT=/path/to/current/ssg-content or fix PATH." >&2
    exit 1
fi

missing=""
for feature in "$@"; do
    case "$version_output" in
        *"$feature"*) ;;
        *) missing="$missing $feature" ;;
    esac
done

if [ -n "$missing" ]; then
    echo "$binary is missing required SSG feature(s):$missing" >&2
    echo "Version output: $version_output" >&2
    echo "Build current SSG or set SSG_CONTENT=/path/to/current/ssg-content." >&2
    exit 1
fi
