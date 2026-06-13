TILEMAP_MAGIC :: #run (.*) cast(*u32) "TMCK".data;
TILESET_MAGIC :: #run (.*) cast(*u32) "TSCK".data;

write_cooked_asset_file_header :: (f: *File, type: AssetType, version: u32) -> bool {
    magic := get_magic(type);
    if !file_write(f, *magic, size_of(type_of(magic))) return false;
    if !file_write(f, *version, size_of(type_of(version))) return false;
    return true;
}

read_cooked_asset_file_header :: (f: File, type: AssetType, expected_version: u32) -> bool {
    ok := true;
    expected_magic := get_magic(type);

    magic: u32;
    if !file_read(f, *magic, size_of(type_of(magic))) return false;
    if magic != expected_magic return false;

    version: u32;
    if !file_read(f, *version, size_of(type_of(version))) return false;
    if version != expected_version return false;

    return true;
}

#scope_file

get_magic :: (type: AssetType) -> u32 {
    if type == {
        case .TILE_MAP; return TILEMAP_MAGIC;
        case .TILE_SET; return TILESET_MAGIC;
    }
    assert(false, "invalid asset type: %\n", type);
    return 0;
}

#import "File";
