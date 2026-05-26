#import("jai-sdl3");
#import "Basic";

platform_init :: () {
    if !SDL_Init(SDL_InitFlags.VIDEO | SDL_InitFlags.EVENTS) {
        print("Failed to init SDL: %\n", to_string(SDL_GetError()));
        exit(1);
    }
    if !SDL_Vulkan_LoadLibrary(null) {
        print("Failed to load Vulkan: %\n", to_string(SDL_GetError()));
        exit(1);
    }
}
