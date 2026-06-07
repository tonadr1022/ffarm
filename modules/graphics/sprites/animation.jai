Animation2DState :: struct {
    current_frame: u32;
    time: float;
}

Animation2DPlayer :: struct {
    curr_animation_idx: u32;
    state: Animation2DState;
    playing: bool;
}
