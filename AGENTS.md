This will be an early prototype of a game. This directory is called ffarm, because it might involve fighting and farming.

This game is written in jai. The jai core libraries, compiler binary, and examples can be found in $HOME/personal/jai.

## Building
./scripts/build.sh

## Running
./scripts/build.sh -quiet +Autorun
### Smoke test 30 frames
./scripts/build.sh -quiet +Autorun -quit_after_frames 30


The third_party/ dir contains third party libraries. Most or all have bindings for Jai generated with the bindings generator.

For more context on the project, read ./PROJECT_SPEC.md