#import "graphics/rhi";
#import "Basic";
#import "platform";
#import "jai-sdl3";
#import "Command_Line";
#import "Hash_Table";
#import "core/object_pool";

#import "runtime/assets";
#import "runtime/entity";
#import "game/camera";

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
    if !success {
        print("Failed to load sprite\n");
        exit(1);
    }

    entity: Entity;
    entity.sprite = handle;
    entity.transform.position = .{200, 300, 0};
    entity.transform.scale = 4.0;

    win_w, win_h := window_get_size(*window);
    viewport: Viewport = .{width=win_w, height=win_h};
    camera: Camera2D = .{position=.{cast(float)win_w * 0.5, cast(float)win_h * 0.5}, zoom=1.0};

    frame_number := 0;
    last_ticks := SDL_GetTicks();
    while !should_quit {
        now := SDL_GetTicks();
        dt := cast(float)(now - last_ticks) / 1000.0;
        last_ticks = now;

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

        keys := SDL_GetKeyboardState(null);
        move_speed := 200.0 * dt;
        if keys[SDL_Scancode.W] entity.transform.position.y -= move_speed;
        if keys[SDL_Scancode.S] entity.transform.position.y += move_speed;
        if keys[SDL_Scancode.A] entity.transform.position.x -= move_speed;
        if keys[SDL_Scancode.D] entity.transform.position.x += move_speed;

        sprite_asset := get(handle);
        frame_sprite := *sprite_asset.animations[0].frames[0].sprite;
        instance := entity_make_sprite_instance(*entity, frame_sprite);

        REN.sprite_renderer_begin_frame(camera.position, camera2d_get_world_to_clip(camera, viewport));
        REN.sprite_renderer_draw(sprite_asset.texture_view, instance);
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
