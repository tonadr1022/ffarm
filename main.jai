#import "Basic";
#import("jai-sdl3");

main :: () {
    if !SDL_Init(SDL_INIT_VIDEO | SDL_INIT_EVENTS) {
        err_c_str := SDL_GetError();
        print("Failed to init SDL: %\n", string.{data=err_c_str, count=c_style_strlen(err_c_str)});
        exit(1);
    }
    window := SDL_CreateWindow("window", 100, 100, SDL_WindowFlags.FULLSCREEN);

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
