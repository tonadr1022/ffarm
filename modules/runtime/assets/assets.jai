AssetType :: enum {
    INVALID;
    SPRITE_2D;
    TILE_MAP;
    TILE_SET;
}

AssetRawFormatType :: enum {
    INVALID;
    TILED_TILE_MAP;
    TILED_TILE_SET;
    PNG;
}

get_valid_raw_format_extensions :: (raw_format_type: AssetRawFormatType) -> []string {
    if raw_format_type == {
        case .INVALID; return .[];
        case .TILED_TILE_MAP; return .[".json"];
        case .TILED_TILE_SET; return .[".tsx"];
        case .PNG; return .[".png"];
    }
    return .[];
}

// returns temp string
get_cooked_extension :: (t: AssetType) -> string {
    a: string;
    if t == {
        case .INVALID; return "";
        case .SPRITE_2D; a = ".png";
        case .TILE_MAP;  a = ".tilemap";
        case .TILE_SET;  a = ".tileset";
    }
    return join(a, ".fasset",, temp);
}

Guid :: #type,isa string;
AssetId :: #type,isa string;

AssetHandle :: struct {
    guid: string;
    type: AssetType;
}

AssetInfo :: struct {
    name: string;
    path: string;
}

Assets :: struct {
    sprites: ObjectPool(SpriteAsset);

    // TODO: compile time generate these based on all the assets
    // tilemaps: ObjectPool(TileMap);
    // tilesets: ObjectPool(TileSet);

    guid_to_tilemap: Table(Guid, TileMap);
    guid_to_tileset: Table(Guid, TileSet);

    ref_counts: Table(Guid, s32);

    source_dir: string;
    cooked_dir: string;
    guid_to_asset_record: Table(Guid, AssetRecord);
    asset_id_to_guid: Table(AssetId, Guid);
}


AssetRecord :: struct {
    type: AssetType;
    pool_idx: int;
    raw_format: AssetRawFormatType;
    guid: Guid;
    raw_path: string;
    cooked_path: string;
    // TODO: use Guid at runtime?
    dependencies: [..]AssetId;
}

assets_init :: (source_dir: string, cooked_dir: string) {
    assets.source_dir = copy_string(source_dir);
    assets.cooked_dir = copy_string(cooked_dir);

    CallbackData :: struct {
        assets: *Assets;
        err: bool;
    }

    callback_data := CallbackData.{
        assets=*assets,
    };

    ASSET_METADATA_EXTENSION :: ".fasset.meta";

    callback :: (info: *File_Visit_Info, cb: *CallbackData) {
        if (ends_with(info.short_name, ASSET_METADATA_EXTENSION)) {
            ok, metadata := json_parse_file(info.full_name, AssetMetadataFileContents,, temp);
            if !ok {
                log_error("Failed to parse asset metadata: %\n", info.full_name);
                cb.err = true;
                return;
            }
            asset_type: AssetType;
            asset_type, ok = enum_name_to_value(AssetType, metadata.type);
            if !ok {
                log_error("Invalid asset type: %\n", metadata.type);
                cb.err = true;
                return;
            }
            raw_format_type: AssetRawFormatType;
            raw_format_type, ok = enum_name_to_value(AssetRawFormatType, metadata.raw_format);
            if !ok {
                log_error("Invalid AssetRawFormatType: %\n", metadata.raw_format);
                cb.err = true;
                return;
            }

            base := path_strip_extension(path_strip_extension(info.full_name));

            raw_path: string;
            for extension: get_valid_raw_format_extensions(raw_format_type) {
                path := join(base, extension,, temp); 
                if file_exists(path) {
                    raw_path = copy_string(path);
                    break;
                }
            }

            assert(begins_with(base, cb.assets.source_dir)); 
            asset_id := slice(base, cb.assets.source_dir.count + 1, base.count - cb.assets.source_dir.count - 1);
            if raw_path.count == 0 {
                log_error("Unable to find raw asset for metadata: %\n", info.full_name);
                cb.err = true;
                return;
            }

            cooked_path := join(assets.cooked_dir, "/", asset_id, get_cooked_extension(asset_type));

            record := AssetRecord.{
                type=asset_type,
                raw_format=raw_format_type,
                guid= cast(Guid) copy_string(metadata.guid),
                raw_path=raw_path,
                cooked_path=cooked_path
            };

            for dep: metadata.dependencies {
                array_add(*record.dependencies, cast(AssetId) dep);
            }

            table_add(*cb.assets.guid_to_asset_record, cast(Guid) copy_string(metadata.guid), record);
            table_add(*cb.assets.asset_id_to_guid, cast(AssetId) copy_string(asset_id), cast(Guid) copy_string(metadata.guid));
        }
    };

    visit_files(assets.source_dir, true, *callback_data, callback);

    if callback_data.err {
        log_error("Erorr while initializing assets, exiting...");
        exit(1);
    }
}

