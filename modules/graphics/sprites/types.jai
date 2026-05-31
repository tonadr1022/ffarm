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
    // TODO: many sprites share this. this is waste
    texture: TextureHandle;
    texture_view: TextureViewHandle;
    color: Vector4 = Vector4.{1.0, 1.0, 1.0, 1.0};
    uv_min: Vector2;
    uv_max: Vector2;
}

#import "Math";
#import "Hash_Table";
#import "Basic";
#import "asset";
#import "graphics/renderer";