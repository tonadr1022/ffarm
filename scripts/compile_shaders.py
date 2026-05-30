#!/usr/bin/env python3
from __future__ import annotations

import argparse
import os
import subprocess
import sys
from concurrent.futures import ProcessPoolExecutor
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SRC_DIR = ROOT / "resources" / "shaders"
SPIRV_OUT_DIR = ROOT / "resources" / "shader_out" / "spirv"
METAL_OUT_DIR = ROOT / "resources" / "shader_out" / "metal"


def shader_model_from_path(path: Path) -> str:
    stem_parts = path.name.split(".")
    if len(stem_parts) < 2:
        raise ValueError(f"Unexpected shader filename: {path}")
    shader_type = stem_parts[-2]
    prefix = {
        "vert": "vs",
        "frag": "ps",
        "mesh": "ms",
        "task": "as",
        "comp": "cs",
    }.get(shader_type)
    if prefix is None:
        raise ValueError(f"Unknown shader stage in {path}")
    return prefix + "_6_7"


def compile_hlsl(path: Path, is_spirv: bool) -> list[str]:
    out_dir = SPIRV_OUT_DIR if is_spirv else METAL_OUT_DIR
    extension = ".spirv" if is_spirv else ".dxil"
    out_path = out_dir / path.with_suffix(extension).name
    out_path.parent.mkdir(parents=True, exist_ok=True)

    cmd = [
        "dxc",
        str(path),
        "-Fo",
        str(out_path),
        "-T",
        shader_model_from_path(path),
        "-E",
        "main",
        "-I",
        str(SRC_DIR),
    ]
    if is_spirv:
        cmd += ["-spirv", "-fspv-target-env=vulkan1.3"]
        cmd += [
            "-fvk-use-dx-layout",
            "-fvk-u-shift",
            "1000",
            "0",
            "-fvk-t-shift",
            "2000",
            "0",
            "-fvk-b-shift",
            "3000",
            "0",
        ]
    return cmd


def run_cmd(cmd: list[str]) -> None:
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print("Command failed:", " ".join(cmd), file=sys.stderr)
        if result.stdout:
            print(result.stdout, file=sys.stderr)
        if result.stderr:
            print(result.stderr, file=sys.stderr)
        raise SystemExit(result.returncode)


def needs_rebuild(src: Path, out: Path) -> bool:
    if not out.exists():
        return True
    return src.stat().st_mtime > out.stat().st_mtime


def compile_file(path: Path, verbose: bool) -> None:
    spirv_out = SPIRV_OUT_DIR / path.with_suffix(".spirv").name
    if needs_rebuild(path, spirv_out):
        cmd = compile_hlsl(path, is_spirv=True)
        if verbose:
            print(" ".join(cmd))
        run_cmd(cmd)

    if sys.platform == "darwin":
        dxil_out = METAL_OUT_DIR / path.with_suffix(".dxil").name
        if needs_rebuild(path, dxil_out):
            cmd = compile_hlsl(path, is_spirv=False)
            if verbose:
                print(" ".join(cmd))
            run_cmd(cmd)
            metallib_out = dxil_out.with_suffix(".metallib")
            if needs_rebuild(dxil_out, metallib_out):
                msc_cmd = [
                    "metal-shaderconverter",
                    str(dxil_out),
                    "-o",
                    str(metallib_out),
                ]
                if verbose:
                    print(" ".join(msc_cmd))
                if (
                    subprocess.run(
                        ["which", "metal-shaderconverter"], capture_output=True
                    ).returncode
                    == 0
                ):
                    run_cmd(msc_cmd)


def main() -> None:
    parser = argparse.ArgumentParser("compile_shaders")
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args()

    hlsl_files = sorted(SRC_DIR.glob("*.hlsl"))
    if not hlsl_files:
        print("No HLSL shaders found", file=sys.stderr)
        return

    for path in hlsl_files:
        compile_file(path, args.verbose)


if __name__ == "__main__":
    main()
