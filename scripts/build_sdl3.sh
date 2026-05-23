#!/usr/bin/env bash
# Builds SDL3 3.4.4 locally for jai-sdl3 on Linux.
#
# Requires: cmake, git, and typical SDL3 build dependencies (X11, Wayland,
# ALSA/PulseAudio dev packages, etc.).

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SDL3_VERSION="release-3.4.4"
SRC_DIR="$ROOT/.build/SDL3-src"
BUILD_DIR="$ROOT/.build/SDL3-build"
INSTALL_DIR="$ROOT/.build/SDL3-install"
OUTPUT_DIR="$ROOT/third_party/jai-sdl3/linux/bin"
OUTPUT_SO="$OUTPUT_DIR/libSDL3.so"

if [ -f "$OUTPUT_SO" ]; then
    echo "SDL3 library already built: $OUTPUT_SO"
    exit 0
fi

for cmd in cmake git; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: $cmd is required to build SDL3." >&2
        exit 1
    fi
done

mkdir -p "$ROOT/.build"

if [ ! -d "$SRC_DIR/.git" ]; then
    echo "Cloning SDL $SDL3_VERSION..."
    git clone --depth 1 --branch "$SDL3_VERSION" https://github.com/libsdl-org/SDL.git "$SRC_DIR"
fi

mkdir -p "$BUILD_DIR" "$INSTALL_DIR" "$OUTPUT_DIR"

echo "Configuring SDL3..."
cmake -S "$SRC_DIR" -B "$BUILD_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
    -DSDL_STATIC=OFF

echo "Building SDL3..."
cmake --build "$BUILD_DIR" --target install --parallel "$(nproc)"

INSTALLED_SO="$INSTALL_DIR/lib/libSDL3.so.0.4.4"
if [ ! -f "$INSTALLED_SO" ]; then
    echo "Error: expected SDL3 shared library not found at $INSTALLED_SO" >&2
    exit 1
fi

cp "$INSTALLED_SO" "$OUTPUT_SO"
echo "Installed SDL3 library to $OUTPUT_SO"
