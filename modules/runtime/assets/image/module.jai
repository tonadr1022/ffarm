Image :: struct {
    tex: TextureHandle;
    tex_view: TextureViewHandle;
}

image_cook :: (raw_path: string, cooked_path: string) -> bool {
    // eventually convert to KTX2 etc. For now just copy the image over
    return copy_file(raw_path, cooked_path);
}

image_read_cooked :: (path: string) -> Image, bool {
    img: Image;
    ok: bool;
    img.tex, img.tex_view, ok = load_img_from_cpu(path);
    return img, ok;
}

image_destroy :: (img: *Image) {
    texture_destroy(img.tex);
    texture_view_destroy(img.tex_view);
}

#import "graphics/renderer";
#import "File_Utilities";
#import "File";
