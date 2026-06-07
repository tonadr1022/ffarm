DeviceSettings :: struct {
    validation_layers_enabled: bool;
    exit_on_validation_layer_error: bool;
    frames_in_flight: u32; // 2 or 3
}

SurfaceT :: struct {
    _handle: u64;
}

DeviceInfo :: struct {
    // todo: check actually
    is_unified_memory :: false;
}
Device :: struct {
    using specific: DeviceBackend;
    info: DeviceInfo;
}

CommandQueue :: struct {
    using specific: CommandQueueBackend;
}

CommandPool :: struct {
    using specific: CommandPoolBackend;
}

CommandBuffer :: struct {
    using specific: CommandBufferBackend;
    binding_table: DescriptorBindingTable;
    descriptors_dirty: bool;
    bound_pipeline: *Pipeline;
}

Swapchain :: struct {
    using specific: SwapchainBackend;
    format: TextureFormat;
    extent: Extent2D;
    image_count: u32;
}

SwapchainFrame :: struct {
    image_index: u32;
    texture: *Texture;
    view: *TextureView;
}

Semaphore :: struct {
    using specific: SemaphoreBackend;
}

Fence :: struct {
    using specific: FenceBackend;
}

BufferCreateFlags :: enum_flags u32 {
    None :: 0;
    HostVisible :: 1 << 0;
};

BufferUsageFlags :: enum_flags u32 {
    None :: 0;
    TransferSrc :: 1 << 0;
    TransferDst :: 1 << 1;
    Uniform :: 1 << 2;
    Storage :: 1 << 3;
    Vertex :: 1 << 4;
};

BufferDesc :: struct {
    size: u32;
    flags: BufferCreateFlags;
    usage: BufferUsageFlags = .TransferDst | .TransferSrc;
    name: string;
}

Buffer :: struct {
    using specific: BufferBackend;
    data: *void;
}

