#import "graphics/rhi";
#import "Basic";
#import "String";
#import "platform";
#import "jai-sdl3";
#import "Command_Line";
#import "core/object_pool";

#import "box2d";
#import "2d/tilemap";
#import "runtime/assets";
#import "runtime/entity";
#import "game/camera";

#import "graphics/sprites";
#import "File_Utilities";

REN :: #import "graphics/renderer";

CLI_Args :: struct {
    quit_after_frames: s32 = -1;
}

find_root_dir :: () -> string, bool {
    curr_path := get_working_directory();
    while true {
        dir := tprint("%/resources", curr_path);
        print("dir: %\n", dir);
        if is_directory(dir) return copy_string(curr_path), true;
        curr_path = path_basename(curr_path);
    }
    return .{}, false;
}

animation2d_play :: (entity: *Entity, name: string) {
    sprite_asset := get(entity.sprite);
    for * animation : sprite_asset.animations {
        if equal(animation.name, name) {
            if entity.animation2d_player.playing && entity.animation2d_player.curr_animation_idx == it_index {
                return;
            }
            entity.animation2d_player.curr_animation_idx = xx it_index;
            entity.animation2d_player.state = Animation2DState.{current_frame=0, time=0};
            entity.animation2d_player.playing = true;
            return;
        }
    }
    log_error("Failed to find animation: %\n", name);
    exit(1);
}

animation2d_advance :: (entity: *Entity, dt: float) {
    player := *entity.animation2d_player;
    if !player.playing return;
    state := *player.state;
    sprite_asset := get(entity.sprite);
    animation := *sprite_asset.animations[player.curr_animation_idx];
    state.time += dt;
    if state.time > animation.frames[state.current_frame].duration {
        state.time -= animation.frames[state.current_frame].duration;
        state.current_frame = (state.current_frame + 1) % cast(u32)animation.frames.count;
        if state.current_frame >= animation.frames.count {
            state.current_frame = 0;
        }
    }
}

animation2d_stop :: (entity: *Entity) {
    player := *entity.animation2d_player;
    player.playing = false;
}

World :: struct {
    entities: ObjectPool(Entity);
}


EntityHandle :: ObjectPool(Entity).HandleT;

world_init :: (reserve_entity_count: int) {
    obj_pool_reserve(*world.entities, reserve_entity_count);
}

world_update :: (world: *World, dt: float) {
    for * entity : world.entities {
        animation2d_advance(entity, dt);
    }
}

world: World;

world_spawn :: () -> EntityHandle {
    return obj_pool_alloc(*world.entities);
}

world_destroy :: (ent: EntityHandle) {
    e := world_get(ent);
    if !e return;
    if e.flags & .TILEMAP {
        unload_asset(e.tilemap);
    }
}

world_get :: (ent: EntityHandle) -> *Entity {
    return get(*world.entities, ent);
}

PhysicsWorld :: struct {
    b2world: b2WorldId;
}

physics: PhysicsWorld;

main :: () {
    rdir, found := find_root_dir();
    if !found { print("failed to find root dir\n"); exit(1); }
    set_working_directory(rdir);

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

    ASSET_SOURCE_DIR :: "resources/assets/source";
    ASSET_COOKED_DIR :: "resources/assets/cooked";

    assets_init(ASSET_SOURCE_DIR, ASSET_COOKED_DIR);

    world_init(10000);

    {
        // physics experimenting
        world_def := b2DefaultWorldDef();
        world_def.gravity = .{0, -10};
        physics.b2world = b2CreateWorld(*world_def);
    }

    {
        tilemap_ent := world_spawn();
        ent := world_get(tilemap_ent);
        ent.flags |= .TILEMAP;
        ent.tilemap = load_asset("farm/tilemap-main");
    }

    should_quit := false;

    success, handle := load_sprite("/home/tony/Downloads/Farm RPG FREE 16x16 - Tiny Asset Pack/Character/character-all.json");
    if !success {
        print("Failed to load sprite\n");
        exit(1);
    }

    sprite_ent := world_spawn();
    {
        entity := world_get(sprite_ent);
        entity.flags |= .SPRITE;
        entity.sprite = handle;
        entity.transform.position = .{200, 300, 1};
        entity.transform.scale = 4.0;
        animation2d_play(entity, "idle_down");
    }

    win_w, win_h := window_get_size(*window);
    viewport: Viewport = .{width=win_w, height=win_h};
    camera: Camera2D = .{position=.{cast(float)win_w * 0.5, cast(float)win_h * 0.5}, zoom=1.0};

    frame_number := 0;
    last_ticks := SDL_GetTicks();
    while !should_quit {
        now := SDL_GetTicks();
        dt := cast(float)(now - last_ticks);
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
        move_speed := dt * 0.2;

        {
            entity := world_get(sprite_ent);
            if keys[SDL_Scancode.W] {
                entity.transform.position.y -= move_speed;
                animation2d_play(entity, "walk_up");
            } else if keys[SDL_Scancode.S] {
                entity.transform.position.y += move_speed;
                animation2d_play(entity, "walk_down");
            } else if keys[SDL_Scancode.A] {
                entity.transform.position.x -= move_speed;
                animation2d_play(entity, "walk_left");
            } else if keys[SDL_Scancode.D] {
                entity.transform.position.x += move_speed;
                animation2d_play(entity, "walk_right");
            } else {
                animation2d_play(entity, "idle_down");
            }
        }

        world_update(*world, dt);

        REN.sprite_renderer_begin_frame(camera.position, camera2d_get_world_to_clip(camera, viewport));

        for * entity : world.entities {
            if entity.flags & .SPRITE {
                sprite_asset := get(entity.sprite);
                anim_player := *entity.animation2d_player;
                anim_state := *anim_player.state;
                frame_sprite := *sprite_asset.animations[anim_player.curr_animation_idx].frames[anim_state.current_frame].sprite;
                instance := entity_make_sprite_instance(entity, frame_sprite);
                REN.sprite_renderer_draw(sprite_asset.texture_view, instance);
            }

            if entity.flags & .TILEMAP {
                tm := asset_get_tilemap(entity.tilemap);
                ts := asset_get_tileset(tm.tileset_id);
                tile_w := cast(float) ts.tile_w;
                tile_h := cast(float) ts.tile_h;
                for y: 0..tm.len_y-1 {
                    for x: 0..tm.len_x-1 {
                        val := tilemap_get(tm, xx x, xx y);
                        if val == 0 continue;

                        uv_min, uv_max := tileset_get_uvs(ts, val);
                        instance : REN.SpriteInstance = .{
                            pos=.{x * tile_w, y * tile_h},
                            size=.{tile_w, tile_h},
                            uv_min=uv_min,
                            uv_max=uv_max,
                            color=.{1,1,1,1},
                            depth=0,
                        };
                        REN.sprite_renderer_draw(ts.tex_view, instance);
                    }
                }
            }
        }


        REN.do_render();

        frame_number+=1;
        if args.quit_after_frames != -1 && frame_number >= args.quit_after_frames {
            should_quit = true;
        }
    }

    REN.wait_for_device();

    for * entity : world.entities {
        world_destroy(it_handle);
    }
    unload_sprite(handle);

    assets_shutdown();

    REN.shutdown();
}
