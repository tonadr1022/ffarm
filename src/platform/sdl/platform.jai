#import("jai-sdl3");
#import "Basic";
// TODO: graphics backend module parameters

platform_init :: () {
    if !SDL_Init(SDL_InitFlags.VIDEO | SDL_InitFlags.EVENTS) {
        print("Failed to init SDL: %\n", to_string(SDL_GetError()));
        exit(1);
    }
}

// TODO: gate behind vulkan build flag
#if true {

platform_get_vulkan_instance_extensions :: () -> []*u8 {
    result: []*u8;
    count: u32;
    extensions := SDL_Vulkan_GetInstanceExtensions(*count);
    result.data = extensions;
    result.count = count;
    return result;
}

}