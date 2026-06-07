// TODO: letterboxing, split screen, etc.
Viewport :: struct {
    x, y: s32;
    width, height: s32;
}

Camera2D :: struct {
    position: Vector2;
    zoom: float = 1.0;
}

camera2d_get_projection :: (camera: Camera2D, viewport: Viewport) -> Matrix4 {
    half_w := cast(float)viewport.width * 0.5 / camera.zoom;
    half_h := cast(float)viewport.height * 0.5 / camera.zoom;
    left := camera.position.x - half_w;
    right := camera.position.x + half_w;
    bottom := camera.position.y - half_h;
    top := camera.position.y + half_h;

    return orthographic_projection_matrix(left, right, bottom, top, -1.0, 1.0);
}

camera2d_get_view :: (camera: Camera2D) -> Matrix4 {
    // pan: move world opposite to camera
    return make_translation_matrix4(.{-camera.position.x,-camera.position.y, 0});
}

camera2d_get_view_projection :: (camera: Camera2D, viewport: Viewport) -> Matrix4 {
    return camera2d_get_projection(camera, viewport) * camera2d_get_view(camera);
}

camera2d_get_world_to_clip :: (camera: Camera2D, viewport: Viewport) -> Vector2 {
    // Negate Y to match set_viewport_scissor's negative height (Vulkan HLSL Y flip).
    return .{
        2.0 * camera.zoom / cast(float)viewport.width,
        -2.0 * camera.zoom / cast(float)viewport.height,
    };
}

#import "Math";