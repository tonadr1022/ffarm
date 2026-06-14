TileMap :: struct {
    id: Guid;
    len_x, len_y: u32;
    data: [..]s32;
    tileset_id: Guid;
}

TileSet :: struct {
    img_path: string;
    tex: TextureHandle;
    tex_view: TextureViewHandle;
    img_w, img_h: u32;
    tile_count: u32;
    tile_w, tile_h: u32;
}

TILESET_COOKED_VERSION :: 1;
TILEMAP_COOKED_VERSION :: 1;

tilemap_set :: (tm: *TileMap, x: s32, y: s32, val: s32) {
    idx := tilemap_get_1d_idx(tm, x, y);
    assert(idx < tm.data.count);
    tm.data[idx] = val;
}

tilemap_get :: (tm: *TileMap, x: s32, y: s32) -> s32 {
    return tm.data[tilemap_get_1d_idx(tm, x, y)];
}

tilemap_write :: (tm: *TileMap, path: string) -> bool {
    f, ok := file_open(path, true);
    if !ok return false;
    defer file_close(*f);

    write_cooked_asset_file_header(*f, AssetType.TILE_MAP, TILEMAP_COOKED_VERSION);

    file_write(*f, *tm.len_x, size_of(u32));
    file_write(*f, *tm.len_y, size_of(u32));
    file_write(*f, *tm.data.count, size_of(s64));
    file_write(*f, tm.data.data, size_of(s32) * tm.data.count);

    write_string(*f, tm.tileset_id);

    return true;
}

tilemap_read_cooked :: (path: string) -> TileMap, bool {
    tm: TileMap;
    f, ok := file_open(path);
    if !ok return tm, false;
    defer file_close(*f);

    using,except(path) tm;

    ok = read_cooked_asset_file_header(f, AssetType.TILE_MAP, TILEMAP_COOKED_VERSION);
    if !ok return tm, false;

    file_read(f, *len_x, size_of(u32));
    file_read(f, *len_y, size_of(u32));
    count: s64;
    file_read(f, *count, size_of(s64));
    assert(count > 0);
    array_resize(*tm.data, count);
    file_read(f, tm.data.data, size_of(s32) * data.count);

    read_string(f, *tm.tileset_id);

    return tm, true;
}

tilemap_import_from_tiled :: (path: string) -> TileMap, bool {
    tm: TileMap;

    extension, ok := path_extension(path);
    if !equal("json", extension) {
        log_error("invalid tiled tilemap file: %\n", path);
        return tm, false;
    }

    // TODO: this leaks memory, used temp allocator
    tiled: TiledTilemapData;
    ok, tiled = json_parse_file(path, TiledTilemapData);
    if !ok {
        log_error("failed to parse tiled tilemap file: %\n", path);
        return tm, false;
    }

    layer := *tiled.layers[0];
    num_elements := layer.height * layer.width;
    array_reserve(*tm.data, num_elements);
    for val : tiled.layers[0].data {
        array_add(*tm.data, val);
    }
    tm.len_x = layer.width;
    tm.len_y = layer.height;

    // TODO: need to separate out tileset from tile map import. when importing a tile map. the tile set import 
    // job should be kicked off but separate asset creation.
    // assert(tiled.tilesets.count == 1);
    tileset_path := join(path_strip_filename(path), tiled.tilesets[0].source,, temp);
    tileset_id := asset_get_asset_id_from_proj_dir_path(tileset_path);
    tileset_guid: Guid;
    ok, tileset_guid = get_guid(tileset_id);
    if !ok {
        log_error("failed to obtain tileset for tilemap file: %\n", path);
        return tm, false;
    }
    tm.tileset_id = tileset_guid;

    return tm, true;
}

tileset_write :: (ts: *TileSet, path: string) -> bool {
    f, ok := file_open(path, true);
    if !ok return false;
    defer file_close(*f);


    write_cooked_asset_file_header(*f, AssetType.TILE_SET, TILESET_COOKED_VERSION);

    write_string(*f, ts.img_path);

    file_write(*f, *ts.img_w, size_of(u32));
    file_write(*f, *ts.img_h, size_of(u32));
    file_write(*f, *ts.tile_count, size_of(u32));
    file_write(*f, *ts.tile_w, size_of(u32));
    file_write(*f, *ts.tile_h, size_of(u32));
    return true;
}

tileset_read_cooked :: (path: string) -> TileSet, bool {
    ts: TileSet;

    f, ok := file_open(path);
    if !ok {
        return ts, false;
    }
    defer file_close(*f);

    read_cooked_asset_file_header(f, AssetType.TILE_SET, TILESET_COOKED_VERSION);

    read_string(f, *ts.img_path);
    file_read(f, *ts.img_w, size_of(u32));
    file_read(f, *ts.img_h, size_of(u32));
    file_read(f, *ts.tile_count, size_of(u32));
    file_read(f, *ts.tile_w, size_of(u32));
    file_read(f, *ts.tile_h, size_of(u32));
    assert(file_exists(ts.img_path));

    tileset_upload_gpu(*ts);

    return ts, true;
}

