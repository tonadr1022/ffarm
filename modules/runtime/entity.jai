Transform :: struct {
    position: Vector3;
    rotation: Quaternion;
    scale: float = 1.0;
}

Entity :: struct {
    transform: Transform;
    sprite: SpriteAssetHandle;
    animation2d_player: Animation2DPlayer;
}

entity_make_sprite_instance :: (entity: *Entity, sprite: *Sprite) -> SpriteInstance {
    using entity.transform;
    w := cast(float)sprite.frame_w * scale;
    h := cast(float)sprite.frame_h * scale;
    return SpriteInstance.{
        pos=.{position.x, position.y},
        size=.{w, h},
        uv_min=sprite.uv_min,
        uv_max=sprite.uv_max,
        color=sprite.color,
        depth=position.z,
    };
}

#import "Math";
#import "runtime/assets";
#import "graphics/sprites";
#import "graphics/renderer";