// matches VkFormat
TextureFormat :: enum {
    UNDEFINED                                      :: 0;
    R4G4_UNORM_PACK8                               :: 1;
    R4G4B4A4_UNORM_PACK16                          :: 2;
    B4G4R4A4_UNORM_PACK16                          :: 3;
    R5G6B5_UNORM_PACK16                            :: 4;
    B5G6R5_UNORM_PACK16                            :: 5;
    R5G5B5A1_UNORM_PACK16                          :: 6;
    B5G5R5A1_UNORM_PACK16                          :: 7;
    A1R5G5B5_UNORM_PACK16                          :: 8;
    R8_UNORM                                       :: 9;
    R8_SNORM                                       :: 10;
    R8_USCALED                                     :: 11;
    R8_SSCALED                                     :: 12;
    R8_UINT                                        :: 13;
    R8_SINT                                        :: 14;
    R8_SRGB                                        :: 15;
    R8G8_UNORM                                     :: 16;
    R8G8_SNORM                                     :: 17;
    R8G8_USCALED                                   :: 18;
    R8G8_SSCALED                                   :: 19;
    R8G8_UINT                                      :: 20;
    R8G8_SINT                                      :: 21;
    R8G8_SRGB                                      :: 22;
    R8G8B8_UNORM                                   :: 23;
    R8G8B8_SNORM                                   :: 24;
    R8G8B8_USCALED                                 :: 25;
    R8G8B8_SSCALED                                 :: 26;
    R8G8B8_UINT                                    :: 27;
    R8G8B8_SINT                                    :: 28;
    R8G8B8_SRGB                                    :: 29;
    B8G8R8_UNORM                                   :: 30;
    B8G8R8_SNORM                                   :: 31;
    B8G8R8_USCALED                                 :: 32;
    B8G8R8_SSCALED                                 :: 33;
    B8G8R8_UINT                                    :: 34;
    B8G8R8_SINT                                    :: 35;
    B8G8R8_SRGB                                    :: 36;
    R8G8B8A8_UNORM                                 :: 37;
    R8G8B8A8_SNORM                                 :: 38;
    R8G8B8A8_USCALED                               :: 39;
    R8G8B8A8_SSCALED                               :: 40;
    R8G8B8A8_UINT                                  :: 41;
    R8G8B8A8_SINT                                  :: 42;
    R8G8B8A8_SRGB                                  :: 43;
    B8G8R8A8_UNORM                                 :: 44;
    B8G8R8A8_SNORM                                 :: 45;
    B8G8R8A8_USCALED                               :: 46;
    B8G8R8A8_SSCALED                               :: 47;
    B8G8R8A8_UINT                                  :: 48;
    B8G8R8A8_SINT                                  :: 49;
    B8G8R8A8_SRGB                                  :: 50;
    A8B8G8R8_UNORM_PACK32                          :: 51;
    A8B8G8R8_SNORM_PACK32                          :: 52;
    A8B8G8R8_USCALED_PACK32                        :: 53;
    A8B8G8R8_SSCALED_PACK32                        :: 54;
    A8B8G8R8_UINT_PACK32                           :: 55;
    A8B8G8R8_SINT_PACK32                           :: 56;
    A8B8G8R8_SRGB_PACK32                           :: 57;
    A2R10G10B10_UNORM_PACK32                       :: 58;
    A2R10G10B10_SNORM_PACK32                       :: 59;
    A2R10G10B10_USCALED_PACK32                     :: 60;
    A2R10G10B10_SSCALED_PACK32                     :: 61;
    A2R10G10B10_UINT_PACK32                        :: 62;
    A2R10G10B10_SINT_PACK32                        :: 63;
    A2B10G10R10_UNORM_PACK32                       :: 64;
    A2B10G10R10_SNORM_PACK32                       :: 65;
    A2B10G10R10_USCALED_PACK32                     :: 66;
    A2B10G10R10_SSCALED_PACK32                     :: 67;
    A2B10G10R10_UINT_PACK32                        :: 68;
    A2B10G10R10_SINT_PACK32                        :: 69;
    R16_UNORM                                      :: 70;
    R16_SNORM                                      :: 71;
    R16_USCALED                                    :: 72;
    R16_SSCALED                                    :: 73;
    R16_UINT                                       :: 74;
    R16_SINT                                       :: 75;
    R16_SFLOAT                                     :: 76;
    R16G16_UNORM                                   :: 77;
    R16G16_SNORM                                   :: 78;
    R16G16_USCALED                                 :: 79;
    R16G16_SSCALED                                 :: 80;
    R16G16_UINT                                    :: 81;
    R16G16_SINT                                    :: 82;
    R16G16_SFLOAT                                  :: 83;
    R16G16B16_UNORM                                :: 84;
    R16G16B16_SNORM                                :: 85;
    R16G16B16_USCALED                              :: 86;
    R16G16B16_SSCALED                              :: 87;
    R16G16B16_UINT                                 :: 88;
    R16G16B16_SINT                                 :: 89;
    R16G16B16_SFLOAT                               :: 90;
    R16G16B16A16_UNORM                             :: 91;
    R16G16B16A16_SNORM                             :: 92;
    R16G16B16A16_USCALED                           :: 93;
    R16G16B16A16_SSCALED                           :: 94;
    R16G16B16A16_UINT                              :: 95;
    R16G16B16A16_SINT                              :: 96;
    R16G16B16A16_SFLOAT                            :: 97;
    R32_UINT                                       :: 98;
    R32_SINT                                       :: 99;
    R32_SFLOAT                                     :: 100;
    R32G32_UINT                                    :: 101;
    R32G32_SINT                                    :: 102;
    R32G32_SFLOAT                                  :: 103;
    R32G32B32_UINT                                 :: 104;
    R32G32B32_SINT                                 :: 105;
    R32G32B32_SFLOAT                               :: 106;
    R32G32B32A32_UINT                              :: 107;
    R32G32B32A32_SINT                              :: 108;
    R32G32B32A32_SFLOAT                            :: 109;
    R64_UINT                                       :: 110;
    R64_SINT                                       :: 111;
    R64_SFLOAT                                     :: 112;
    R64G64_UINT                                    :: 113;
    R64G64_SINT                                    :: 114;
    R64G64_SFLOAT                                  :: 115;
    R64G64B64_UINT                                 :: 116;
    R64G64B64_SINT                                 :: 117;
    R64G64B64_SFLOAT                               :: 118;
    R64G64B64A64_UINT                              :: 119;
    R64G64B64A64_SINT                              :: 120;
    R64G64B64A64_SFLOAT                            :: 121;
    B10G11R11_UFLOAT_PACK32                        :: 122;
    E5B9G9R9_UFLOAT_PACK32                         :: 123;
    D16_UNORM                                      :: 124;
    X8_D24_UNORM_PACK32                            :: 125;
    D32_SFLOAT                                     :: 126;
    S8_UINT                                        :: 127;
    D16_UNORM_S8_UINT                              :: 128;
    D24_UNORM_S8_UINT                              :: 129;
    D32_SFLOAT_S8_UINT                             :: 130;
    BC1_RGB_UNORM_BLOCK                            :: 131;
    BC1_RGB_SRGB_BLOCK                             :: 132;
    BC1_RGBA_UNORM_BLOCK                           :: 133;
    BC1_RGBA_SRGB_BLOCK                            :: 134;
    BC2_UNORM_BLOCK                                :: 135;
    BC2_SRGB_BLOCK                                 :: 136;
    BC3_UNORM_BLOCK                                :: 137;
    BC3_SRGB_BLOCK                                 :: 138;
    BC4_UNORM_BLOCK                                :: 139;
    BC4_SNORM_BLOCK                                :: 140;
    BC5_UNORM_BLOCK                                :: 141;
    BC5_SNORM_BLOCK                                :: 142;
    BC6H_UFLOAT_BLOCK                              :: 143;
    BC6H_SFLOAT_BLOCK                              :: 144;
    BC7_UNORM_BLOCK                                :: 145;
    BC7_SRGB_BLOCK                                 :: 146;
    ETC2_R8G8B8_UNORM_BLOCK                        :: 147;
    ETC2_R8G8B8_SRGB_BLOCK                         :: 148;
    ETC2_R8G8B8A1_UNORM_BLOCK                      :: 149;
    ETC2_R8G8B8A1_SRGB_BLOCK                       :: 150;
    ETC2_R8G8B8A8_UNORM_BLOCK                      :: 151;
    ETC2_R8G8B8A8_SRGB_BLOCK                       :: 152;
    EAC_R11_UNORM_BLOCK                            :: 153;
    EAC_R11_SNORM_BLOCK                            :: 154;
    EAC_R11G11_UNORM_BLOCK                         :: 155;
    EAC_R11G11_SNORM_BLOCK                         :: 156;
    ASTC_4x4_UNORM_BLOCK                           :: 157;
    ASTC_4x4_SRGB_BLOCK                            :: 158;
    ASTC_5x4_UNORM_BLOCK                           :: 159;
    ASTC_5x4_SRGB_BLOCK                            :: 160;
    ASTC_5x5_UNORM_BLOCK                           :: 161;
    ASTC_5x5_SRGB_BLOCK                            :: 162;
    ASTC_6x5_UNORM_BLOCK                           :: 163;
    ASTC_6x5_SRGB_BLOCK                            :: 164;
    ASTC_6x6_UNORM_BLOCK                           :: 165;
    ASTC_6x6_SRGB_BLOCK                            :: 166;
    ASTC_8x5_UNORM_BLOCK                           :: 167;
    ASTC_8x5_SRGB_BLOCK                            :: 168;
    ASTC_8x6_UNORM_BLOCK                           :: 169;
    ASTC_8x6_SRGB_BLOCK                            :: 170;
    ASTC_8x8_UNORM_BLOCK                           :: 171;
    ASTC_8x8_SRGB_BLOCK                            :: 172;
    ASTC_10x5_UNORM_BLOCK                          :: 173;
    ASTC_10x5_SRGB_BLOCK                           :: 174;
    ASTC_10x6_UNORM_BLOCK                          :: 175;
    ASTC_10x6_SRGB_BLOCK                           :: 176;
    ASTC_10x8_UNORM_BLOCK                          :: 177;
    ASTC_10x8_SRGB_BLOCK                           :: 178;
    ASTC_10x10_UNORM_BLOCK                         :: 179;
    ASTC_10x10_SRGB_BLOCK                          :: 180;
    ASTC_12x10_UNORM_BLOCK                         :: 181;
    ASTC_12x10_SRGB_BLOCK                          :: 182;
    ASTC_12x12_UNORM_BLOCK                         :: 183;
    ASTC_12x12_SRGB_BLOCK                          :: 184;
    G8B8G8R8_422_UNORM                             :: 1000156000;
    B8G8R8G8_422_UNORM                             :: 1000156001;
    G8_B8_R8_3PLANE_420_UNORM                      :: 1000156002;
    G8_B8R8_2PLANE_420_UNORM                       :: 1000156003;
    G8_B8_R8_3PLANE_422_UNORM                      :: 1000156004;
    G8_B8R8_2PLANE_422_UNORM                       :: 1000156005;
    G8_B8_R8_3PLANE_444_UNORM                      :: 1000156006;
    R10X6_UNORM_PACK16                             :: 1000156007;
    R10X6G10X6_UNORM_2PACK16                       :: 1000156008;
    R10X6G10X6B10X6A10X6_UNORM_4PACK16             :: 1000156009;
    G10X6B10X6G10X6R10X6_422_UNORM_4PACK16         :: 1000156010;
    B10X6G10X6R10X6G10X6_422_UNORM_4PACK16         :: 1000156011;
    G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16     :: 1000156012;
    G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16      :: 1000156013;
    G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16     :: 1000156014;
    G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16      :: 1000156015;
    G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16     :: 1000156016;
    R12X4_UNORM_PACK16                             :: 1000156017;
    R12X4G12X4_UNORM_2PACK16                       :: 1000156018;
    R12X4G12X4B12X4A12X4_UNORM_4PACK16             :: 1000156019;
    G12X4B12X4G12X4R12X4_422_UNORM_4PACK16         :: 1000156020;
    B12X4G12X4R12X4G12X4_422_UNORM_4PACK16         :: 1000156021;
    G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16     :: 1000156022;
    G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16      :: 1000156023;
    G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16     :: 1000156024;
    G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16      :: 1000156025;
    G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16     :: 1000156026;
    G16B16G16R16_422_UNORM                         :: 1000156027;
    B16G16R16G16_422_UNORM                         :: 1000156028;
    G16_B16_R16_3PLANE_420_UNORM                   :: 1000156029;
    G16_B16R16_2PLANE_420_UNORM                    :: 1000156030;
    G16_B16_R16_3PLANE_422_UNORM                   :: 1000156031;
    G16_B16R16_2PLANE_422_UNORM                    :: 1000156032;
    G16_B16_R16_3PLANE_444_UNORM                   :: 1000156033;
    G8_B8R8_2PLANE_444_UNORM                       :: 1000330000;
    G10X6_B10X6R10X6_2PLANE_444_UNORM_3PACK16      :: 1000330001;
    G12X4_B12X4R12X4_2PLANE_444_UNORM_3PACK16      :: 1000330002;
    G16_B16R16_2PLANE_444_UNORM                    :: 1000330003;
    A4R4G4B4_UNORM_PACK16                          :: 1000340000;
    A4B4G4R4_UNORM_PACK16                          :: 1000340001;
    ASTC_4x4_SFLOAT_BLOCK                          :: 1000066000;
    ASTC_5x4_SFLOAT_BLOCK                          :: 1000066001;
    ASTC_5x5_SFLOAT_BLOCK                          :: 1000066002;
    ASTC_6x5_SFLOAT_BLOCK                          :: 1000066003;
    ASTC_6x6_SFLOAT_BLOCK                          :: 1000066004;
    ASTC_8x5_SFLOAT_BLOCK                          :: 1000066005;
    ASTC_8x6_SFLOAT_BLOCK                          :: 1000066006;
    ASTC_8x8_SFLOAT_BLOCK                          :: 1000066007;
    ASTC_10x5_SFLOAT_BLOCK                         :: 1000066008;
    ASTC_10x6_SFLOAT_BLOCK                         :: 1000066009;
    ASTC_10x8_SFLOAT_BLOCK                         :: 1000066010;
    ASTC_10x10_SFLOAT_BLOCK                        :: 1000066011;
    ASTC_12x10_SFLOAT_BLOCK                        :: 1000066012;
    ASTC_12x12_SFLOAT_BLOCK                        :: 1000066013;
    A1B5G5R5_UNORM_PACK16                          :: 1000470000;
    A8_UNORM                                       :: 1000470001;
    PVRTC1_2BPP_UNORM_BLOCK_IMG                    :: 1000054000;
    PVRTC1_4BPP_UNORM_BLOCK_IMG                    :: 1000054001;
    PVRTC2_2BPP_UNORM_BLOCK_IMG                    :: 1000054002;
    PVRTC2_4BPP_UNORM_BLOCK_IMG                    :: 1000054003;
    PVRTC1_2BPP_SRGB_BLOCK_IMG                     :: 1000054004;
    PVRTC1_4BPP_SRGB_BLOCK_IMG                     :: 1000054005;
    PVRTC2_2BPP_SRGB_BLOCK_IMG                     :: 1000054006;
    PVRTC2_4BPP_SRGB_BLOCK_IMG                     :: 1000054007;
    ASTC_4x4_SFLOAT_BLOCK_EXT                      :: ASTC_4x4_SFLOAT_BLOCK;
    ASTC_5x4_SFLOAT_BLOCK_EXT                      :: ASTC_5x4_SFLOAT_BLOCK;
    ASTC_5x5_SFLOAT_BLOCK_EXT                      :: ASTC_5x5_SFLOAT_BLOCK;
    ASTC_6x5_SFLOAT_BLOCK_EXT                      :: ASTC_6x5_SFLOAT_BLOCK;
    ASTC_6x6_SFLOAT_BLOCK_EXT                      :: ASTC_6x6_SFLOAT_BLOCK;
    ASTC_8x5_SFLOAT_BLOCK_EXT                      :: ASTC_8x5_SFLOAT_BLOCK;
    ASTC_8x6_SFLOAT_BLOCK_EXT                      :: ASTC_8x6_SFLOAT_BLOCK;
    ASTC_8x8_SFLOAT_BLOCK_EXT                      :: ASTC_8x8_SFLOAT_BLOCK;
    ASTC_10x5_SFLOAT_BLOCK_EXT                     :: ASTC_10x5_SFLOAT_BLOCK;
    ASTC_10x6_SFLOAT_BLOCK_EXT                     :: ASTC_10x6_SFLOAT_BLOCK;
    ASTC_10x8_SFLOAT_BLOCK_EXT                     :: ASTC_10x8_SFLOAT_BLOCK;
    ASTC_10x10_SFLOAT_BLOCK_EXT                    :: ASTC_10x10_SFLOAT_BLOCK;
    ASTC_12x10_SFLOAT_BLOCK_EXT                    :: ASTC_12x10_SFLOAT_BLOCK;
    ASTC_12x12_SFLOAT_BLOCK_EXT                    :: ASTC_12x12_SFLOAT_BLOCK;
    G8B8G8R8_422_UNORM_KHR                         :: G8B8G8R8_422_UNORM;
    B8G8R8G8_422_UNORM_KHR                         :: B8G8R8G8_422_UNORM;
    G8_B8_R8_3PLANE_420_UNORM_KHR                  :: G8_B8_R8_3PLANE_420_UNORM;
    G8_B8R8_2PLANE_420_UNORM_KHR                   :: G8_B8R8_2PLANE_420_UNORM;
    G8_B8_R8_3PLANE_422_UNORM_KHR                  :: G8_B8_R8_3PLANE_422_UNORM;
    G8_B8R8_2PLANE_422_UNORM_KHR                   :: G8_B8R8_2PLANE_422_UNORM;
    G8_B8_R8_3PLANE_444_UNORM_KHR                  :: G8_B8_R8_3PLANE_444_UNORM;
    R10X6_UNORM_PACK16_KHR                         :: R10X6_UNORM_PACK16;
    R10X6G10X6_UNORM_2PACK16_KHR                   :: R10X6G10X6_UNORM_2PACK16;
    R10X6G10X6B10X6A10X6_UNORM_4PACK16_KHR         :: R10X6G10X6B10X6A10X6_UNORM_4PACK16;
    G10X6B10X6G10X6R10X6_422_UNORM_4PACK16_KHR     :: G10X6B10X6G10X6R10X6_422_UNORM_4PACK16;
    B10X6G10X6R10X6G10X6_422_UNORM_4PACK16_KHR     :: B10X6G10X6R10X6G10X6_422_UNORM_4PACK16;
    G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16_KHR :: G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16;
    G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16_KHR  :: G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16;
    G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16_KHR :: G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16;
    G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16_KHR  :: G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16;
    G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16_KHR :: G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16;
    R12X4_UNORM_PACK16_KHR                         :: R12X4_UNORM_PACK16;
    R12X4G12X4_UNORM_2PACK16_KHR                   :: R12X4G12X4_UNORM_2PACK16;
    R12X4G12X4B12X4A12X4_UNORM_4PACK16_KHR         :: R12X4G12X4B12X4A12X4_UNORM_4PACK16;
    G12X4B12X4G12X4R12X4_422_UNORM_4PACK16_KHR     :: G12X4B12X4G12X4R12X4_422_UNORM_4PACK16;
    B12X4G12X4R12X4G12X4_422_UNORM_4PACK16_KHR     :: B12X4G12X4R12X4G12X4_422_UNORM_4PACK16;
    G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16_KHR :: G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16;
    G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16_KHR  :: G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16;
    G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16_KHR :: G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16;
    G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16_KHR  :: G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16;
    G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16_KHR :: G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16;
    G16B16G16R16_422_UNORM_KHR                     :: G16B16G16R16_422_UNORM;
    B16G16R16G16_422_UNORM_KHR                     :: B16G16R16G16_422_UNORM;
    G16_B16_R16_3PLANE_420_UNORM_KHR               :: G16_B16_R16_3PLANE_420_UNORM;
    G16_B16R16_2PLANE_420_UNORM_KHR                :: G16_B16R16_2PLANE_420_UNORM;
    G16_B16_R16_3PLANE_422_UNORM_KHR               :: G16_B16_R16_3PLANE_422_UNORM;
    G16_B16R16_2PLANE_422_UNORM_KHR                :: G16_B16R16_2PLANE_422_UNORM;
    G16_B16_R16_3PLANE_444_UNORM_KHR               :: G16_B16_R16_3PLANE_444_UNORM;
    ASTC_3x3x3_UNORM_BLOCK_EXT                     :: 1000288000;
    ASTC_3x3x3_SRGB_BLOCK_EXT                      :: 1000288001;
    ASTC_3x3x3_SFLOAT_BLOCK_EXT                    :: 1000288002;
    ASTC_4x3x3_UNORM_BLOCK_EXT                     :: 1000288003;
    ASTC_4x3x3_SRGB_BLOCK_EXT                      :: 1000288004;
    ASTC_4x3x3_SFLOAT_BLOCK_EXT                    :: 1000288005;
    ASTC_4x4x3_UNORM_BLOCK_EXT                     :: 1000288006;
    ASTC_4x4x3_SRGB_BLOCK_EXT                      :: 1000288007;
    ASTC_4x4x3_SFLOAT_BLOCK_EXT                    :: 1000288008;
    ASTC_4x4x4_UNORM_BLOCK_EXT                     :: 1000288009;
    ASTC_4x4x4_SRGB_BLOCK_EXT                      :: 1000288010;
    ASTC_4x4x4_SFLOAT_BLOCK_EXT                    :: 1000288011;
    ASTC_5x4x4_UNORM_BLOCK_EXT                     :: 1000288012;
    ASTC_5x4x4_SRGB_BLOCK_EXT                      :: 1000288013;
    ASTC_5x4x4_SFLOAT_BLOCK_EXT                    :: 1000288014;
    ASTC_5x5x4_UNORM_BLOCK_EXT                     :: 1000288015;
    ASTC_5x5x4_SRGB_BLOCK_EXT                      :: 1000288016;
    ASTC_5x5x4_SFLOAT_BLOCK_EXT                    :: 1000288017;
    ASTC_5x5x5_UNORM_BLOCK_EXT                     :: 1000288018;
    ASTC_5x5x5_SRGB_BLOCK_EXT                      :: 1000288019;
    ASTC_5x5x5_SFLOAT_BLOCK_EXT                    :: 1000288020;
    ASTC_6x5x5_UNORM_BLOCK_EXT                     :: 1000288021;
    ASTC_6x5x5_SRGB_BLOCK_EXT                      :: 1000288022;
    ASTC_6x5x5_SFLOAT_BLOCK_EXT                    :: 1000288023;
    ASTC_6x6x5_UNORM_BLOCK_EXT                     :: 1000288024;
    ASTC_6x6x5_SRGB_BLOCK_EXT                      :: 1000288025;
    ASTC_6x6x5_SFLOAT_BLOCK_EXT                    :: 1000288026;
    ASTC_6x6x6_UNORM_BLOCK_EXT                     :: 1000288027;
    ASTC_6x6x6_SRGB_BLOCK_EXT                      :: 1000288028;
    ASTC_6x6x6_SFLOAT_BLOCK_EXT                    :: 1000288029;
    G8_B8R8_2PLANE_444_UNORM_EXT                   :: G8_B8R8_2PLANE_444_UNORM;
    G10X6_B10X6R10X6_2PLANE_444_UNORM_3PACK16_EXT  :: G10X6_B10X6R10X6_2PLANE_444_UNORM_3PACK16;
    G12X4_B12X4R12X4_2PLANE_444_UNORM_3PACK16_EXT  :: G12X4_B12X4R12X4_2PLANE_444_UNORM_3PACK16;
    G16_B16R16_2PLANE_444_UNORM_EXT                :: G16_B16R16_2PLANE_444_UNORM;
    A4R4G4B4_UNORM_PACK16_EXT                      :: A4R4G4B4_UNORM_PACK16;
    A4B4G4R4_UNORM_PACK16_EXT                      :: A4B4G4R4_UNORM_PACK16;
    R8_BOOL_ARM                                    :: 1000460000;
    R16_SFLOAT_FPENCODING_BFLOAT16_ARM             :: 1000460001;
    R8_SFLOAT_FPENCODING_FLOAT8E4M3_ARM            :: 1000460002;
    R8_SFLOAT_FPENCODING_FLOAT8E5M2_ARM            :: 1000460003;
    R16G16_SFIXED5_NV                              :: 1000464000;
    R16G16_S10_5_NV                                :: R16G16_SFIXED5_NV;
    A1B5G5R5_UNORM_PACK16_KHR                      :: A1B5G5R5_UNORM_PACK16;
    A8_UNORM_KHR                                   :: A8_UNORM;
    R10X6_UINT_PACK16_ARM                          :: 1000609000;
    R10X6G10X6_UINT_2PACK16_ARM                    :: 1000609001;
    R10X6G10X6B10X6A10X6_UINT_4PACK16_ARM          :: 1000609002;
    R12X4_UINT_PACK16_ARM                          :: 1000609003;
    R12X4G12X4_UINT_2PACK16_ARM                    :: 1000609004;
    R12X4G12X4B12X4A12X4_UINT_4PACK16_ARM          :: 1000609005;
    R14X2_UINT_PACK16_ARM                          :: 1000609006;
    R14X2G14X2_UINT_2PACK16_ARM                    :: 1000609007;
    R14X2G14X2B14X2A14X2_UINT_4PACK16_ARM          :: 1000609008;
    R14X2_UNORM_PACK16_ARM                         :: 1000609009;
    R14X2G14X2_UNORM_2PACK16_ARM                   :: 1000609010;
    R14X2G14X2B14X2A14X2_UNORM_4PACK16_ARM         :: 1000609011;
    G14X2_B14X2R14X2_2PLANE_420_UNORM_3PACK16_ARM  :: 1000609012;
    G14X2_B14X2R14X2_2PLANE_422_UNORM_3PACK16_ARM  :: 1000609013;
}