tileset_import_from_tiled :: (path: string) -> TileSet, bool {
    extension, ok := path_extension(path);
    if !equal("tsx", extension) {
        log_error("invalid tiled tileset file: %\n", path);
        return .{}, false;
    }

    metadata: TiledTilesetMetadata;
    root, result := xml_parse_file(path);
    if result.status != .ok {
        print("error: %\n", result);
    }

    for node : root {
        if equal(node.name, "tileset") {
            metadata.tilewidth = xx string_to_int(attribute_get_value(node, "tilewidth"));
            metadata.tileheight = xx string_to_int(attribute_get_value(node, "tileheight"));
            metadata.tilecount = xx string_to_int(attribute_get_value(node, "tilecount"));
            metadata.columns = xx string_to_int(attribute_get_value(node, "columns"));

            img_node := node.first_child;
            metadata.image = copy_string(attribute_get_value(img_node, "source"));
            metadata.imagewidth = xx string_to_int(attribute_get_value(img_node, "width"));
            metadata.imageheight = xx string_to_int(attribute_get_value(img_node, "height"));
        }
    }

    ts: TileSet = ---;
    tilemap_convert_tiled_tileset_to_engine(*ts, path, *metadata);

    return ts, true;
}

tilemap_destroy :: (tm: *TileMap) {
    array_reset(*tm.data);
}

tilemap_cook :: (raw_path: string, cooked_path: string) -> bool {
    tilemap, ok := tilemap_import_from_tiled(raw_path);
    if !ok return false;
    return tilemap_write(*tilemap, cooked_path);
}

tileset_cook :: (raw_path: string, cooked_path: string) -> bool {
    tileset, ok := tileset_import_from_tiled(raw_path);
    if !ok return false;
    return tileset_write(*tileset, cooked_path);
}

tileset_upload_gpu :: (ts: *TileSet) -> bool {
    ok: bool;
    ts.tex, ts.tex_view, ok = load_img_from_cpu(ts.img_path);
    return ok;
}

tileset_destroy_gpu :: (ts: *TileSet) {
    texture_destroy(ts.tex);
    texture_view_destroy(ts.tex_view);
}

tileset_destroy :: (ts: *TileSet) {
    free(ts.img_path);
    tileset_destroy_gpu(ts);
}

tileset_get_uvs :: (ts: *TileSet, val: s32) -> Vector2, Vector2 {
    x, y := tileset_get_2d_coord(ts, val);

    min_x := cast(float) x * ts.tile_w / cast(float) ts.img_w;
    min_y := cast(float) y * ts.tile_h / cast(float) ts.img_h;

    max_x := cast(float) (x + 1) * ts.tile_w / cast(float) ts.img_w;
    max_y := cast(float) (y + 1) * ts.tile_h / cast(float) ts.img_h;

    return Vector2.{min_x, min_y}, Vector2.{max_x, max_y};
}

#scope_file

TiledTilemapData :: struct {
    Layer :: struct {
        data: [..]s32;
        height: u32;
        width: u32;
        id: s32;
        name: string;
        opacity: float;
    }

    Tileset :: struct {
        source: string;
    }
    height: u32;
    width: u32;
    infinite: bool;
    layers: [..]Layer;
    tilesets: [..]Tileset;
    tileheight: u32;
    tilewidth: u32;
}

TiledTilesetMetadata :: struct {
    columns: u32;
    image: string;
    imageheight: u32;
    imagewidth: u32;
    margin: u32;
    name: string;
    spacing: u32;
    tilecount: u32;
    //tiledversion: string;
    tileheight: u32;
    tilewidth: u32;
    type: string;
    version: string;
}

tilemap_convert_tiled_tileset_to_engine :: (ts: *TileSet, tileset_path: string, tiled: *TiledTilesetMetadata) {
    ts.img_path = join(path_strip_filename(tileset_path), tiled.image);
    ts.img_w = tiled.imagewidth;
    ts.img_h = tiled.imageheight;
    ts.tile_count = tiled.tilecount;
    ts.tile_w = tiled.tilewidth;
    ts.tile_h = tiled.tileheight;
}

tilemap_get_1d_idx :: (tm: *TileMap, x: s32, y: s32) -> s32 {
    return y * xx tm.len_x + x;
}

tilemap_get_2d_coord :: (tm: *TileMap, i: s32) -> x: s32, y: s32 {
    return i % xx tm.len_x, i / xx tm.len_x;
}

tileset_get_2d_coord :: (ts: *TileSet, i: s32) -> x: s32, y: s32 {
    tiles_x := ts.img_w / ts.tile_w;
    tiles_y := ts.img_h / ts.tile_h;
    return i % xx tiles_x, i / xx tiles_x;
}

read_string :: (f: File, out: *string) -> bool {
    len: s64;
    if !file_read(f, *len, size_of(type_of(len))) return false;
    out.* = alloc_string(len);
    return file_read(f, out.data, len);
}

write_string :: (f: *File, str: string) -> bool {
    if !file_write(f, *str.count, size_of(type_of(str.count))) return false;
    if !file_write(f, str.data, str.count) return false;
    return true;
}

#import "Basic";
#import "File";
#import "String";
#import "Hash_Table";
#import "Math";
#import "File_Utilities";

#import "jaison";
#import "xml";

#import "graphics/renderer";
#import "runtime/assets";
