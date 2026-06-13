# Asset Pipeline Design

Design notes for importing, cooking, and hot-reloading game assets (tilemaps, sprites, etc.).

## Current Problems

The tilemap block in `main.jai` mixes import, cook, load, and teardown in game startup code that should only request assets by name:

```jai
// main.jai — tilemap experimenting
tilemap_path := "./resources/assets/farm/tilemap-main.tm.fasset";
if file_exists(tilemap_path) {
    tilemap, ok = tilemap_load(tilemap_path);
} else {
    tilemap, ok = tilemap_import_from_tiled("./resources/assets/farm/tilemap-main.json");
    tilemap_save(*tilemap, tilemap_path);
    tm2, ok := tilemap_load(tilemap_path);
}
tilemap_destroy(*tilemap);
```

Issues:

1. **Game code knows import formats** — Tiled JSON, `.fasset` paths, existence checks.
2. **Cooking happens at runtime** in an ad-hoc `if file_exists` branch.
3. **Inconsistent with sprites** — `load_sprite` reads raw Aseprite JSON directly, with an absolute path outside the repo.
4. **Import/load/GPU are tangled** — `tilemap_import_from_tiled` and `tilemap_load` both upload textures.

## Existing Precedent: Shaders

Shaders already follow a clean source → cooked → runtime pattern:

- Source: `resources/shaders/*.hlsl`
- Cooked: `resources/shader_out/spirv/*.spirv`
- Build: `scripts/compile_shaders.py` (mtime-based rebuild)
- Runtime: loads cooked output only

Tilemaps and sprites should follow the same shape.

## Recommended Layout: Source vs Cooked (Both Inside the Project)

**Keep raw assets inside the project** under a clear source tree. **Put cooked assets in a separate output tree.** Do not treat "outside project" as the normal case.

```
resources/
  source/                    # authored / imported-from-Tiled / Aseprite exports
    farm/
      tilemap-main.json
      Tileset_Spring.tsx
      farmpack/...
  cooked/                    # generated; gitignore or commit for convenience
    farm/
      tilemap-main.tm.fasset
      tileset_spring.ts.fasset
      character.sprite.fasset
  shaders/                   # already exists
  shader_out/                # already exists
```

### Side-by-side vs separate trees

| Approach | Pros | Cons |
|----------|------|------|
| **Side-by-side** (`tilemap.json` + `tilemap.tm.fasset` in same dir) | Simple 1:1 mapping | Easy to confuse source vs generated; harder to `.gitignore` cleanly |
| **Separate `source/` + `cooked/`** | Clear pipeline; matches shaders; easy to ignore/build | Need a deterministic path mapping rule |

Path mapping can be trivial:

```jai
// resources/source/farm/tilemap-main.json
//   -> resources/cooked/farm/tilemap-main.tm.fasset
cooked_path_for_source :: (source_path: string) -> string {
    rel := path_relative_to(source_path, source_root);
    base := path_strip_extension(rel);
    return tprint("%/%/%.tm.fasset", cooked_root, path_strip_filename(base), path_basename(base));
}
```

### What about raw assets outside the project?

`File_Watcher` can watch **any directory** — absolute paths are fine:

```jai
add_directories(*watcher, "/home/tony/Downloads/Farm RPG.../Character");
```

Use external paths only as a **dev convenience** (symlink or one-time import), not as the canonical layout:

- Absolute paths break for other machines and shipped builds.
- External dirs are fine to **watch during active editing**, but **cook into `resources/cooked/`** with project-relative paths stored in the cooked file.

If you sometimes edit externally, add a small manifest (JSON or Jai table) mapping external source → cooked output — not hardcoded paths in `main.jai`.

## Layer the Pipeline (Four Responsibilities)

Split what the tilemap module currently mixes:

| Layer | Responsibility | Example |
|-------|------------------|---------|
| **Importer** | Raw format → engine CPU data | `tilemap_import_from_tiled`, `tileset_import_from_tiled`, Aseprite import |
| **Cooker** | CPU data → `.fasset` on disk | `tilemap_save`; write relative dependency paths |
| **Loader** | Read `.fasset` → CPU runtime struct | Parse binary; no Tiled/XML |
| **Runtime asset system** | Handles, GPU upload, hot reload | `load_tilemap("farm/tilemap-main")` |

