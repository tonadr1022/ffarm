
Assets :: struct {
    sprites: ObjectPool(SpriteAsset);
}


assets_init :: () {

}

load_sprite :: (path: string) -> success: bool, handle: SpriteAssetHandle {
    handle: SpriteAssetHandle = obj_pool_alloc(*assets.sprites);
    success := load_sprite_2d_asset(path, get(handle));
    if !success {
        obj_pool_free(*assets.sprites, handle);
        return false, handle;
    }
    return true, handle;
}

get :: (handle: SpriteAssetHandle) -> *SpriteAsset {
    return get(*assets.sprites, handle);
}

SpriteAssetHandle :: ObjectPool(SpriteAsset).HandleT;


#scope_file

assets: Assets;

#import "graphics/sprites";
#import "core/object_pool";