TextureViewDesc :: struct {
    texture: *Texture;
}

TextureView :: struct {
    using specific: TextureViewBackend;
    desc: TextureViewDesc; // immutable after creation
}

TextureUsageFlags :: enum u32 {
    COLOR_ATT :: 1 << 0;
    DEPTH_STENCIL_ATT :: 1 << 1;
    STORAGE :: 1 << 2;
    SAMPLED :: 1 << 3;
}

TextureDimension :: enum {
    D1;
    D2;
    D3;
}

TextureDesc :: struct {
    size: Extent3D;
    dimension: TextureDimension;
    format: TextureFormat;
    usage: TextureUsageFlags;
    mip_levels: u32 = 1;
    array_layers: u32 = 1;
}

TextureState :: enum {
    UNDEFINED;
    PRESENT;
    COLOR_RENDER_TARGET;
    DEPTH_STENCIL_WRITE;
    DEPTH_STENCIL_READ;
    SHADER_READ;
    SHADER_WRITE;
    COPY_SRC;
    COPY_DST;
}

TextureBarrierDesc :: struct {
    texture: *Texture;
    before: TextureState;
    after: TextureState;
    src_stage: PipelineStage = 0; // 0 = derive from before state
    dst_stage: PipelineStage = 0; // 0 = derive from after state
}