`main.jai` should only call the last layer:

```jai
assets_init();
handle := load_tilemap("farm/tilemap-main");  // logical id, not a filesystem branch
// ...
assets_shutdown();
```

Import/cook logic belongs in `modules/runtime/assets.jai` (or `modules/runtime/asset_pipeline.jai`), not in `main.jai`.

Also split GPU from load — today `tilemap_load` uploads textures immediately. For hot reload:

1. Reload CPU `.fasset` data
2. Destroy old GPU resources
3. Re-upload

Same pattern as `load_sprite` (metadata load, then `sprite_renderer_upload_sprite`).

## When to Cook: Build Script + File_Watcher

Use **both**, like many engines.

### 1. Build-time cook (like `compile_shaders.py`)

Add `scripts/cook_assets.py` or a small Jai cook tool, called from `build.sh`:

- Walk `resources/source/`
- For each source file, if missing/stale cooked output → import + save
- Staleness: `source.mtime > cooked.mtime`, or hash in a sidecar

This gives CI, clean clones, and no import logic in the game loop.

### 2. Runtime File_Watcher (dev hot reload)

In `assets_init`:

```jai
init(*watcher, asset_file_changed_callback, ...);
add_directories(*watcher, source_root);  // e.g. "resources/source"
```

In the main loop (alongside input/render):

```jai
process_changes(*watcher);
assets_process_pending_reloads();
```

Callback logic:

1. Match changed path to a registered asset (by extension or registry).
2. Debounce — `File_Watcher` already merges events via `merge_window_seconds`.
3. Re-cook source → cooked.
4. Mark asset dirty; next frame reload GPU.

Watch **source roots**, not cooked output — otherwise you get feedback loops (cook writes `.fasset` → watcher fires → recook again). Either ignore `*.fasset` in the callback or only watch `resources/source/`.

For tilemaps, also watch **dependencies**: editing `Tileset_Spring.png` should recook/reload tilemaps that reference that tileset. Minimal approach:

- Cooked tilemap records dependency paths
- On any source change, check reverse index: "which cooked assets depend on this file?"

## Cooked File Metadata

Embed in `.fasset` (or a tiny sidecar `.fasset.meta`):

- `source_path` (project-relative)
- `source_mtime` or hash
- `cook_version` (bump when import logic changes)
- `dependencies[]`

Then even without `File_Watcher`, startup can do:

```jai
if asset_is_stale(cooked_path) cook_asset(source_path);
```

That covers cases where the watcher missed an event.

## Unify Sprites and Tilemaps

Currently:

- **Sprites**: raw Aseprite JSON at runtime, no cook step
- **Tilemaps**: import → cook → load

Pick one model:

- **Sprites**: cook Aseprite JSON → `.sprite.fasset` (UV rects, animation metadata; texture path relative)
- **Tilemaps**: cook Tiled JSON → `.tm.fasset` (tile data + tileset ref)
- **Tilesets**: cook TSX + PNG → `.ts.fasset` (shared; multiple tilemaps can reference one tileset)

Runtime `runtime/assets.jai` becomes the single entry point:

```jai
load_sprite :: (id: string) -> ...
load_tilemap :: (id: string) -> ...
assets_process_changes :: () -> ...  // called from main loop
```

## Practical Next Steps for ffarm

1. **Move authored content under `resources/source/farm/`** (most of it is already in `resources/assets/farm/` — renaming to `source/` is optional but clarifies intent).
2. **Write cooked output to `resources/cooked/`** (or `build/cooked/` if you want zero generated files in `resources/`).
3. **Add cook step to `build.sh`** mirroring `compile_shaders.py`.
4. **Extend `runtime/assets.jai`** with cook-on-demand + load-by-id; move import branches out of `main.jai`.
5. **Wire `File_Watcher` on `resources/source/`** for dev hot reload; ignore cooked dirs.
6. **Stop using absolute Download paths** — copy/symlink into `resources/source/` and reference by logical id.

Keeping raw assets in-repo is the right default for a game prototype you'll share, build, and eventually ship. External directories are fine as watch targets during import, but cooked output and runtime paths should always be project-relative.
