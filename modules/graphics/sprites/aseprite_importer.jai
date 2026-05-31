AsepriteRect :: struct {
    x, y, w, h: s32;
}

AsepriteSourceSize :: struct {
    w, h: s32;
}

AsepriteFrame :: struct {
    frame: AsepriteRect;
    rotated: bool;
    trimmed: bool;
    spriteSourceSize: AsepriteRect;
    sourceSize: AsepriteSourceSize;
    duration: s32;
}

AsepriteFrameTag :: struct {
    name: string;
    from: s32;
    to: s32;
    direction: string;
    color: string; // hex color
}

AsepriteMeta :: struct {
    app: string;
    version: string;
    image: string;
    format: string;
    size: AsepriteSourceSize;
    scale: string;
    frameTags: [..]AsepriteFrameTag;
}

AsepriteSheet :: struct {
    frames: [..]AsepriteFrame;
    meta: AsepriteMeta;
}

aseprite_sheet_destroy :: (sheet: *AsepriteSheet) {
    array_reset(*sheet.frames);
    free(sheet.meta.app);
    free(sheet.meta.version);
    free(sheet.meta.image);
    free(sheet.meta.format);
    free(sheet.meta.scale);
}

load_sprite_2d_asset_metadata :: (filename: string, asset: *SpriteAsset) -> success: bool {
    ok, root := json_parse_file(filename, AsepriteSheet);
    defer aseprite_sheet_destroy(*root);
    if !ok return false;
    convert_aseprite_to_engine_format(*root, asset, filename);
    return true;
}

#scope_file

convert_aseprite_to_engine_format :: (sheet: *AsepriteSheet, asset: *SpriteAsset, metadata_filename: string) {
    asset.path = path_join(path_strip_filename(metadata_filename), sheet.meta.image);
    for * frame_tag : sheet.meta.frameTags {
        animation: SpriteAnimation2D;
        animation.name = copy_string(frame_tag.name);
        for frame_tag.from..frame_tag.to-1 {
            frame: SpriteAnimation2DFrame;
            sheet_frame: *AsepriteFrame = *sheet.frames[it];
            frame.duration = cast(float)sheet_frame.duration;
            frame.sprite.uv_min = .{cast(float)sheet_frame.frame.x / cast(float)sheet.meta.size.w, 
                                            cast(float)sheet_frame.frame.y / cast(float)sheet.meta.size.h};
            frame.sprite.uv_max = .{cast(float)(sheet_frame.frame.x + sheet_frame.frame.w) / cast(float)sheet.meta.size.w, 
                                            cast(float)(sheet_frame.frame.y + sheet_frame.frame.h) / cast(float)sheet.meta.size.h};

            array_add(*animation.frames, frame);
        }
        array_add(*asset.animations, animation);
    }
}

hex_color_to_float :: (color: string) -> Vector4 {
    r, g, b, a := parse_hex_color(color);
    return Vector4.{r, g, b, a};
}

parse_hex_color :: (color: string) -> r: float, g: float, b: float, a: float {
    number := trim_left(color, "#");
    value, ok := string_to_int(number, base=16, T=u32);
    if !ok return 0, 0, 0, 1;

    if number.count == 6 {
        return cast(float)((value >> 16) & 0xff) / 255.0,
               cast(float)((value >> 8) & 0xff) / 255.0,
               cast(float)(value & 0xff) / 255.0,
               1.0;
    }

    return cast(float)((value >> 24) & 0xff) / 255.0,
           cast(float)((value >> 16) & 0xff) / 255.0,
           cast(float)((value >> 8) & 0xff) / 255.0,
           cast(float)(value & 0xff) / 255.0;
}

#import "jaison";
#import "Hash_Table";
#import "Basic";
#import "Math";
#import "String";