assets_shutdown :: () {
    free(assets.source_dir);
    free(assets.cooked_dir);
}

// returns temp string
assets_get_full_cooked_path :: (asset: AssetHandle) -> string {
    return path_join(assets.cooked_dir, asset.name,, temp);
}

// returns temp string
assets_get_full_source_path :: (asset: AssetHandle) -> string {
    return path_join(assets.source_dir, asset.name,, temp);
}

AssetRawFormat :: struct {
    name: string;
    extension: string;
}


AssetMetadataFileContents :: struct {
    type: string;
    raw_format: string;
    guid: string;
    dependencies: [..]string;
}

asset_needs_recook :: (asset_id: AssetId) -> bool {
    record := get_asset_record(asset_id);
    assert(record != null);
    raw_modtime, raw_size, raw_exists := file_modtime_and_size(record.raw_path);
    assert(raw_exists);
    cooked_modtime, cooked_size, cooked_exists:= file_modtime_and_size(record.cooked_path);
    if !cooked_exists {
        return true;
    }
    return raw_modtime > cooked_modtime;
}

asset_get_asset_id_from_proj_dir_path :: (path: string) -> AssetId {
    assert(starts_with(path, assets.source_dir));
    result := slice(path, assets.source_dir.count + 1, path.count - assets.source_dir.count - 1);
    while path_extension(result).count > 0 {
        result = path_strip_extension(result);
    }
    return cast(AssetId) result;
}

asset_cook :: (asset_id: AssetId, check_recook_needed := true) -> bool {
    record := get_asset_record(asset_id);
    assert(record != null);

    for dep: record.dependencies {
        if !asset_cook(dep) {
            log_error("Failed to cook dependency asset: %\n of asset: %\n", dep, asset_id);
            return false;
        }
    }

    if check_recook_needed && !asset_needs_recook(asset_id) return true;

    cooked_path := record.cooked_path;

    make_directory_if_it_does_not_exist(path_strip_filename(cooked_path,, temp), true);

    if record.type == {
        case .SPRITE_2D;
            return false;
        case .TILE_MAP;
            return tilemap_cook(record.raw_path, record.cooked_path);
        case .TILE_SET;
            return tileset_cook(record.raw_path, record.cooked_path);
    }

    return true;
}

AssetRef :: struct {
    guid: Guid;
    type: AssetType;
}

load_asset :: (asset_id: AssetId) -> Guid {
    record := get_asset_record(asset_id);
    if record == null return "";

    #if DEV { assert(asset_cook(asset_id, true)); }

    for dep : record.dependencies {
        load_asset(dep);
    }

    guid := record.guid;
    ref_cnt := table_find_pointer(*assets.ref_counts, guid);
    if !ref_cnt {
        table_add(*assets.ref_counts, guid, 1);
    } else {
        ref_cnt.* += 1;
    }


    if record.type == {
        case .TILE_MAP; {
            if !table_find(*assets.guid_to_tilemap, guid) {
                asset, ok := tilemap_read_cooked(record.cooked_path);
                if !ok return "";
                table_add(*assets.guid_to_tilemap, guid, asset);
            }
        }
        case .TILE_SET; {
            if !table_find(*assets.guid_to_tileset, guid) {
                ts, ok := tileset_read_cooked(record.cooked_path);
                if !ok return "";
                table_add(*assets.guid_to_tileset, guid, ts);
            }
        }
        case .SPRITE_2D; return "";
    }

    return record.guid;
}

