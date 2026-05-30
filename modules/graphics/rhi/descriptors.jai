ROOT_CBV_COUNT :: 3;
DESCRIPTOR_TABLE_CBV_COUNT :: 9;
TOTAL_CBV_BINDINGS :: ROOT_CBV_COUNT + DESCRIPTOR_TABLE_CBV_COUNT;
TOTAL_SRV_BINDINGS :: 12;
TOTAL_UAV_BINDINGS :: 12;

DescriptorBindingTable :: struct {
    CBV: [TOTAL_CBV_BINDINGS]*Buffer;
    CBV_offsets: [TOTAL_CBV_BINDINGS]int;
    CBV_sizes: [TOTAL_CBV_BINDINGS]int;
    // uint64_t version of rhi::BufferHandle/TextureHandle
    SRV_buffers: [TOTAL_SRV_BINDINGS]*Buffer;
    SRV_textures: [TOTAL_SRV_BINDINGS]*Texture;
    // -2 == buffer, -1 == texture, >= 0 == texture view;
    SRV_subresources: [TOTAL_SRV_BINDINGS]int;
    k_tex_resource :: -1;
    k_buffer_resource :: -2;
    SRV_offsets: [TOTAL_SRV_BINDINGS]int;
    UAV_buffers: [TOTAL_UAV_BINDINGS]*Buffer;
    UAV_textures: [TOTAL_UAV_BINDINGS]*Texture;
    // -2 == buffer, -1 == texture, >= 0 == texture view;
    UAV_subresources: [TOTAL_SRV_BINDINGS]int;
    UAV_offsets: [TOTAL_SRV_BINDINGS]int;
};


