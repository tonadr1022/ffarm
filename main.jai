#import "graphics/rhi";
#import "Basic";
#import "platform";
#import "jai-sdl3";
#import "Command_Line";
#import "Hash_Table";
#import "core/object_pool";

#import "runtime/assets";

REN :: #import "graphics/renderer";

CLI_Args :: struct {
    quit_after_frames: s32 = -1;
}


main :: () {
    ok, args, is_set, free_args := parse_arguments(CLI_Args);
    if is_set.quit_after_frames {
        print("Quitting after % frames\n", args.quit_after_frames);
    }
    if !ok {
        print("Error: Failed to parse command line arguments\n");
        exit(1);
    }


    platform_init();
    window: Window;
    window_init(*window, "window", 800, 800);
    REN.init(*window);

    should_quit := false;

    success, handle := load_sprite("/home/tony/Downloads/Farm RPG FREE 16x16 - Tiny Asset Pack/Character/character-all.json");

    frame_number := 0;
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

        sprite_asset := get(handle);
        sprite := *sprite_asset.animations[0].frames[0].sprite;
        sprite.texture = sprite_asset.texture;
        sprite.texture_view = sprite_asset.texture_view;
        REN.sprite_renderer_draw_sprite(sprite);

        REN.do_render();

        frame_number+=1;
        if args.quit_after_frames != -1 && frame_number >= args.quit_after_frames {
            should_quit = true;
        }
    }

    REN.wait_for_device();

    unload_sprite(handle);

    REN.shutdown();

    print("hello world!\n");
}
