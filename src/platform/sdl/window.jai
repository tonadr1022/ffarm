WindowBackend :: struct {
    sdl_window: *SDL_Window;
    surface: SurfaceT;
}

window_init :: (window: *Window, title: string, width: s32, height: s32) -> bool {
    window.sdl_window = SDL_CreateWindow(temp_c_string(title), width, height, 0);
    if window.sdl_window == null {
        print("Failed to create window: %\n", to_string(SDL_GetError()));
        return false;
    }
    return true;
}

window_get_size :: (window: *Window) -> s32, s32 {
    w: s32;
    h: s32;
    SDL_GetWindowSizeInPixels(window.sdl_window, *w, *h);
    return w, h;
}
