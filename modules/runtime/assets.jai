Assets :: struct {
    sprites: ObjectPool(SpriteAsset);
}

assets_init :: () {
}

assets_shutdown :: () {
}

load_sprite :: (path: string) -> success: bool, handle: SpriteAssetHandle {
    handle: SpriteAssetHandle = obj_pool_alloc(*assets.sprites);
    if !load_sprite_2d_asset_metadata(path, get(handle)) {
        obj_pool_free(*assets.sprites, handle);
        return false, handle;
    }
    // upload to gpu
    sprite_asset: *SpriteAsset = get(handle);
    print("frame 0: %\n", sprite_asset.animations[0].frames[0].sprite);
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

#import "graphics/sprites";
#import "core/object_pool";
REN :: #import "graphics/renderer";
#import "Basic";