#import "Basic";
#load "src/platform/platform.jai";
#load "src/graphics/renderer/renderer.jai";

main :: () {
    platform_init();
    window: Window;
    window_init(*window, "window", 800, 800);
    renderer_init(*window);

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

    renderer_shutdown();

    print("hello world!\n");
}
