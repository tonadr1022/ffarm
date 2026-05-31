SpriteRenderer :: struct {
    device: RHI.Device;
    sprites_to_draw: [..]*Sprite;
}

init :: (device: *RHI.Device) {
    sprite_renderer.device = *device;
}

draw_sprite :: (sprite: *Sprite) {
    array_add(sprite_renderer.sprites_to_draw, sprite);
}

shutdown :: () {
}

#scope_file

sprite_renderer: SpriteRenderer;
RHI :: #import "graphics/rhi";
#import "Basic";
#import "graphics/sprites";