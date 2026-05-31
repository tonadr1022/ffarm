#/usr/bin/env bash
python3 ./scripts/compile_shaders.py
./scripts/build.sh -x64 -quiet -very_debug +Autorun
