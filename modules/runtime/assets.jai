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
        case .TILED_TILE_SET; return .[".json"];
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
    source_dir: string;
    cooked_dir: string;
    guid_to_asset_record: Table(Guid, AssetRecord);
    asset_id_to_guid: Table(AssetId, Guid);
}


AssetRecord :: struct {
    type: AssetType;
    raw_format: AssetRawFormatType;
    guid: string;
    raw_path: string;
    cooked_path: string;
}

assets_init :: (source_dir: string, cooked_dir: string) {
    assets.source_dir = copy_string(source_dir);
    assets.cooked_dir = copy_string(cooked_dir);

    CallbackData :: struct {
        assets: *Assets;
        load_errors: [..]string;
    }

    callback_data := CallbackData.{
        assets=*assets,
    };

    ASSET_METADATA_EXTENSION :: ".fasset.meta";

    callback :: (info: *File_Visit_Info, cb: *CallbackData) {
        if (ends_with(info.short_name, ASSET_METADATA_EXTENSION)) {
            ok, metadata := json_parse_file(info.full_name, AssetMetadataFileContents,, temp);
            if !ok {
                array_add(*cb.load_errors, tprint("Failed to parse asset metadata: %\n", info.full_name));
                return;
            }
            asset_type: AssetType;
            asset_type, ok = enum_name_to_value(AssetType, metadata.type);
            if !ok {
                array_add(*cb.load_errors, tprint("Invalid asset type: %\n", metadata.type));
                return;
            }
            raw_format_type: AssetRawFormatType;
            raw_format_type, ok = enum_name_to_value(AssetRawFormatType, metadata.raw_format);
            if !ok {
                array_add(*cb.load_errors, tprint("Invalid AssetRawFormatType: %\n", metadata.raw_format));
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
                array_add(*cb.load_errors, tprint("Unable to find raw asset for metadata: %\n",  info.full_name));
                return;
            }

            cooked_path := join(base, get_cooked_extension(asset_type));

            record := AssetRecord.{
                type=asset_type,
                raw_format=raw_format_type,
                guid=copy_string(metadata.guid),
                raw_path=raw_path,
                cooked_path=cooked_path
            };

            table_add(*cb.assets.guid_to_asset_record, cast(Guid) copy_string(metadata.guid), record);
            table_add(*cb.assets.asset_id_to_guid, cast(AssetId) copy_string(asset_id), cast(Guid) copy_string(metadata.guid));
        }
    };

    visit_files(assets.source_dir, true, *callback_data, callback);
}

assets_shutdown :: () {
    free(assets.source_dir);
    free(assets.cooked_dir);
}

// returns temp string
assets_get_full_cookd_path :: (asset: AssetHandle) -> string {
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
}

asset_needs_recook :: (asset_id: AssetId) -> bool {
    record := get_asset_record(asset_id);
    assert(record != null);
    if !file_exists(record.cooked_path) {
        return true;
    }
    raw_modtime, raw_size, raw_exists:= file_modtime_and_size(record.raw_path);
    assert(raw_exists);
    cooked_modtime, cooked_size, cooked_exists:= file_modtime_and_size(record.cooked_path);
    return raw_modtime > cooked_modtime;
}

asset_cook :: (asset_id: AssetId, check_recook_needed := true) -> bool {
    if check_recook_needed && !asset_needs_recook(asset_id) return true;
    record := get_asset_record(asset_id);
    assert(record != null);
    cooked_path := record.cooked_path;

    if record.type == {
        case .SPRITE_2D;
            return false;
        case .TILE_MAP;
            return tilemap_cook(record.raw_path, record.cooked_path);
        case .TILE_SET;
            return tileset_cook(record.raw_path, record.cooked_path);
    }
}

load_asset :: (asset_id: AssetId) -> bool {
    return asset_cook(asset_id);
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

get_guid :: (asset_id: AssetId) -> success: bool, Guid {
    ok, val := table_find(*assets.asset_id_to_guid, asset_id);
    return ok, val;
}

get_asset_record :: (guid: Guid) -> *AssetRecord {
    return table_find_pointer(*assets.guid_to_asset_record, guid);
}

get_asset_record :: (asset_id: AssetId) -> *AssetRecord {
    ok, guid := get_guid(asset_id);
    if !ok return null;
    return get_asset_record(guid);
}

#import "Random";
#import "graphics/sprites";
#import "core/object_pool";
REN :: #import "graphics/renderer";
#import "Basic";
#import "String";
#import "File_Utilities";
#import "File_Utilities";
#import "jaison";
#import "Reflection";
#import "Hash_Table";
