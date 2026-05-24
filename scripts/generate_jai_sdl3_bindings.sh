#!/usr/bin/env bash
# One-time (or occasional) setup: build SDL3 and regenerate jai-sdl3 bindings.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

git -C "$ROOT" submodule update --init --recursive third_party/jai-sdl3

cd "$ROOT/third_party/jai-sdl3"
git submodule update --init --recursive SDL

# TODO: only if vulkan build flag is set
jai generate.jai - -vulkan "$@"