BufferBarrierDesc :: struct {
    buffer: *Buffer;
    before: TextureState;
    after: TextureState;
}

Texture :: struct {
    using specific: TextureBackend;
    desc: TextureDesc; // immutable after creation
    current_state: TextureState;
}

QueueFamily :: enum_flags u32 {
    GRAPHICS :: 0;
    COMPUTE :: 1;
}

PipelineStage :: enum_flags u32 {
    TOP_OF_PIPE;
    VERTEX_SHADER;
    FRAGMENT_SHADER;
    COMPUTE_SHADER;
    COLOR_ATTACHMENT_OUTPUT;
    TRANSFER;
    BOTTOM_OF_PIPE;
    ALL_COMMANDS;
}

SubmitWait :: struct {
    semaphore: *Semaphore;
    stage: PipelineStage;
}

Offset2D :: struct {
    x: s32;
    y: s32;
}

Extent3D :: struct {
    width: u32;
    height: u32;
    depth: u32;
}

Extent2D :: struct {
    width: u32;
    height: u32;
}

Rect2D :: struct {
    offset: Offset2D;
    extent: Extent2D;
}

LoadOp :: enum {
    LOAD;
    CLEAR;
    DONT_CARE;
}

StoreOp :: enum {
    STORE;
    DONT_CARE;
}

RenderPassDesc :: struct {
    AttachmentDesc :: struct {
        view: *TextureView;
        load_op: LoadOp = .CLEAR;
        store_op: StoreOp = .STORE;
        clear_color: Vector4;
    };

    max_color_attachments :: 8;
    color_attachment_count: u32;
    color_attachments: [max_color_attachments]AttachmentDesc;

    render_area: Rect2D;
}

QueueSubmitDesc :: struct {
    cmd_buffers: []*CommandBuffer;
    waits: []SubmitWait;
    signal_semaphores: []*Semaphore;
    fence: *Fence;
}

BindPool :: struct {
    using specific: BindPoolBackend;
}

GraphicsPipelineDesc :: struct {
    vertex_spirv: []u8;
    fragment_spirv: []u8;
    color_format: TextureFormat;
    depth_format: TextureFormat = .UNDEFINED;
}

Pipeline :: struct {
    using specific: PipelineBackend;
}

BindlessBindingUsage :: struct {
    used: bool;
    set_index: u32;
}

#import "Math";
