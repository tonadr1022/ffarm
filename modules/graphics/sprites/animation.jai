play_animation2D :: (entity: *Entity, name: string) {
    sprite_asset := get(entity.sprite);
    for * animation : sprite_asset.animations {
        if animation.name == name {
            return;
        }
    }
}

// TODO: animation state

Animation2DState :: struct {
    current_frame: u32;
    time: float;
}

#scope_file