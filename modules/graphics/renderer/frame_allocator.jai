FrameGpuAlloc :: struct {
    buf: BufferHandle;
    offset: u32;
    size: u32;
}

FrameGpuAllocator2Type :: enum {
    Uniform;
    Staging;
}

FrameGpuAllocator2 :: struct (type: FrameGpuAllocator2Type) {
    PerFrame :: struct {
        bufs: [..]BufferHandle;
        curr_buf: u32;
        curr_offset: u32;
    }
    frames: [MAX_FRAMES_IN_FLIGHT]PerFrame;
    buffer_default_size_bytes: u32 = 64 * 1024;
}

frame_gpu_allocator2_reset_frame :: (fga: *FrameGpuAllocator2($T), frame_idx: u32) {
    frame_data := *fga.frames[frame_idx];
    frame_data.curr_buf = 0;
    frame_data.curr_offset = 0;
}

frame_gpu_allocator2_alloc :: (fga: *FrameGpuAllocator2($T), size: u32) -> FrameGpuAlloc {
    frame_idx := renderer_get_curr_frame_in_flight_idx();
    frame_data := *fga.frames[frame_idx];

    found_buf_idx := -1;
    for buf_idx : frame_data.curr_buf..frame_data.bufs.count-1 {
        if buf_idx < frame_data.bufs.count &&
            frame_data.curr_offset + size <= get(frame_data.bufs[buf_idx]).desc.size {
            found_buf_idx = buf_idx;
            break;
        }
    }

    if found_buf_idx == -1 {
        desc := RHI.BufferDesc.{
            size=max(fga.buffer_default_size_bytes, align_up(size, fga.buffer_default_size_bytes)),
            flags=.HostVisible,
            name="FrameGpuAllocator2 buffer",
        };
        if T == .Uniform {
            desc.usage = .Uniform;
        }
        array_add(*frame_data.bufs, buffer_create(*desc));
        found_buf_idx = xx frame_data.bufs.count - 1;
    }

    frame_data.curr_buf = xx found_buf_idx;

    result := FrameGpuAlloc.{
        buf=frame_data.bufs[found_buf_idx],
        offset=frame_data.curr_offset,
        size=size,
    };
    frame_data.curr_offset += size;
    return result;
}

frame_gpu_allocator2_alloc :: (fga: *FrameGpuAllocator2($T), data: *$Data) -> FrameGpuAlloc {
    alloc := frame_gpu_allocator2_alloc(fga, size_of(Data));
    memcpy(get(alloc.buf).data + alloc.offset, data, size_of(Data));
    return alloc;
}

frame_gpu_allocator2_destroy :: (fga: *FrameGpuAllocator2($T)) {
    for * frame : fga.frames {
        for * buf : frame.bufs {
            buffer_destroy(buf);
        }
    }
}

#scope_file 

RHI :: #import "graphics/rhi";

align_up :: (value: u32, alignment: u32) -> u32 {
    return (value + alignment - 1) & cast(u32)(~(alignment - 1));
}