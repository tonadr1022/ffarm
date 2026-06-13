SpriteAnimation2DFrame :: struct {
    duration: float;
    sprite: Sprite;
}

SpriteAnimation2D :: struct {
    name: string;
    frames: [..]SpriteAnimation2DFrame;
}

SpriteAsset :: struct {
    using info: AssetInfo;
    texture: TextureHandle;
    texture_view: TextureViewHandle;
    animations: [..]SpriteAnimation2D;
}

Sprite :: struct {
    color: Vector4 = Vector4.{1.0, 1.0, 1.0, 1.0};
    uv_min: Vector2;
    uv_max: Vector2;
    frame_w: u32;
    frame_h: u32;
}

#scope_file

#import "Math";
#import "Basic";
#import "graphics/renderer";
#import "runtime/assets";

