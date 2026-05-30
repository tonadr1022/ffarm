#/usr/bin/env bash
python3 ./scripts/compile_shaders.py
./scripts/build.sh -quiet -very_debug +Autorun
