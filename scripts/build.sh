#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

BUILD_DIR="$ROOT/build"

mkdir -p "$BUILD_DIR"

build_sdl3_linux() {
    SDL3_SO="$ROOT/third_party/jai-sdl3/linux/bin/libSDL3.so"
    if [ ! -f "$SDL3_SO" ]; then
        echo "Building SDL3"
        "$ROOT/scripts/build_sdl3.sh"
    fi
    SDL3_SO_OUT_PATH="$BUILD_DIR/libSDL3.so.0"
    if [ ! -f "$SDL3_SO_OUT_PATH" ]; then
        cp "$SDL3_SO" "$SDL3_SO_OUT_PATH"
    fi
}

build_sdl3_linux

cd "$ROOT"
jai main.jai -output_path "$BUILD_DIR" -import_dir third_party/ "$@"
