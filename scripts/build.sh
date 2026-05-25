#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

BUILD_DIR="$ROOT/build"

mkdir -p "$BUILD_DIR"

stage_sdl3_linux() {
    SDL3_SO="$ROOT/third_party/jai-sdl3/linux/bin/libSDL3.so"
    if [ ! -f "$SDL3_SO" ]; then
        "$ROOT/scripts/generate_jai_sdl3_bindings.sh"
    fi
    cp "$SDL3_SO" "$BUILD_DIR/libSDL3.so.0"
}

if [ ! -f "$ROOT/third_party/jai-vma/bindings.jai" ]; then
    jai $ROOT/third_party/jai-vma/generate.jai
fi

VK_JAI_BINDING_DIR=$ROOT/third_party/Vulkan

if [ ! -f "$VK_JAI_BINDING_DIR/vk.xml" ]; then
    # TODO: check for VULKAN_SDK and vk.xml existence
    echo "initializing vulkan bindings..."
    cp "$VULKAN_SDK/share/vulkan/registry/vk.xml" "$VK_JAI_BINDING_DIR/vk.xml"
    cp "$VULKAN_SDK/share/vulkan/registry/video.xml" "$VK_JAI_BINDING_DIR/video.xml"
    CWD="$(pwd)"
    cd "$VK_JAI_BINDING_DIR"
    jai generate.jai
    cd "$CWD"
fi

stage_sdl3_linux

cd "$ROOT"
jai main.jai -output_path "$BUILD_DIR" -import_dir third_party/ "$@"
