#import "Basic";
#import("jai-sdl3");
#load "src/graphics/device.jai";

main :: () {
    if !SDL_Init(SDL_InitFlags.VIDEO | SDL_InitFlags.EVENTS) {
        err_c_str := SDL_GetError();
        print("Failed to init SDL: %\n", string.{data=err_c_str, count=c_style_strlen(err_c_str)});
        exit(1);
    }
    window := SDL_CreateWindow("window", 800, 800, 0);
    settings: DeviceSettings = .{exit_on_validation_layer_error=true, validation_layers_enabled=true};
    device := device_init(*settings);
    defer device_free(*device);

    should_quit := false;

    while !should_quit {
        ev: SDL_Event;
        while (SDL_PollEvent(*ev)) {
            if ev.type == {
                case xx SDL_EventType.QUIT;
                    should_quit = true;
                case xx SDL_EventType.KEY_DOWN;
                    if ev.key.key == SDLK_ESCAPE
                        should_quit = true;
                case;
            }
        }
    }

    print("hello world!\n");
}