unload_asset :: (guid: Guid) {
    record := get_asset_record(guid);
    if record == null return;
    ref_cnt := table_find_pointer(*assets.ref_counts, guid);
    assert(ref_cnt != null);
    ref_cnt.* -= 1;
    assert(ref_cnt.* >= 0);

    for dep : record.dependencies {
        ok, id := get_guid(dep);
        assert(ok);
        unload_asset(id);
    }

    if ref_cnt.* == 0 {
        if record.type == {
            case .TILE_SET; {
                asset := table_find_pointer(*assets.guid_to_tileset, guid);
                assert(asset != null);
                tileset_destroy(asset);
            }
            case .TILE_MAP; {
                asset := table_find_pointer(*assets.guid_to_tilemap, guid);
                assert(asset != null);
                tilemap_destroy(asset);
            }
            case .SPRITE_2D; {
                assert(false);
            }
        } 
    }
}

load_sprite :: (path: string) -> success: bool, handle: SpriteAssetHandle {
    handle: SpriteAssetHandle = obj_pool_alloc(*assets.sprites);
    if !load_sprite_2d_asset_metadata(path, get(handle)) {
        obj_pool_free(*assets.sprites, handle);
        return false, handle;
    }
    // upload to gpu
    sprite_asset: *SpriteAsset = get(handle);
    if !REN.sprite_renderer_upload_sprite(handle) {
        obj_pool_free(*assets.sprites, handle);
        return false, handle;
    }
    return true, handle;
}

unload_sprite :: (handle: SpriteAssetHandle) {
    sprite_asset: *SpriteAsset = get(handle);
    assert(sprite_asset != null);
    REN.texture_view_destroy(sprite_asset.texture_view);
    REN.texture_destroy(sprite_asset.texture);
    obj_pool_free(*assets.sprites, handle);
}

get :: (handle: SpriteAssetHandle) -> *SpriteAsset {
    return get(*assets.sprites, handle);
}

SpriteAssetHandle :: ObjectPool(SpriteAsset).HandleT;
TileMapHandle :: ObjectPool(TileMap).HandleT;
TileSetHandle :: ObjectPool(TileSet).HandleT;

get_guid :: (asset_id: AssetId) -> success: bool, Guid {
    ok, val := table_find(*assets.asset_id_to_guid, asset_id);
    return ok, val;
}

#scope_file

assets: Assets;

generate_asset_guid :: () -> string {
    // uuid v4
    bytes: [16] u8;
    for * b : bytes  b.* = cast(u8)(random_get() & 0xff);

    bytes[6] = (bytes[6] & 0x0f) | 0x40;  // version 4
    bytes[8] = (bytes[8] & 0x3f) | 0x80;  // variant

    return tprint("%0%0%0%0%0%0%0%0%0%0%0%0%0%0%0%0",
        bytes[0], bytes[1], bytes[2], bytes[3],
        bytes[4], bytes[5], bytes[6], bytes[7],
        bytes[8], bytes[9], bytes[10], bytes[11],
        bytes[12], bytes[13], bytes[14], bytes[15]);
}


get_asset_record :: (guid: Guid) -> *AssetRecord {
    return table_find_pointer(*assets.guid_to_asset_record, guid);
}

get_asset_record :: (asset_id: AssetId) -> *AssetRecord {
    ok, guid := get_guid(asset_id);
    if !ok return null;
    return get_asset_record(guid);
}

DEV :: true;

#import "Random";
#import "graphics/sprites";
#import "2d/tilemap";
#import "core/object_pool";
REN :: #import "graphics/renderer";
#import "Basic";
#import "String";
#import "File_Utilities";
#import "File_Utilities";
#import "jaison";
#import "Reflection";
#import "Hash_Table";
