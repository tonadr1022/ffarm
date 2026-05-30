//
// This file was auto-generated using the following command:
//
// jai generate.jai
//



SPV_VERSION :: 0x10600;
SPV_REVISION :: 1;

SpvId :: u32;

SpvMagicNumber: u32 : 119734787;
SpvVersion: u32 : 67072;
SpvRevision: u32 : 1;
SpvOpCodeMask: u32 : 65535;
SpvWordCountShift: u32 : 16;

SpvSourceLanguage_ :: enum u32 {
    Unknown        :: 0;
    ESSL           :: 1;
    GLSL           :: 2;
    OpenCL_C       :: 3;
    OpenCL_CPP     :: 4;
    HLSL           :: 5;
    CPP_for_OpenCL :: 6;
    SYCL           :: 7;
    HERO_C         :: 8;
    NZSL           :: 9;
    WGSL           :: 10;
    Slang          :: 11;
    Zig            :: 12;
    Rust           :: 13;
    Max            :: 2147483647;
}

SpvSourceLanguage :: SpvSourceLanguage_;

SpvExecutionModel_ :: enum u32 {
    Vertex                 :: 0;
    TessellationControl    :: 1;
    TessellationEvaluation :: 2;
    Geometry               :: 3;
    Fragment               :: 4;
    GLCompute              :: 5;
    Kernel                 :: 6;
    TaskNV                 :: 5267;
    MeshNV                 :: 5268;
    RayGenerationKHR       :: 5313;
    RayGenerationNV        :: 5313;
    IntersectionKHR        :: 5314;
    IntersectionNV         :: 5314;
    AnyHitKHR              :: 5315;
    AnyHitNV               :: 5315;
    ClosestHitKHR          :: 5316;
    ClosestHitNV           :: 5316;
    MissKHR                :: 5317;
    MissNV                 :: 5317;
    CallableKHR            :: 5318;
    CallableNV             :: 5318;
    TaskEXT                :: 5364;
    MeshEXT                :: 5365;
    Max                    :: 2147483647;
}

SpvExecutionModel :: SpvExecutionModel_;

SpvAddressingModel_ :: enum u32 {
    Logical                    :: 0;
    Physical32                 :: 1;
    Physical64                 :: 2;
    PhysicalStorageBuffer64    :: 5348;
    PhysicalStorageBuffer64EXT :: 5348;
    Max                        :: 2147483647;
}

SpvAddressingModel :: SpvAddressingModel_;

SpvMemoryModel_ :: enum u32 {
    Simple    :: 0;
    GLSL450   :: 1;
    OpenCL    :: 2;
    Vulkan    :: 3;
    VulkanKHR :: 3;
    Max       :: 2147483647;
}

SpvMemoryModel :: SpvMemoryModel_;

SpvExecutionMode_ :: enum u32 {
    Invocations                         :: 0;
    SpacingEqual                        :: 1;
    SpacingFractionalEven               :: 2;
    SpacingFractionalOdd                :: 3;
    VertexOrderCw                       :: 4;
    VertexOrderCcw                      :: 5;
    PixelCenterInteger                  :: 6;
    OriginUpperLeft                     :: 7;
    OriginLowerLeft                     :: 8;
    EarlyFragmentTests                  :: 9;
    PointMode                           :: 10;
    Xfb                                 :: 11;
    DepthReplacing                      :: 12;
    DepthGreater                        :: 14;
    DepthLess                           :: 15;
    DepthUnchanged                      :: 16;
    LocalSize                           :: 17;
    LocalSizeHint                       :: 18;
    InputPoints                         :: 19;
    InputLines                          :: 20;
    InputLinesAdjacency                 :: 21;
    Triangles                           :: 22;
    InputTrianglesAdjacency             :: 23;
    Quads                               :: 24;
    Isolines                            :: 25;
    OutputVertices                      :: 26;
    OutputPoints                        :: 27;
    OutputLineStrip                     :: 28;
    OutputTriangleStrip                 :: 29;
    VecTypeHint                         :: 30;
    ContractionOff                      :: 31;
    Initializer                         :: 33;
    Finalizer                           :: 34;
    SubgroupSize                        :: 35;
    SubgroupsPerWorkgroup               :: 36;
    SubgroupsPerWorkgroupId             :: 37;
    LocalSizeId                         :: 38;
    LocalSizeHintId                     :: 39;
    NonCoherentColorAttachmentReadEXT   :: 4169;
    NonCoherentDepthAttachmentReadEXT   :: 4170;
    NonCoherentStencilAttachmentReadEXT :: 4171;
    SubgroupUniformControlFlowKHR       :: 4421;
    PostDepthCoverage                   :: 4446;
    DenormPreserve                      :: 4459;
    DenormFlushToZero                   :: 4460;
    SignedZeroInfNanPreserve            :: 4461;
    RoundingModeRTE                     :: 4462;
    RoundingModeRTZ                     :: 4463;
    NonCoherentTileAttachmentReadQCOM   :: 4489;
    TileShadingRateQCOM                 :: 4490;
    EarlyAndLateFragmentTestsAMD        :: 5017;
    StencilRefReplacingEXT              :: 5027;
    CoalescingAMDX                      :: 5069;
    IsApiEntryAMDX                      :: 5070;
    MaxNodeRecursionAMDX                :: 5071;
    StaticNumWorkgroupsAMDX             :: 5072;
    ShaderIndexAMDX                     :: 5073;
    MaxNumWorkgroupsAMDX                :: 5077;
    StencilRefUnchangedFrontAMD         :: 5079;
    StencilRefGreaterFrontAMD           :: 5080;
    StencilRefLessFrontAMD              :: 5081;
    StencilRefUnchangedBackAMD          :: 5082;
    StencilRefGreaterBackAMD            :: 5083;
    StencilRefLessBackAMD               :: 5084;
    QuadDerivativesKHR                  :: 5088;
    RequireFullQuadsKHR                 :: 5089;
    SharesInputWithAMDX                 :: 5102;
    OutputLinesEXT                      :: 5269;
    OutputLinesNV                       :: 5269;
    OutputPrimitivesEXT                 :: 5270;
    OutputPrimitivesNV                  :: 5270;
    DerivativeGroupQuadsKHR             :: 5289;
    DerivativeGroupQuadsNV              :: 5289;
    DerivativeGroupLinearKHR            :: 5290;
    DerivativeGroupLinearNV             :: 5290;
    OutputTrianglesEXT                  :: 5298;
    OutputTrianglesNV                   :: 5298;
    PixelInterlockOrderedEXT            :: 5366;
    PixelInterlockUnorderedEXT          :: 5367;
    SampleInterlockOrderedEXT           :: 5368;
    SampleInterlockUnorderedEXT         :: 5369;
    ShadingRateInterlockOrderedEXT      :: 5370;
    ShadingRateInterlockUnorderedEXT    :: 5371;
    SharedLocalMemorySizeINTEL          :: 5618;
    RoundingModeRTPINTEL                :: 5620;
    RoundingModeRTNINTEL                :: 5621;
    FloatingPointModeALTINTEL           :: 5622;
    FloatingPointModeIEEEINTEL          :: 5623;
    MaxWorkgroupSizeINTEL               :: 5893;
    MaxWorkDimINTEL                     :: 5894;
    NoGlobalOffsetINTEL                 :: 5895;
    NumSIMDWorkitemsINTEL               :: 5896;
    SchedulerTargetFmaxMhzINTEL         :: 5903;
    MaximallyReconvergesKHR             :: 6023;
    FPFastMathDefault                   :: 6028;
    StreamingInterfaceINTEL             :: 6154;
    RegisterMapInterfaceINTEL           :: 6160;
    NamedBarrierCountINTEL              :: 6417;
    MaximumRegistersINTEL               :: 6461;
    MaximumRegistersIdINTEL             :: 6462;
    NamedMaximumRegistersINTEL          :: 6463;
    Max                                 :: 2147483647;
}

SpvExecutionMode :: SpvExecutionMode_;

SpvStorageClass_ :: enum u32 {
    UniformConstant          :: 0;
    Input                    :: 1;
    Uniform                  :: 2;
    Output                   :: 3;
    Workgroup                :: 4;
    CrossWorkgroup           :: 5;
    Private                  :: 6;
    Function                 :: 7;
    Generic                  :: 8;
    PushConstant             :: 9;
    AtomicCounter            :: 10;
    Image                    :: 11;
    StorageBuffer            :: 12;
    TileImageEXT             :: 4172;
    TileAttachmentQCOM       :: 4491;
    NodePayloadAMDX          :: 5068;
    CallableDataKHR          :: 5328;
    CallableDataNV           :: 5328;
    IncomingCallableDataKHR  :: 5329;
    IncomingCallableDataNV   :: 5329;
    RayPayloadKHR            :: 5338;
    RayPayloadNV             :: 5338;
    HitAttributeKHR          :: 5339;
    HitAttributeNV           :: 5339;
    IncomingRayPayloadKHR    :: 5342;
    IncomingRayPayloadNV     :: 5342;
    ShaderRecordBufferKHR    :: 5343;
    ShaderRecordBufferNV     :: 5343;
    PhysicalStorageBuffer    :: 5349;
    PhysicalStorageBufferEXT :: 5349;
    HitObjectAttributeNV     :: 5385;
    TaskPayloadWorkgroupEXT  :: 5402;
    CodeSectionINTEL         :: 5605;
    DeviceOnlyINTEL          :: 5936;
    HostOnlyINTEL            :: 5937;
    Max                      :: 2147483647;
}

SpvStorageClass :: SpvStorageClass_;

SpvDim_ :: enum u32 {
    _1D              :: 0;
    _2D              :: 1;
    _3D              :: 2;
    Cube             :: 3;
    Rect             :: 4;
    Buffer           :: 5;
    SubpassData      :: 6;
    TileImageDataEXT :: 4173;
    Max              :: 2147483647;
}

SpvDim :: SpvDim_;

SpvSamplerAddressingMode_ :: enum u32 {
    None           :: 0;
    ClampToEdge    :: 1;
    Clamp          :: 2;
    Repeat         :: 3;
    RepeatMirrored :: 4;
    Max            :: 2147483647;
}

SpvSamplerAddressingMode :: SpvSamplerAddressingMode_;

SpvSamplerFilterMode_ :: enum u32 {
    Nearest :: 0;
    Linear  :: 1;
    Max     :: 2147483647;
}

SpvSamplerFilterMode :: SpvSamplerFilterMode_;

SpvImageFormat_ :: enum u32 {
    Unknown      :: 0;
    Rgba32f      :: 1;
    Rgba16f      :: 2;
    R32f         :: 3;
    Rgba8        :: 4;
    Rgba8Snorm   :: 5;
    Rg32f        :: 6;
    Rg16f        :: 7;
    R11fG11fB10f :: 8;
    R16f         :: 9;
    Rgba16       :: 10;
    Rgb10A2      :: 11;
    Rg16         :: 12;
    Rg8          :: 13;
    R16          :: 14;
    R8           :: 15;
    Rgba16Snorm  :: 16;
    Rg16Snorm    :: 17;
    Rg8Snorm     :: 18;
    R16Snorm     :: 19;
    R8Snorm      :: 20;
    Rgba32i      :: 21;
    Rgba16i      :: 22;
    Rgba8i       :: 23;
    R32i         :: 24;
    Rg32i        :: 25;
    Rg16i        :: 26;
    Rg8i         :: 27;
    R16i         :: 28;
    R8i          :: 29;
    Rgba32ui     :: 30;
    Rgba16ui     :: 31;
    Rgba8ui      :: 32;
    R32ui        :: 33;
    Rgb10a2ui    :: 34;
    Rg32ui       :: 35;
    Rg16ui       :: 36;
    Rg8ui        :: 37;
    R16ui        :: 38;
    R8ui         :: 39;
    R64ui        :: 40;
    R64i         :: 41;
    Max          :: 2147483647;
}

SpvImageFormat :: SpvImageFormat_;

SpvImageChannelOrder_ :: enum u32 {
    R            :: 0;
    A            :: 1;
    RG           :: 2;
    RA           :: 3;
    RGB          :: 4;
    RGBA         :: 5;
    BGRA         :: 6;
    ARGB         :: 7;
    Intensity    :: 8;
    Luminance    :: 9;
    Rx           :: 10;
    RGx          :: 11;
    RGBx         :: 12;
    Depth        :: 13;
    DepthStencil :: 14;
    sRGB         :: 15;
    sRGBx        :: 16;
    sRGBA        :: 17;
    sBGRA        :: 18;
    ABGR         :: 19;
    Max          :: 2147483647;
}

SpvImageChannelOrder :: SpvImageChannelOrder_;

SpvImageChannelDataType_ :: enum u32 {
    SnormInt8           :: 0;
    SnormInt16          :: 1;
    UnormInt8           :: 2;
    UnormInt16          :: 3;
    UnormShort565       :: 4;
    UnormShort555       :: 5;
    UnormInt101010      :: 6;
    SignedInt8          :: 7;
    SignedInt16         :: 8;
    SignedInt32         :: 9;
    UnsignedInt8        :: 10;
    UnsignedInt16       :: 11;
    UnsignedInt32       :: 12;
    HalfFloat           :: 13;
    Float               :: 14;
    UnormInt24          :: 15;
    UnormInt101010_2    :: 16;
    UnormInt10X6EXT     :: 17;
    UnsignedIntRaw10EXT :: 19;
    UnsignedIntRaw12EXT :: 20;
    UnormInt2_101010EXT :: 21;
    UnsignedInt10X6EXT  :: 22;
    UnsignedInt12X4EXT  :: 23;
    UnsignedInt14X2EXT  :: 24;
    UnormInt12X4EXT     :: 25;
    UnormInt14X2EXT     :: 26;
    Max                 :: 2147483647;
}

SpvImageChannelDataType :: SpvImageChannelDataType_;

SpvImageOperandsShift_ :: enum u32 {
    BiasShift                  :: 0;
    LodShift                   :: 1;
    GradShift                  :: 2;
    ConstOffsetShift           :: 3;
    OffsetShift                :: 4;
    ConstOffsetsShift          :: 5;
    SampleShift                :: 6;
    MinLodShift                :: 7;
    MakeTexelAvailableShift    :: 8;
    MakeTexelAvailableKHRShift :: 8;
    MakeTexelVisibleShift      :: 9;
    MakeTexelVisibleKHRShift   :: 9;
    NonPrivateTexelShift       :: 10;
    NonPrivateTexelKHRShift    :: 10;
    VolatileTexelShift         :: 11;
    VolatileTexelKHRShift      :: 11;
    SignExtendShift            :: 12;
    ZeroExtendShift            :: 13;
    NontemporalShift           :: 14;
    OffsetsShift               :: 16;
    Max                        :: 2147483647;
}

SpvImageOperandsShift :: SpvImageOperandsShift_;

SpvImageOperandsMask_ :: enum u32 {
    MaskNone                  :: 0;
    BiasMask                  :: 1;
    LodMask                   :: 2;
    GradMask                  :: 4;
    ConstOffsetMask           :: 8;
    OffsetMask                :: 16;
    ConstOffsetsMask          :: 32;
    SampleMask                :: 64;
    MinLodMask                :: 128;
    MakeTexelAvailableMask    :: 256;
    MakeTexelAvailableKHRMask :: 256;
    MakeTexelVisibleMask      :: 512;
    MakeTexelVisibleKHRMask   :: 512;
    NonPrivateTexelMask       :: 1024;
    NonPrivateTexelKHRMask    :: 1024;
    VolatileTexelMask         :: 2048;
    VolatileTexelKHRMask      :: 2048;
    SignExtendMask            :: 4096;
    ZeroExtendMask            :: 8192;
    NontemporalMask           :: 16384;
    OffsetsMask               :: 65536;
}

SpvImageOperandsMask :: SpvImageOperandsMask_;

SpvFPFastMathModeShift_ :: enum u32 {
    NotNaNShift                 :: 0;
    NotInfShift                 :: 1;
    NSZShift                    :: 2;
    AllowRecipShift             :: 3;
    FastShift                   :: 4;
    AllowContractShift          :: 16;
    AllowContractFastINTELShift :: 16;
    AllowReassocShift           :: 17;
    AllowReassocINTELShift      :: 17;
    AllowTransformShift         :: 18;
    Max                         :: 2147483647;
}

SpvFPFastMathModeShift :: SpvFPFastMathModeShift_;

SpvFPFastMathModeMask_ :: enum u32 {
    MaskNone                   :: 0;
    NotNaNMask                 :: 1;
    NotInfMask                 :: 2;
    NSZMask                    :: 4;
    AllowRecipMask             :: 8;
    FastMask                   :: 16;
    AllowContractMask          :: 65536;
    AllowContractFastINTELMask :: 65536;
    AllowReassocMask           :: 131072;
    AllowReassocINTELMask      :: 131072;
    AllowTransformMask         :: 262144;
}

SpvFPFastMathModeMask :: SpvFPFastMathModeMask_;

SpvFPRoundingMode_ :: enum u32 {
    RTE :: 0;
    RTZ :: 1;
    RTP :: 2;
    RTN :: 3;
    Max :: 2147483647;
}

SpvFPRoundingMode :: SpvFPRoundingMode_;

SpvLinkageType_ :: enum u32 {
    Export      :: 0;
    Import      :: 1;
    LinkOnceODR :: 2;
    Max         :: 2147483647;
}

SpvLinkageType :: SpvLinkageType_;

SpvAccessQualifier_ :: enum u32 {
    ReadOnly  :: 0;
    WriteOnly :: 1;
    ReadWrite :: 2;
    Max       :: 2147483647;
}

SpvAccessQualifier :: SpvAccessQualifier_;

SpvFunctionParameterAttribute_ :: enum u32 {
    Zext                :: 0;
    Sext                :: 1;
    ByVal               :: 2;
    Sret                :: 3;
    NoAlias             :: 4;
    NoCapture           :: 5;
    NoWrite             :: 6;
    NoReadWrite         :: 7;
    RuntimeAlignedINTEL :: 5940;
    Max                 :: 2147483647;
}

SpvFunctionParameterAttribute :: SpvFunctionParameterAttribute_;

SpvDecoration_ :: enum u32 {
    RelaxedPrecision                            :: 0;
    SpecId                                      :: 1;
    Block                                       :: 2;
    BufferBlock                                 :: 3;
    RowMajor                                    :: 4;
    ColMajor                                    :: 5;
    ArrayStride                                 :: 6;
    MatrixStride                                :: 7;
    GLSLShared                                  :: 8;
    GLSLPacked                                  :: 9;
    CPacked                                     :: 10;
    BuiltIn                                     :: 11;
    NoPerspective                               :: 13;
    Flat                                        :: 14;
    Patch                                       :: 15;
    Centroid                                    :: 16;
    Sample                                      :: 17;
    Invariant                                   :: 18;
    Restrict                                    :: 19;
    Aliased                                     :: 20;
    Volatile                                    :: 21;
    Constant                                    :: 22;
    Coherent                                    :: 23;
    NonWritable                                 :: 24;
    NonReadable                                 :: 25;
    Uniform                                     :: 26;
    UniformId                                   :: 27;
    SaturatedConversion                         :: 28;
    Stream                                      :: 29;
    Location                                    :: 30;
    Component                                   :: 31;
    Index                                       :: 32;
    Binding                                     :: 33;
    DescriptorSet                               :: 34;
    Offset                                      :: 35;
    XfbBuffer                                   :: 36;
    XfbStride                                   :: 37;
    FuncParamAttr                               :: 38;
    FPRoundingMode                              :: 39;
    FPFastMathMode                              :: 40;
    LinkageAttributes                           :: 41;
    NoContraction                               :: 42;
    InputAttachmentIndex                        :: 43;
    Alignment                                   :: 44;
    MaxByteOffset                               :: 45;
    AlignmentId                                 :: 46;
    MaxByteOffsetId                             :: 47;
    SaturatedToLargestFloat8NormalConversionEXT :: 4216;
    NoSignedWrap                                :: 4469;
    NoUnsignedWrap                              :: 4470;
    WeightTextureQCOM                           :: 4487;
    BlockMatchTextureQCOM                       :: 4488;
    BlockMatchSamplerQCOM                       :: 4499;
    ExplicitInterpAMD                           :: 4999;
    NodeSharesPayloadLimitsWithAMDX             :: 5019;
    NodeMaxPayloadsAMDX                         :: 5020;
    TrackFinishWritingAMDX                      :: 5078;
    PayloadNodeNameAMDX                         :: 5091;
    PayloadNodeBaseIndexAMDX                    :: 5098;
    PayloadNodeSparseArrayAMDX                  :: 5099;
    PayloadNodeArraySizeAMDX                    :: 5100;
    PayloadDispatchIndirectAMDX                 :: 5105;
    OverrideCoverageNV                          :: 5248;
    PassthroughNV                               :: 5250;
    ViewportRelativeNV                          :: 5252;
    SecondaryViewportRelativeNV                 :: 5256;
    PerPrimitiveEXT                             :: 5271;
    PerPrimitiveNV                              :: 5271;
    PerViewNV                                   :: 5272;
    PerTaskNV                                   :: 5273;
    PerVertexKHR                                :: 5285;
    PerVertexNV                                 :: 5285;
    NonUniform                                  :: 5300;
    NonUniformEXT                               :: 5300;
    RestrictPointer                             :: 5355;
    RestrictPointerEXT                          :: 5355;
    AliasedPointer                              :: 5356;
    AliasedPointerEXT                           :: 5356;
    HitObjectShaderRecordBufferNV               :: 5386;
    BindlessSamplerNV                           :: 5398;
    BindlessImageNV                             :: 5399;
    BoundSamplerNV                              :: 5400;
    BoundImageNV                                :: 5401;
    SIMTCallINTEL                               :: 5599;
    ReferencedIndirectlyINTEL                   :: 5602;
    ClobberINTEL                                :: 5607;
    SideEffectsINTEL                            :: 5608;
    VectorComputeVariableINTEL                  :: 5624;
    FuncParamIOKindINTEL                        :: 5625;
    VectorComputeFunctionINTEL                  :: 5626;
    StackCallINTEL                              :: 5627;
    GlobalVariableOffsetINTEL                   :: 5628;
    CounterBuffer                               :: 5634;
    HlslCounterBufferGOOGLE                     :: 5634;
    HlslSemanticGOOGLE                          :: 5635;
    UserSemantic                                :: 5635;
    UserTypeGOOGLE                              :: 5636;
    FunctionRoundingModeINTEL                   :: 5822;
    FunctionDenormModeINTEL                     :: 5823;
    RegisterINTEL                               :: 5825;
    MemoryINTEL                                 :: 5826;
    NumbanksINTEL                               :: 5827;
    BankwidthINTEL                              :: 5828;
    MaxPrivateCopiesINTEL                       :: 5829;
    SinglepumpINTEL                             :: 5830;
    DoublepumpINTEL                             :: 5831;
    MaxReplicatesINTEL                          :: 5832;
    SimpleDualPortINTEL                         :: 5833;
    MergeINTEL                                  :: 5834;
    BankBitsINTEL                               :: 5835;
    ForcePow2DepthINTEL                         :: 5836;
    StridesizeINTEL                             :: 5883;
    WordsizeINTEL                               :: 5884;
    TrueDualPortINTEL                           :: 5885;
    BurstCoalesceINTEL                          :: 5899;
    CacheSizeINTEL                              :: 5900;
    DontStaticallyCoalesceINTEL                 :: 5901;
    PrefetchINTEL                               :: 5902;
    StallEnableINTEL                            :: 5905;
    FuseLoopsInFunctionINTEL                    :: 5907;
    MathOpDSPModeINTEL                          :: 5909;
    AliasScopeINTEL                             :: 5914;
    NoAliasINTEL                                :: 5915;
    InitiationIntervalINTEL                     :: 5917;
    MaxConcurrencyINTEL                         :: 5918;
    PipelineEnableINTEL                         :: 5919;
    BufferLocationINTEL                         :: 5921;
    IOPipeStorageINTEL                          :: 5944;
    FunctionFloatingPointModeINTEL              :: 6080;
    SingleElementVectorINTEL                    :: 6085;
    VectorComputeCallableFunctionINTEL          :: 6087;
    MediaBlockIOINTEL                           :: 6140;
    StallFreeINTEL                              :: 6151;
    FPMaxErrorDecorationINTEL                   :: 6170;
    LatencyControlLabelINTEL                    :: 6172;
    LatencyControlConstraintINTEL               :: 6173;
    ConduitKernelArgumentINTEL                  :: 6175;
    RegisterMapKernelArgumentINTEL              :: 6176;
    MMHostInterfaceAddressWidthINTEL            :: 6177;
    MMHostInterfaceDataWidthINTEL               :: 6178;
    MMHostInterfaceLatencyINTEL                 :: 6179;
    MMHostInterfaceReadWriteModeINTEL           :: 6180;
    MMHostInterfaceMaxBurstINTEL                :: 6181;
    MMHostInterfaceWaitRequestINTEL             :: 6182;
    StableKernelArgumentINTEL                   :: 6183;
    HostAccessINTEL                             :: 6188;
    InitModeINTEL                               :: 6190;
    ImplementInRegisterMapINTEL                 :: 6191;
    ConditionalINTEL                            :: 6247;
    CacheControlLoadINTEL                       :: 6442;
    CacheControlStoreINTEL                      :: 6443;
    Max                                         :: 2147483647;
}

SpvDecoration :: SpvDecoration_;

SpvBuiltIn_ :: enum u32 {
    Position                             :: 0;
    PointSize                            :: 1;
    ClipDistance                         :: 3;
    CullDistance                         :: 4;
    VertexId                             :: 5;
    InstanceId                           :: 6;
    PrimitiveId                          :: 7;
    InvocationId                         :: 8;
    Layer                                :: 9;
    ViewportIndex                        :: 10;
    TessLevelOuter                       :: 11;
    TessLevelInner                       :: 12;
    TessCoord                            :: 13;
    PatchVertices                        :: 14;
    FragCoord                            :: 15;
    PointCoord                           :: 16;
    FrontFacing                          :: 17;
    SampleId                             :: 18;
    SamplePosition                       :: 19;
    SampleMask                           :: 20;
    FragDepth                            :: 22;
    HelperInvocation                     :: 23;
    NumWorkgroups                        :: 24;
    WorkgroupSize                        :: 25;
    WorkgroupId                          :: 26;
    LocalInvocationId                    :: 27;
    GlobalInvocationId                   :: 28;
    LocalInvocationIndex                 :: 29;
    WorkDim                              :: 30;
    GlobalSize                           :: 31;
    EnqueuedWorkgroupSize                :: 32;
    GlobalOffset                         :: 33;
    GlobalLinearId                       :: 34;
    SubgroupSize                         :: 36;
    SubgroupMaxSize                      :: 37;
    NumSubgroups                         :: 38;
    NumEnqueuedSubgroups                 :: 39;
    SubgroupId                           :: 40;
    SubgroupLocalInvocationId            :: 41;
    VertexIndex                          :: 42;
    InstanceIndex                        :: 43;
    CoreIDARM                            :: 4160;
    CoreCountARM                         :: 4161;
    CoreMaxIDARM                         :: 4162;
    WarpIDARM                            :: 4163;
    WarpMaxIDARM                         :: 4164;
    SubgroupEqMask                       :: 4416;
    SubgroupEqMaskKHR                    :: 4416;
    SubgroupGeMask                       :: 4417;
    SubgroupGeMaskKHR                    :: 4417;
    SubgroupGtMask                       :: 4418;
    SubgroupGtMaskKHR                    :: 4418;
    SubgroupLeMask                       :: 4419;
    SubgroupLeMaskKHR                    :: 4419;
    SubgroupLtMask                       :: 4420;
    SubgroupLtMaskKHR                    :: 4420;
    BaseVertex                           :: 4424;
    BaseInstance                         :: 4425;
    DrawIndex                            :: 4426;
    PrimitiveShadingRateKHR              :: 4432;
    DeviceIndex                          :: 4438;
    ViewIndex                            :: 4440;
    ShadingRateKHR                       :: 4444;
    TileOffsetQCOM                       :: 4492;
    TileDimensionQCOM                    :: 4493;
    TileApronSizeQCOM                    :: 4494;
    BaryCoordNoPerspAMD                  :: 4992;
    BaryCoordNoPerspCentroidAMD          :: 4993;
    BaryCoordNoPerspSampleAMD            :: 4994;
    BaryCoordSmoothAMD                   :: 4995;
    BaryCoordSmoothCentroidAMD           :: 4996;
    BaryCoordSmoothSampleAMD             :: 4997;
    BaryCoordPullModelAMD                :: 4998;
    FragStencilRefEXT                    :: 5014;
    RemainingRecursionLevelsAMDX         :: 5021;
    ShaderIndexAMDX                      :: 5073;
    ViewportMaskNV                       :: 5253;
    SecondaryPositionNV                  :: 5257;
    SecondaryViewportMaskNV              :: 5258;
    PositionPerViewNV                    :: 5261;
    ViewportMaskPerViewNV                :: 5262;
    FullyCoveredEXT                      :: 5264;
    TaskCountNV                          :: 5274;
    PrimitiveCountNV                     :: 5275;
    PrimitiveIndicesNV                   :: 5276;
    ClipDistancePerViewNV                :: 5277;
    CullDistancePerViewNV                :: 5278;
    LayerPerViewNV                       :: 5279;
    MeshViewCountNV                      :: 5280;
    MeshViewIndicesNV                    :: 5281;
    BaryCoordKHR                         :: 5286;
    BaryCoordNV                          :: 5286;
    BaryCoordNoPerspKHR                  :: 5287;
    BaryCoordNoPerspNV                   :: 5287;
    FragSizeEXT                          :: 5292;
    FragmentSizeNV                       :: 5292;
    FragInvocationCountEXT               :: 5293;
    InvocationsPerPixelNV                :: 5293;
    PrimitivePointIndicesEXT             :: 5294;
    PrimitiveLineIndicesEXT              :: 5295;
    PrimitiveTriangleIndicesEXT          :: 5296;
    CullPrimitiveEXT                     :: 5299;
    LaunchIdKHR                          :: 5319;
    LaunchIdNV                           :: 5319;
    LaunchSizeKHR                        :: 5320;
    LaunchSizeNV                         :: 5320;
    WorldRayOriginKHR                    :: 5321;
    WorldRayOriginNV                     :: 5321;
    WorldRayDirectionKHR                 :: 5322;
    WorldRayDirectionNV                  :: 5322;
    ObjectRayOriginKHR                   :: 5323;
    ObjectRayOriginNV                    :: 5323;
    ObjectRayDirectionKHR                :: 5324;
    ObjectRayDirectionNV                 :: 5324;
    RayTminKHR                           :: 5325;
    RayTminNV                            :: 5325;
    RayTmaxKHR                           :: 5326;
    RayTmaxNV                            :: 5326;
    InstanceCustomIndexKHR               :: 5327;
    InstanceCustomIndexNV                :: 5327;
    ObjectToWorldKHR                     :: 5330;
    ObjectToWorldNV                      :: 5330;
    WorldToObjectKHR                     :: 5331;
    WorldToObjectNV                      :: 5331;
    HitTNV                               :: 5332;
    HitKindKHR                           :: 5333;
    HitKindNV                            :: 5333;
    CurrentRayTimeNV                     :: 5334;
    HitTriangleVertexPositionsKHR        :: 5335;
    HitMicroTriangleVertexPositionsNV    :: 5337;
    HitMicroTriangleVertexBarycentricsNV :: 5344;
    IncomingRayFlagsKHR                  :: 5351;
    IncomingRayFlagsNV                   :: 5351;
    RayGeometryIndexKHR                  :: 5352;
    HitIsSphereNV                        :: 5359;
    HitIsLSSNV                           :: 5360;
    HitSpherePositionNV                  :: 5361;
    WarpsPerSMNV                         :: 5374;
    SMCountNV                            :: 5375;
    WarpIDNV                             :: 5376;
    SMIDNV                               :: 5377;
    HitLSSPositionsNV                    :: 5396;
    HitKindFrontFacingMicroTriangleNV    :: 5405;
    HitKindBackFacingMicroTriangleNV     :: 5406;
    HitSphereRadiusNV                    :: 5420;
    HitLSSRadiiNV                        :: 5421;
    ClusterIDNV                          :: 5436;
    CullMaskKHR                          :: 6021;
    Max                                  :: 2147483647;
}

SpvBuiltIn :: SpvBuiltIn_;

SpvSelectionControlShift_ :: enum u32 {
    FlattenShift     :: 0;
    DontFlattenShift :: 1;
    Max              :: 2147483647;
}

SpvSelectionControlShift :: SpvSelectionControlShift_;

SpvSelectionControlMask_ :: enum u32 {
    MaskNone        :: 0;
    FlattenMask     :: 1;
    DontFlattenMask :: 2;
}

SpvSelectionControlMask :: SpvSelectionControlMask_;

SpvLoopControlShift_ :: enum u32 {
    UnrollShift                    :: 0;
    DontUnrollShift                :: 1;
    DependencyInfiniteShift        :: 2;
    DependencyLengthShift          :: 3;
    MinIterationsShift             :: 4;
    MaxIterationsShift             :: 5;
    IterationMultipleShift         :: 6;
    PeelCountShift                 :: 7;
    PartialCountShift              :: 8;
    InitiationIntervalINTELShift   :: 16;
    MaxConcurrencyINTELShift       :: 17;
    DependencyArrayINTELShift      :: 18;
    PipelineEnableINTELShift       :: 19;
    LoopCoalesceINTELShift         :: 20;
    MaxInterleavingINTELShift      :: 21;
    SpeculatedIterationsINTELShift :: 22;
    NoFusionINTELShift             :: 23;
    LoopCountINTELShift            :: 24;
    MaxReinvocationDelayINTELShift :: 25;
    Max                            :: 2147483647;
}

SpvLoopControlShift :: SpvLoopControlShift_;

SpvLoopControlMask_ :: enum u32 {
    MaskNone                      :: 0;
    UnrollMask                    :: 1;
    DontUnrollMask                :: 2;
    DependencyInfiniteMask        :: 4;
    DependencyLengthMask          :: 8;
    MinIterationsMask             :: 16;
    MaxIterationsMask             :: 32;
    IterationMultipleMask         :: 64;
    PeelCountMask                 :: 128;
    PartialCountMask              :: 256;
    InitiationIntervalINTELMask   :: 65536;
    MaxConcurrencyINTELMask       :: 131072;
    DependencyArrayINTELMask      :: 262144;
    PipelineEnableINTELMask       :: 524288;
    LoopCoalesceINTELMask         :: 1048576;
    MaxInterleavingINTELMask      :: 2097152;
    SpeculatedIterationsINTELMask :: 4194304;
    NoFusionINTELMask             :: 8388608;
    LoopCountINTELMask            :: 16777216;
    MaxReinvocationDelayINTELMask :: 33554432;
}

SpvLoopControlMask :: SpvLoopControlMask_;

SpvFunctionControlShift_ :: enum u32 {
    InlineShift       :: 0;
    DontInlineShift   :: 1;
    PureShift         :: 2;
    ConstShift        :: 3;
    OptNoneEXTShift   :: 16;
    OptNoneINTELShift :: 16;
    Max               :: 2147483647;
}

SpvFunctionControlShift :: SpvFunctionControlShift_;

SpvFunctionControlMask_ :: enum u32 {
    MaskNone         :: 0;
    InlineMask       :: 1;
    DontInlineMask   :: 2;
    PureMask         :: 4;
    ConstMask        :: 8;
    OptNoneEXTMask   :: 65536;
    OptNoneINTELMask :: 65536;
}

SpvFunctionControlMask :: SpvFunctionControlMask_;

SpvMemorySemanticsShift_ :: enum u32 {
    AcquireShift                :: 1;
    ReleaseShift                :: 2;
    AcquireReleaseShift         :: 3;
    SequentiallyConsistentShift :: 4;
    UniformMemoryShift          :: 6;
    SubgroupMemoryShift         :: 7;
    WorkgroupMemoryShift        :: 8;
    CrossWorkgroupMemoryShift   :: 9;
    AtomicCounterMemoryShift    :: 10;
    ImageMemoryShift            :: 11;
    OutputMemoryShift           :: 12;
    OutputMemoryKHRShift        :: 12;
    MakeAvailableShift          :: 13;
    MakeAvailableKHRShift       :: 13;
    MakeVisibleShift            :: 14;
    MakeVisibleKHRShift         :: 14;
    VolatileShift               :: 15;
    Max                         :: 2147483647;
}

SpvMemorySemanticsShift :: SpvMemorySemanticsShift_;

SpvMemorySemanticsMask_ :: enum u32 {
    MaskNone                   :: 0;
    AcquireMask                :: 2;
    ReleaseMask                :: 4;
    AcquireReleaseMask         :: 8;
    SequentiallyConsistentMask :: 16;
    UniformMemoryMask          :: 64;
    SubgroupMemoryMask         :: 128;
    WorkgroupMemoryMask        :: 256;
    CrossWorkgroupMemoryMask   :: 512;
    AtomicCounterMemoryMask    :: 1024;
    ImageMemoryMask            :: 2048;
    OutputMemoryMask           :: 4096;
    OutputMemoryKHRMask        :: 4096;
    MakeAvailableMask          :: 8192;
    MakeAvailableKHRMask       :: 8192;
    MakeVisibleMask            :: 16384;
    MakeVisibleKHRMask         :: 16384;
    VolatileMask               :: 32768;
}

SpvMemorySemanticsMask :: SpvMemorySemanticsMask_;

SpvMemoryAccessShift_ :: enum u32 {
    VolatileShift                :: 0;
    AlignedShift                 :: 1;
    NontemporalShift             :: 2;
    MakePointerAvailableShift    :: 3;
    MakePointerAvailableKHRShift :: 3;
    MakePointerVisibleShift      :: 4;
    MakePointerVisibleKHRShift   :: 4;
    NonPrivatePointerShift       :: 5;
    NonPrivatePointerKHRShift    :: 5;
    AliasScopeINTELMaskShift     :: 16;
    NoAliasINTELMaskShift        :: 17;
    Max                          :: 2147483647;
}

SpvMemoryAccessShift :: SpvMemoryAccessShift_;

SpvMemoryAccessMask_ :: enum u32 {
    MaskNone                    :: 0;
    VolatileMask                :: 1;
    AlignedMask                 :: 2;
    NontemporalMask             :: 4;
    MakePointerAvailableMask    :: 8;
    MakePointerAvailableKHRMask :: 8;
    MakePointerVisibleMask      :: 16;
    MakePointerVisibleKHRMask   :: 16;
    NonPrivatePointerMask       :: 32;
    NonPrivatePointerKHRMask    :: 32;
    AliasScopeINTELMaskMask     :: 65536;
    NoAliasINTELMaskMask        :: 131072;
}

SpvMemoryAccessMask :: SpvMemoryAccessMask_;

SpvScope_ :: enum u32 {
    CrossDevice    :: 0;
    Device         :: 1;
    Workgroup      :: 2;
    Subgroup       :: 3;
    Invocation     :: 4;
    QueueFamily    :: 5;
    QueueFamilyKHR :: 5;
    ShaderCallKHR  :: 6;
    Max            :: 2147483647;
}

SpvScope :: SpvScope_;

SpvGroupOperation_ :: enum u32 {
    Reduce                     :: 0;
    InclusiveScan              :: 1;
    ExclusiveScan              :: 2;
    ClusteredReduce            :: 3;
    PartitionedReduceNV        :: 6;
    PartitionedInclusiveScanNV :: 7;
    PartitionedExclusiveScanNV :: 8;
    Max                        :: 2147483647;
}

SpvGroupOperation :: SpvGroupOperation_;

SpvKernelEnqueueFlags_ :: enum u32 {
    NoWait        :: 0;
    WaitKernel    :: 1;
    WaitWorkGroup :: 2;
    Max           :: 2147483647;
}

SpvKernelEnqueueFlags :: SpvKernelEnqueueFlags_;

SpvKernelProfilingInfoShift_ :: enum u32 {
    CmdExecTimeShift :: 0;
    Max              :: 2147483647;
}

SpvKernelProfilingInfoShift :: SpvKernelProfilingInfoShift_;

SpvKernelProfilingInfoMask_ :: enum u32 {
    MaskNone        :: 0;
    CmdExecTimeMask :: 1;
}

SpvKernelProfilingInfoMask :: SpvKernelProfilingInfoMask_;

SpvCapability_ :: enum u32 {
    Matrix                                       :: 0;
    Shader                                       :: 1;
    Geometry                                     :: 2;
    Tessellation                                 :: 3;
    Addresses                                    :: 4;
    Linkage                                      :: 5;
    Kernel                                       :: 6;
    Vector16                                     :: 7;
    Float16Buffer                                :: 8;
    Float16                                      :: 9;
    Float64                                      :: 10;
    Int64                                        :: 11;
    Int64Atomics                                 :: 12;
    ImageBasic                                   :: 13;
    ImageReadWrite                               :: 14;
    ImageMipmap                                  :: 15;
    Pipes                                        :: 17;
    Groups                                       :: 18;
    DeviceEnqueue                                :: 19;
    LiteralSampler                               :: 20;
    AtomicStorage                                :: 21;
    Int16                                        :: 22;
    TessellationPointSize                        :: 23;
    GeometryPointSize                            :: 24;
    ImageGatherExtended                          :: 25;
    StorageImageMultisample                      :: 27;
    UniformBufferArrayDynamicIndexing            :: 28;
    SampledImageArrayDynamicIndexing             :: 29;
    StorageBufferArrayDynamicIndexing            :: 30;
    StorageImageArrayDynamicIndexing             :: 31;
    ClipDistance                                 :: 32;
    CullDistance                                 :: 33;
    ImageCubeArray                               :: 34;
    SampleRateShading                            :: 35;
    ImageRect                                    :: 36;
    SampledRect                                  :: 37;
    GenericPointer                               :: 38;
    Int8                                         :: 39;
    InputAttachment                              :: 40;
    SparseResidency                              :: 41;
    MinLod                                       :: 42;
    Sampled1D                                    :: 43;
    Image1D                                      :: 44;
    SampledCubeArray                             :: 45;
    SampledBuffer                                :: 46;
    ImageBuffer                                  :: 47;
    ImageMSArray                                 :: 48;
    StorageImageExtendedFormats                  :: 49;
    ImageQuery                                   :: 50;
    DerivativeControl                            :: 51;
    InterpolationFunction                        :: 52;
    TransformFeedback                            :: 53;
    GeometryStreams                              :: 54;
    StorageImageReadWithoutFormat                :: 55;
    StorageImageWriteWithoutFormat               :: 56;
    MultiViewport                                :: 57;
    SubgroupDispatch                             :: 58;
    NamedBarrier                                 :: 59;
    PipeStorage                                  :: 60;
    GroupNonUniform                              :: 61;
    GroupNonUniformVote                          :: 62;
    GroupNonUniformArithmetic                    :: 63;
    GroupNonUniformBallot                        :: 64;
    GroupNonUniformShuffle                       :: 65;
    GroupNonUniformShuffleRelative               :: 66;
    GroupNonUniformClustered                     :: 67;
    GroupNonUniformQuad                          :: 68;
    ShaderLayer                                  :: 69;
    ShaderViewportIndex                          :: 70;
    UniformDecoration                            :: 71;
    CoreBuiltinsARM                              :: 4165;
    TileImageColorReadAccessEXT                  :: 4166;
    TileImageDepthReadAccessEXT                  :: 4167;
    TileImageStencilReadAccessEXT                :: 4168;
    TensorsARM                                   :: 4174;
    StorageTensorArrayDynamicIndexingARM         :: 4175;
    StorageTensorArrayNonUniformIndexingARM      :: 4176;
    GraphARM                                     :: 4191;
    CooperativeMatrixLayoutsARM                  :: 4201;
    Float8EXT                                    :: 4212;
    Float8CooperativeMatrixEXT                   :: 4213;
    FragmentShadingRateKHR                       :: 4422;
    SubgroupBallotKHR                            :: 4423;
    DrawParameters                               :: 4427;
    WorkgroupMemoryExplicitLayoutKHR             :: 4428;
    WorkgroupMemoryExplicitLayout8BitAccessKHR   :: 4429;
    WorkgroupMemoryExplicitLayout16BitAccessKHR  :: 4430;
    SubgroupVoteKHR                              :: 4431;
    StorageBuffer16BitAccess                     :: 4433;
    StorageUniformBufferBlock16                  :: 4433;
    StorageUniform16                             :: 4434;
    UniformAndStorageBuffer16BitAccess           :: 4434;
    StoragePushConstant16                        :: 4435;
    StorageInputOutput16                         :: 4436;
    DeviceGroup                                  :: 4437;
    MultiView                                    :: 4439;
    VariablePointersStorageBuffer                :: 4441;
    VariablePointers                             :: 4442;
    AtomicStorageOps                             :: 4445;
    SampleMaskPostDepthCoverage                  :: 4447;
    StorageBuffer8BitAccess                      :: 4448;
    UniformAndStorageBuffer8BitAccess            :: 4449;
    StoragePushConstant8                         :: 4450;
    DenormPreserve                               :: 4464;
    DenormFlushToZero                            :: 4465;
    SignedZeroInfNanPreserve                     :: 4466;
    RoundingModeRTE                              :: 4467;
    RoundingModeRTZ                              :: 4468;
    RayQueryProvisionalKHR                       :: 4471;
    RayQueryKHR                                  :: 4472;
    UntypedPointersKHR                           :: 4473;
    RayTraversalPrimitiveCullingKHR              :: 4478;
    RayTracingKHR                                :: 4479;
    TextureSampleWeightedQCOM                    :: 4484;
    TextureBoxFilterQCOM                         :: 4485;
    TextureBlockMatchQCOM                        :: 4486;
    TileShadingQCOM                              :: 4495;
    CooperativeMatrixConversionQCOM              :: 4496;
    TextureBlockMatch2QCOM                       :: 4498;
    Float16ImageAMD                              :: 5008;
    ImageGatherBiasLodAMD                        :: 5009;
    FragmentMaskAMD                              :: 5010;
    StencilExportEXT                             :: 5013;
    ImageReadWriteLodAMD                         :: 5015;
    Int64ImageEXT                                :: 5016;
    ShaderClockKHR                               :: 5055;
    ShaderEnqueueAMDX                            :: 5067;
    QuadControlKHR                               :: 5087;
    Int4TypeINTEL                                :: 5112;
    Int4CooperativeMatrixINTEL                   :: 5114;
    BFloat16TypeKHR                              :: 5116;
    BFloat16DotProductKHR                        :: 5117;
    BFloat16CooperativeMatrixKHR                 :: 5118;
    SampleMaskOverrideCoverageNV                 :: 5249;
    GeometryShaderPassthroughNV                  :: 5251;
    ShaderViewportIndexLayerEXT                  :: 5254;
    ShaderViewportIndexLayerNV                   :: 5254;
    ShaderViewportMaskNV                         :: 5255;
    ShaderStereoViewNV                           :: 5259;
    PerViewAttributesNV                          :: 5260;
    FragmentFullyCoveredEXT                      :: 5265;
    MeshShadingNV                                :: 5266;
    ImageFootprintNV                             :: 5282;
    MeshShadingEXT                               :: 5283;
    FragmentBarycentricKHR                       :: 5284;
    FragmentBarycentricNV                        :: 5284;
    ComputeDerivativeGroupQuadsKHR               :: 5288;
    ComputeDerivativeGroupQuadsNV                :: 5288;
    FragmentDensityEXT                           :: 5291;
    ShadingRateNV                                :: 5291;
    GroupNonUniformPartitionedNV                 :: 5297;
    ShaderNonUniform                             :: 5301;
    ShaderNonUniformEXT                          :: 5301;
    RuntimeDescriptorArray                       :: 5302;
    RuntimeDescriptorArrayEXT                    :: 5302;
    InputAttachmentArrayDynamicIndexing          :: 5303;
    InputAttachmentArrayDynamicIndexingEXT       :: 5303;
    UniformTexelBufferArrayDynamicIndexing       :: 5304;
    UniformTexelBufferArrayDynamicIndexingEXT    :: 5304;
    StorageTexelBufferArrayDynamicIndexing       :: 5305;
    StorageTexelBufferArrayDynamicIndexingEXT    :: 5305;
    UniformBufferArrayNonUniformIndexing         :: 5306;
    UniformBufferArrayNonUniformIndexingEXT      :: 5306;
    SampledImageArrayNonUniformIndexing          :: 5307;
    SampledImageArrayNonUniformIndexingEXT       :: 5307;
    StorageBufferArrayNonUniformIndexing         :: 5308;
    StorageBufferArrayNonUniformIndexingEXT      :: 5308;
    StorageImageArrayNonUniformIndexing          :: 5309;
    StorageImageArrayNonUniformIndexingEXT       :: 5309;
    InputAttachmentArrayNonUniformIndexing       :: 5310;
    InputAttachmentArrayNonUniformIndexingEXT    :: 5310;
    UniformTexelBufferArrayNonUniformIndexing    :: 5311;
    UniformTexelBufferArrayNonUniformIndexingEXT :: 5311;
    StorageTexelBufferArrayNonUniformIndexing    :: 5312;
    StorageTexelBufferArrayNonUniformIndexingEXT :: 5312;
    RayTracingPositionFetchKHR                   :: 5336;
    RayTracingNV                                 :: 5340;
    RayTracingMotionBlurNV                       :: 5341;
    VulkanMemoryModel                            :: 5345;
    VulkanMemoryModelKHR                         :: 5345;
    VulkanMemoryModelDeviceScope                 :: 5346;
    VulkanMemoryModelDeviceScopeKHR              :: 5346;
    PhysicalStorageBufferAddresses               :: 5347;
    PhysicalStorageBufferAddressesEXT            :: 5347;
    ComputeDerivativeGroupLinearKHR              :: 5350;
    ComputeDerivativeGroupLinearNV               :: 5350;
    RayTracingProvisionalKHR                     :: 5353;
    CooperativeMatrixNV                          :: 5357;
    FragmentShaderSampleInterlockEXT             :: 5363;
    FragmentShaderShadingRateInterlockEXT        :: 5372;
    ShaderSMBuiltinsNV                           :: 5373;
    FragmentShaderPixelInterlockEXT              :: 5378;
    DemoteToHelperInvocation                     :: 5379;
    DemoteToHelperInvocationEXT                  :: 5379;
    DisplacementMicromapNV                       :: 5380;
    RayTracingOpacityMicromapEXT                 :: 5381;
    ShaderInvocationReorderNV                    :: 5383;
    BindlessTextureNV                            :: 5390;
    RayQueryPositionFetchKHR                     :: 5391;
    CooperativeVectorNV                          :: 5394;
    AtomicFloat16VectorNV                        :: 5404;
    RayTracingDisplacementMicromapNV             :: 5409;
    RawAccessChainsNV                            :: 5414;
    RayTracingSpheresGeometryNV                  :: 5418;
    RayTracingLinearSweptSpheresGeometryNV       :: 5419;
    CooperativeMatrixReductionsNV                :: 5430;
    CooperativeMatrixConversionsNV               :: 5431;
    CooperativeMatrixPerElementOperationsNV      :: 5432;
    CooperativeMatrixTensorAddressingNV          :: 5433;
    CooperativeMatrixBlockLoadsNV                :: 5434;
    CooperativeVectorTrainingNV                  :: 5435;
    RayTracingClusterAccelerationStructureNV     :: 5437;
    TensorAddressingNV                           :: 5439;
    SubgroupShuffleINTEL                         :: 5568;
    SubgroupBufferBlockIOINTEL                   :: 5569;
    SubgroupImageBlockIOINTEL                    :: 5570;
    SubgroupImageMediaBlockIOINTEL               :: 5579;
    RoundToInfinityINTEL                         :: 5582;
    FloatingPointModeINTEL                       :: 5583;
    IntegerFunctions2INTEL                       :: 5584;
    FunctionPointersINTEL                        :: 5603;
    IndirectReferencesINTEL                      :: 5604;
    AsmINTEL                                     :: 5606;
    AtomicFloat32MinMaxEXT                       :: 5612;
    AtomicFloat64MinMaxEXT                       :: 5613;
    AtomicFloat16MinMaxEXT                       :: 5616;
    VectorComputeINTEL                           :: 5617;
    VectorAnyINTEL                               :: 5619;
    ExpectAssumeKHR                              :: 5629;
    SubgroupAvcMotionEstimationINTEL             :: 5696;
    SubgroupAvcMotionEstimationIntraINTEL        :: 5697;
    SubgroupAvcMotionEstimationChromaINTEL       :: 5698;
    VariableLengthArrayINTEL                     :: 5817;
    FunctionFloatControlINTEL                    :: 5821;
    FPGAMemoryAttributesINTEL                    :: 5824;
    FPFastMathModeINTEL                          :: 5837;
    ArbitraryPrecisionIntegersINTEL              :: 5844;
    ArbitraryPrecisionFloatingPointINTEL         :: 5845;
    UnstructuredLoopControlsINTEL                :: 5886;
    FPGALoopControlsINTEL                        :: 5888;
    KernelAttributesINTEL                        :: 5892;
    FPGAKernelAttributesINTEL                    :: 5897;
    FPGAMemoryAccessesINTEL                      :: 5898;
    FPGAClusterAttributesINTEL                   :: 5904;
    LoopFuseINTEL                                :: 5906;
    FPGADSPControlINTEL                          :: 5908;
    MemoryAccessAliasingINTEL                    :: 5910;
    FPGAInvocationPipeliningAttributesINTEL      :: 5916;
    FPGABufferLocationINTEL                      :: 5920;
    ArbitraryPrecisionFixedPointINTEL            :: 5922;
    USMStorageClassesINTEL                       :: 5935;
    RuntimeAlignedAttributeINTEL                 :: 5939;
    IOPipesINTEL                                 :: 5943;
    BlockingPipesINTEL                           :: 5945;
    FPGARegINTEL                                 :: 5948;
    DotProductInputAll                           :: 6016;
    DotProductInputAllKHR                        :: 6016;
    DotProductInput4x8Bit                        :: 6017;
    DotProductInput4x8BitKHR                     :: 6017;
    DotProductInput4x8BitPacked                  :: 6018;
    DotProductInput4x8BitPackedKHR               :: 6018;
    DotProduct                                   :: 6019;
    DotProductKHR                                :: 6019;
    RayCullMaskKHR                               :: 6020;
    CooperativeMatrixKHR                         :: 6022;
    ReplicatedCompositesEXT                      :: 6024;
    BitInstructions                              :: 6025;
    GroupNonUniformRotateKHR                     :: 6026;
    FloatControls2                               :: 6029;
    AtomicFloat32AddEXT                          :: 6033;
    AtomicFloat64AddEXT                          :: 6034;
    LongCompositesINTEL                          :: 6089;
    OptNoneEXT                                   :: 6094;
    OptNoneINTEL                                 :: 6094;
    AtomicFloat16AddEXT                          :: 6095;
    DebugInfoModuleINTEL                         :: 6114;
    BFloat16ConversionINTEL                      :: 6115;
    SplitBarrierINTEL                            :: 6141;
    ArithmeticFenceEXT                           :: 6144;
    FPGAClusterAttributesV2INTEL                 :: 6150;
    FPGAKernelAttributesv2INTEL                  :: 6161;
    TaskSequenceINTEL                            :: 6162;
    FPMaxErrorINTEL                              :: 6169;
    FPGALatencyControlINTEL                      :: 6171;
    FPGAArgumentInterfacesINTEL                  :: 6174;
    GlobalVariableHostAccessINTEL                :: 6187;
    GlobalVariableFPGADecorationsINTEL           :: 6189;
    SubgroupBufferPrefetchINTEL                  :: 6220;
    Subgroup2DBlockIOINTEL                       :: 6228;
    Subgroup2DBlockTransformINTEL                :: 6229;
    Subgroup2DBlockTransposeINTEL                :: 6230;
    SubgroupMatrixMultiplyAccumulateINTEL        :: 6236;
    TernaryBitwiseFunctionINTEL                  :: 6241;
    UntypedVariableLengthArrayINTEL              :: 6243;
    SpecConditionalINTEL                         :: 6245;
    FunctionVariantsINTEL                        :: 6246;
    GroupUniformArithmeticKHR                    :: 6400;
    TensorFloat32RoundingINTEL                   :: 6425;
    MaskedGatherScatterINTEL                     :: 6427;
    CacheControlsINTEL                           :: 6441;
    RegisterLimitsINTEL                          :: 6460;
    BindlessImagesINTEL                          :: 6528;
    Max                                          :: 2147483647;
}

SpvCapability :: SpvCapability_;

SpvRayFlagsShift_ :: enum u32 {
    OpaqueKHRShift                     :: 0;
    NoOpaqueKHRShift                   :: 1;
    TerminateOnFirstHitKHRShift        :: 2;
    SkipClosestHitShaderKHRShift       :: 3;
    CullBackFacingTrianglesKHRShift    :: 4;
    CullFrontFacingTrianglesKHRShift   :: 5;
    CullOpaqueKHRShift                 :: 6;
    CullNoOpaqueKHRShift               :: 7;
    SkipBuiltinPrimitivesNVShift       :: 8;
    SkipTrianglesKHRShift              :: 8;
    SkipAABBsKHRShift                  :: 9;
    ForceOpacityMicromap2StateEXTShift :: 10;
    Max                                :: 2147483647;
}

SpvRayFlagsShift :: SpvRayFlagsShift_;

SpvRayFlagsMask_ :: enum u32 {
    MaskNone                          :: 0;
    OpaqueKHRMask                     :: 1;
    NoOpaqueKHRMask                   :: 2;
    TerminateOnFirstHitKHRMask        :: 4;
    SkipClosestHitShaderKHRMask       :: 8;
    CullBackFacingTrianglesKHRMask    :: 16;
    CullFrontFacingTrianglesKHRMask   :: 32;
    CullOpaqueKHRMask                 :: 64;
    CullNoOpaqueKHRMask               :: 128;
    SkipBuiltinPrimitivesNVMask       :: 256;
    SkipTrianglesKHRMask              :: 256;
    SkipAABBsKHRMask                  :: 512;
    ForceOpacityMicromap2StateEXTMask :: 1024;
}

SpvRayFlagsMask :: SpvRayFlagsMask_;

SpvRayQueryIntersection_ :: enum u32 {
    RayQueryCandidateIntersectionKHR :: 0;
    RayQueryCommittedIntersectionKHR :: 1;
    Max                              :: 2147483647;
}

SpvRayQueryIntersection :: SpvRayQueryIntersection_;

SpvRayQueryCommittedIntersectionType_ :: enum u32 {
    RayQueryCommittedIntersectionNoneKHR      :: 0;
    RayQueryCommittedIntersectionTriangleKHR  :: 1;
    RayQueryCommittedIntersectionGeneratedKHR :: 2;
    Max                                       :: 2147483647;
}

SpvRayQueryCommittedIntersectionType :: SpvRayQueryCommittedIntersectionType_;

SpvRayQueryCandidateIntersectionType_ :: enum u32 {
    RayQueryCandidateIntersectionTriangleKHR :: 0;
    RayQueryCandidateIntersectionAABBKHR     :: 1;
    Max                                      :: 2147483647;
}

SpvRayQueryCandidateIntersectionType :: SpvRayQueryCandidateIntersectionType_;

SpvFragmentShadingRateShift_ :: enum u32 {
    Vertical2PixelsShift   :: 0;
    Vertical4PixelsShift   :: 1;
    Horizontal2PixelsShift :: 2;
    Horizontal4PixelsShift :: 3;
    Max                    :: 2147483647;
}

SpvFragmentShadingRateShift :: SpvFragmentShadingRateShift_;

SpvFragmentShadingRateMask_ :: enum u32 {
    MaskNone              :: 0;
    Vertical2PixelsMask   :: 1;
    Vertical4PixelsMask   :: 2;
    Horizontal2PixelsMask :: 4;
    Horizontal4PixelsMask :: 8;
}

SpvFragmentShadingRateMask :: SpvFragmentShadingRateMask_;

SpvFPDenormMode_ :: enum u32 {
    Preserve    :: 0;
    FlushToZero :: 1;
    Max         :: 2147483647;
}

SpvFPDenormMode :: SpvFPDenormMode_;

SpvFPOperationMode_ :: enum u32 {
    IEEE :: 0;
    ALT  :: 1;
    Max  :: 2147483647;
}

SpvFPOperationMode :: SpvFPOperationMode_;

SpvQuantizationModes_ :: enum u32 {
    TRN          :: 0;
    TRN_ZERO     :: 1;
    RND          :: 2;
    RND_ZERO     :: 3;
    RND_INF      :: 4;
    RND_MIN_INF  :: 5;
    RND_CONV     :: 6;
    RND_CONV_ODD :: 7;
    Max          :: 2147483647;
}

SpvQuantizationModes :: SpvQuantizationModes_;

SpvOverflowModes_ :: enum u32 {
    WRAP     :: 0;
    SAT      :: 1;
    SAT_ZERO :: 2;
    SAT_SYM  :: 3;
    Max      :: 2147483647;
}

SpvOverflowModes :: SpvOverflowModes_;

SpvPackedVectorFormat_ :: enum u32 {
    PackedVectorFormat4x8Bit    :: 0;
    PackedVectorFormat4x8BitKHR :: 0;
    Max                         :: 2147483647;
}

SpvPackedVectorFormat :: SpvPackedVectorFormat_;

SpvCooperativeMatrixOperandsShift_ :: enum u32 {
    MatrixASignedComponentsKHRShift      :: 0;
    MatrixBSignedComponentsKHRShift      :: 1;
    MatrixCSignedComponentsKHRShift      :: 2;
    MatrixResultSignedComponentsKHRShift :: 3;
    SaturatingAccumulationKHRShift       :: 4;
    Max                                  :: 2147483647;
}

SpvCooperativeMatrixOperandsShift :: SpvCooperativeMatrixOperandsShift_;

SpvCooperativeMatrixOperandsMask_ :: enum u32 {
    MaskNone                            :: 0;
    MatrixASignedComponentsKHRMask      :: 1;
    MatrixBSignedComponentsKHRMask      :: 2;
    MatrixCSignedComponentsKHRMask      :: 4;
    MatrixResultSignedComponentsKHRMask :: 8;
    SaturatingAccumulationKHRMask       :: 16;
}

SpvCooperativeMatrixOperandsMask :: SpvCooperativeMatrixOperandsMask_;

SpvCooperativeMatrixLayout_ :: enum u32 {
    RowMajorKHR                 :: 0;
    ColumnMajorKHR              :: 1;
    RowBlockedInterleavedARM    :: 4202;
    ColumnBlockedInterleavedARM :: 4203;
    Max                         :: 2147483647;
}

SpvCooperativeMatrixLayout :: SpvCooperativeMatrixLayout_;

SpvCooperativeMatrixUse_ :: enum u32 {
    trixAKHR           :: 0;
    trixBKHR           :: 1;
    trixAccumulatorKHR :: 2;
    x                  :: 2147483647;
}

SpvCooperativeMatrixUse :: SpvCooperativeMatrixUse_;

SpvCooperativeMatrixReduceShift_ :: enum u32 {
    RowShift    :: 0;
    ColumnShift :: 1;
    _2x2Shift   :: 2;
    Max         :: 2147483647;
}

SpvCooperativeMatrixReduceShift :: SpvCooperativeMatrixReduceShift_;

SpvCooperativeMatrixReduceMask_ :: enum u32 {
    MaskNone   :: 0;
    RowMask    :: 1;
    ColumnMask :: 2;
    _2x2Mask   :: 4;
}

SpvCooperativeMatrixReduceMask :: SpvCooperativeMatrixReduceMask_;

SpvTensorClampMode_ :: enum u32 {
    Undefined      :: 0;
    Constant       :: 1;
    ClampToEdge    :: 2;
    Repeat         :: 3;
    RepeatMirrored :: 4;
    Max            :: 2147483647;
}

SpvTensorClampMode :: SpvTensorClampMode_;

SpvTensorAddressingOperandsShift_ :: enum u32 {
    TensorViewShift :: 0;
    DecodeFuncShift :: 1;
    Max             :: 2147483647;
}

SpvTensorAddressingOperandsShift :: SpvTensorAddressingOperandsShift_;

SpvTensorAddressingOperandsMask_ :: enum u32 {
    MaskNone       :: 0;
    TensorViewMask :: 1;
    DecodeFuncMask :: 2;
}

SpvTensorAddressingOperandsMask :: SpvTensorAddressingOperandsMask_;

SpvTensorOperandsShift_ :: enum u32 {
    NontemporalARMShift          :: 0;
    OutOfBoundsValueARMShift     :: 1;
    MakeElementAvailableARMShift :: 2;
    MakeElementVisibleARMShift   :: 3;
    NonPrivateElementARMShift    :: 4;
    Max                          :: 2147483647;
}

SpvTensorOperandsShift :: SpvTensorOperandsShift_;

SpvTensorOperandsMask_ :: enum u32 {
    MaskNone                    :: 0;
    NontemporalARMMask          :: 1;
    OutOfBoundsValueARMMask     :: 2;
    MakeElementAvailableARMMask :: 4;
    MakeElementVisibleARMMask   :: 8;
    NonPrivateElementARMMask    :: 16;
}

SpvTensorOperandsMask :: SpvTensorOperandsMask_;

SpvInitializationModeQualifier_ :: enum u32 {
    InitOnDeviceReprogramINTEL :: 0;
    InitOnDeviceResetINTEL     :: 1;
    Max                        :: 2147483647;
}

SpvInitializationModeQualifier :: SpvInitializationModeQualifier_;

SpvHostAccessQualifier_ :: enum u32 {
    NoneINTEL      :: 0;
    ReadINTEL      :: 1;
    WriteINTEL     :: 2;
    ReadWriteINTEL :: 3;
    Max            :: 2147483647;
}

SpvHostAccessQualifier :: SpvHostAccessQualifier_;

SpvLoadCacheControl_ :: enum u32 {
    UncachedINTEL            :: 0;
    CachedINTEL              :: 1;
    StreamingINTEL           :: 2;
    InvalidateAfterReadINTEL :: 3;
    ConstCachedINTEL         :: 4;
    Max                      :: 2147483647;
}

SpvLoadCacheControl :: SpvLoadCacheControl_;

SpvStoreCacheControl_ :: enum u32 {
    UncachedINTEL     :: 0;
    WriteThroughINTEL :: 1;
    WriteBackINTEL    :: 2;
    StreamingINTEL    :: 3;
    Max               :: 2147483647;
}

SpvStoreCacheControl :: SpvStoreCacheControl_;

SpvNamedMaximumNumberOfRegisters_ :: enum u32 {
    AutoINTEL :: 0;
    Max       :: 2147483647;
}

SpvNamedMaximumNumberOfRegisters :: SpvNamedMaximumNumberOfRegisters_;

SpvMatrixMultiplyAccumulateOperandsShift_ :: enum u32 {
    trixASignedComponentsINTELShift :: 0;
    trixBSignedComponentsINTELShift :: 1;
    trixCBFloat16INTELShift         :: 2;
    trixResultBFloat16INTELShift    :: 3;
    trixAPackedInt8INTELShift       :: 4;
    trixBPackedInt8INTELShift       :: 5;
    trixAPackedInt4INTELShift       :: 6;
    trixBPackedInt4INTELShift       :: 7;
    trixATF32INTELShift             :: 8;
    trixBTF32INTELShift             :: 9;
    trixAPackedFloat16INTELShift    :: 10;
    trixBPackedFloat16INTELShift    :: 11;
    trixAPackedBFloat16INTELShift   :: 12;
    trixBPackedBFloat16INTELShift   :: 13;
    x                               :: 2147483647;
}

SpvMatrixMultiplyAccumulateOperandsShift :: SpvMatrixMultiplyAccumulateOperandsShift_;

SpvMatrixMultiplyAccumulateOperandsMask_ :: enum u32 {
    skNone                         :: 0;
    trixASignedComponentsINTELMask :: 1;
    trixBSignedComponentsINTELMask :: 2;
    trixCBFloat16INTELMask         :: 4;
    trixResultBFloat16INTELMask    :: 8;
    trixAPackedInt8INTELMask       :: 16;
    trixBPackedInt8INTELMask       :: 32;
    trixAPackedInt4INTELMask       :: 64;
    trixBPackedInt4INTELMask       :: 128;
    trixATF32INTELMask             :: 256;
    trixBTF32INTELMask             :: 512;
    trixAPackedFloat16INTELMask    :: 1024;
    trixBPackedFloat16INTELMask    :: 2048;
    trixAPackedBFloat16INTELMask   :: 4096;
    trixBPackedBFloat16INTELMask   :: 8192;
}

SpvMatrixMultiplyAccumulateOperandsMask :: SpvMatrixMultiplyAccumulateOperandsMask_;

SpvRawAccessChainOperandsShift_ :: enum u32 {
    RobustnessPerComponentNVShift :: 0;
    RobustnessPerElementNVShift   :: 1;
    Max                           :: 2147483647;
}

SpvRawAccessChainOperandsShift :: SpvRawAccessChainOperandsShift_;

SpvRawAccessChainOperandsMask_ :: enum u32 {
    MaskNone                     :: 0;
    RobustnessPerComponentNVMask :: 1;
    RobustnessPerElementNVMask   :: 2;
}

SpvRawAccessChainOperandsMask :: SpvRawAccessChainOperandsMask_;

SpvFPEncoding_ :: enum u32 {
    BFloat16KHR   :: 0;
    Float8E4M3EXT :: 4214;
    Float8E5M2EXT :: 4215;
    Max           :: 2147483647;
}

SpvFPEncoding :: SpvFPEncoding_;

SpvCooperativeVectorMatrixLayout_ :: enum u32 {
    RowMajorNV           :: 0;
    ColumnMajorNV        :: 1;
    InferencingOptimalNV :: 2;
    TrainingOptimalNV    :: 3;
    Max                  :: 2147483647;
}

SpvCooperativeVectorMatrixLayout :: SpvCooperativeVectorMatrixLayout_;

SpvComponentType_ :: enum u32 {
    Float16NV            :: 0;
    Float32NV            :: 1;
    Float64NV            :: 2;
    SignedInt8NV         :: 3;
    SignedInt16NV        :: 4;
    SignedInt32NV        :: 5;
    SignedInt64NV        :: 6;
    UnsignedInt8NV       :: 7;
    UnsignedInt16NV      :: 8;
    UnsignedInt32NV      :: 9;
    UnsignedInt64NV      :: 10;
    SignedInt8PackedNV   :: 1000491000;
    UnsignedInt8PackedNV :: 1000491001;
    FloatE4M3NV          :: 1000491002;
    FloatE5M2NV          :: 1000491003;
    Max                  :: 2147483647;
}

SpvComponentType :: SpvComponentType_;

SpvOp_ :: enum u32 {
    Nop                                                                   :: 0;
    Undef                                                                 :: 1;
    SourceContinued                                                       :: 2;
    Source                                                                :: 3;
    SourceExtension                                                       :: 4;
    Name                                                                  :: 5;
    MemberName                                                            :: 6;
    String                                                                :: 7;
    Line                                                                  :: 8;
    Extension                                                             :: 10;
    ExtInstImport                                                         :: 11;
    ExtInst                                                               :: 12;
    MemoryModel                                                           :: 14;
    EntryPoint                                                            :: 15;
    ExecutionMode                                                         :: 16;
    Capability                                                            :: 17;
    TypeVoid                                                              :: 19;
    TypeBool                                                              :: 20;
    TypeInt                                                               :: 21;
    TypeFloat                                                             :: 22;
    TypeVector                                                            :: 23;
    TypeMatrix                                                            :: 24;
    TypeImage                                                             :: 25;
    TypeSampler                                                           :: 26;
    TypeSampledImage                                                      :: 27;
    TypeArray                                                             :: 28;
    TypeRuntimeArray                                                      :: 29;
    TypeStruct                                                            :: 30;
    TypeOpaque                                                            :: 31;
    TypePointer                                                           :: 32;
    TypeFunction                                                          :: 33;
    TypeEvent                                                             :: 34;
    TypeDeviceEvent                                                       :: 35;
    TypeReserveId                                                         :: 36;
    TypeQueue                                                             :: 37;
    TypePipe                                                              :: 38;
    TypeForwardPointer                                                    :: 39;
    ConstantTrue                                                          :: 41;
    ConstantFalse                                                         :: 42;
    Constant                                                              :: 43;
    ConstantComposite                                                     :: 44;
    ConstantSampler                                                       :: 45;
    ConstantNull                                                          :: 46;
    SpecConstantTrue                                                      :: 48;
    SpecConstantFalse                                                     :: 49;
    SpecConstant                                                          :: 50;
    SpecConstantComposite                                                 :: 51;
    SpecConstantOp                                                        :: 52;
    Function                                                              :: 54;
    FunctionParameter                                                     :: 55;
    FunctionEnd                                                           :: 56;
    FunctionCall                                                          :: 57;
    Variable                                                              :: 59;
    ImageTexelPointer                                                     :: 60;
    Load                                                                  :: 61;
    Store                                                                 :: 62;
    CopyMemory                                                            :: 63;
    CopyMemorySized                                                       :: 64;
    AccessChain                                                           :: 65;
    InBoundsAccessChain                                                   :: 66;
    PtrAccessChain                                                        :: 67;
    ArrayLength                                                           :: 68;
    GenericPtrMemSemantics                                                :: 69;
    InBoundsPtrAccessChain                                                :: 70;
    Decorate                                                              :: 71;
    MemberDecorate                                                        :: 72;
    DecorationGroup                                                       :: 73;
    GroupDecorate                                                         :: 74;
    GroupMemberDecorate                                                   :: 75;
    VectorExtractDynamic                                                  :: 77;
    VectorInsertDynamic                                                   :: 78;
    VectorShuffle                                                         :: 79;
    CompositeConstruct                                                    :: 80;
    CompositeExtract                                                      :: 81;
    CompositeInsert                                                       :: 82;
    CopyObject                                                            :: 83;
    Transpose                                                             :: 84;
    SampledImage                                                          :: 86;
    ImageSampleImplicitLod                                                :: 87;
    ImageSampleExplicitLod                                                :: 88;
    ImageSampleDrefImplicitLod                                            :: 89;
    ImageSampleDrefExplicitLod                                            :: 90;
    ImageSampleProjImplicitLod                                            :: 91;
    ImageSampleProjExplicitLod                                            :: 92;
    ImageSampleProjDrefImplicitLod                                        :: 93;
    ImageSampleProjDrefExplicitLod                                        :: 94;
    ImageFetch                                                            :: 95;
    ImageGather                                                           :: 96;
    ImageDrefGather                                                       :: 97;
    ImageRead                                                             :: 98;
    ImageWrite                                                            :: 99;
    Image                                                                 :: 100;
    ImageQueryFormat                                                      :: 101;
    ImageQueryOrder                                                       :: 102;
    ImageQuerySizeLod                                                     :: 103;
    ImageQuerySize                                                        :: 104;
    ImageQueryLod                                                         :: 105;
    ImageQueryLevels                                                      :: 106;
    ImageQuerySamples                                                     :: 107;
    ConvertFToU                                                           :: 109;
    ConvertFToS                                                           :: 110;
    ConvertSToF                                                           :: 111;
    ConvertUToF                                                           :: 112;
    UConvert                                                              :: 113;
    SConvert                                                              :: 114;
    FConvert                                                              :: 115;
    QuantizeToF16                                                         :: 116;
    ConvertPtrToU                                                         :: 117;
    SatConvertSToU                                                        :: 118;
    SatConvertUToS                                                        :: 119;
    ConvertUToPtr                                                         :: 120;
    PtrCastToGeneric                                                      :: 121;
    GenericCastToPtr                                                      :: 122;
    GenericCastToPtrExplicit                                              :: 123;
    Bitcast                                                               :: 124;
    SNegate                                                               :: 126;
    FNegate                                                               :: 127;
    IAdd                                                                  :: 128;
    FAdd                                                                  :: 129;
    ISub                                                                  :: 130;
    FSub                                                                  :: 131;
    IMul                                                                  :: 132;
    FMul                                                                  :: 133;
    UDiv                                                                  :: 134;
    SDiv                                                                  :: 135;
    FDiv                                                                  :: 136;
    UMod                                                                  :: 137;
    SRem                                                                  :: 138;
    SMod                                                                  :: 139;
    FRem                                                                  :: 140;
    FMod                                                                  :: 141;
    VectorTimesScalar                                                     :: 142;
    MatrixTimesScalar                                                     :: 143;
    VectorTimesMatrix                                                     :: 144;
    MatrixTimesVector                                                     :: 145;
    MatrixTimesMatrix                                                     :: 146;
    OuterProduct                                                          :: 147;
    Dot                                                                   :: 148;
    IAddCarry                                                             :: 149;
    ISubBorrow                                                            :: 150;
    UMulExtended                                                          :: 151;
    SMulExtended                                                          :: 152;
    _Any                                                                  :: 154;
    All                                                                   :: 155;
    IsNan                                                                 :: 156;
    IsInf                                                                 :: 157;
    IsFinite                                                              :: 158;
    IsNormal                                                              :: 159;
    SignBitSet                                                            :: 160;
    LessOrGreater                                                         :: 161;
    Ordered                                                               :: 162;
    Unordered                                                             :: 163;
    LogicalEqual                                                          :: 164;
    LogicalNotEqual                                                       :: 165;
    LogicalOr                                                             :: 166;
    LogicalAnd                                                            :: 167;
    LogicalNot                                                            :: 168;
    Select                                                                :: 169;
    IEqual                                                                :: 170;
    INotEqual                                                             :: 171;
    UGreaterThan                                                          :: 172;
    SGreaterThan                                                          :: 173;
    UGreaterThanEqual                                                     :: 174;
    SGreaterThanEqual                                                     :: 175;
    ULessThan                                                             :: 176;
    SLessThan                                                             :: 177;
    ULessThanEqual                                                        :: 178;
    SLessThanEqual                                                        :: 179;
    FOrdEqual                                                             :: 180;
    FUnordEqual                                                           :: 181;
    FOrdNotEqual                                                          :: 182;
    FUnordNotEqual                                                        :: 183;
    FOrdLessThan                                                          :: 184;
    FUnordLessThan                                                        :: 185;
    FOrdGreaterThan                                                       :: 186;
    FUnordGreaterThan                                                     :: 187;
    FOrdLessThanEqual                                                     :: 188;
    FUnordLessThanEqual                                                   :: 189;
    FOrdGreaterThanEqual                                                  :: 190;
    FUnordGreaterThanEqual                                                :: 191;
    ShiftRightLogical                                                     :: 194;
    ShiftRightArithmetic                                                  :: 195;
    ShiftLeftLogical                                                      :: 196;
    BitwiseOr                                                             :: 197;
    BitwiseXor                                                            :: 198;
    BitwiseAnd                                                            :: 199;
    Not                                                                   :: 200;
    BitFieldInsert                                                        :: 201;
    BitFieldSExtract                                                      :: 202;
    BitFieldUExtract                                                      :: 203;
    BitReverse                                                            :: 204;
    BitCount                                                              :: 205;
    DPdx                                                                  :: 207;
    DPdy                                                                  :: 208;
    Fwidth                                                                :: 209;
    DPdxFine                                                              :: 210;
    DPdyFine                                                              :: 211;
    FwidthFine                                                            :: 212;
    DPdxCoarse                                                            :: 213;
    DPdyCoarse                                                            :: 214;
    FwidthCoarse                                                          :: 215;
    EmitVertex                                                            :: 218;
    EndPrimitive                                                          :: 219;
    EmitStreamVertex                                                      :: 220;
    EndStreamPrimitive                                                    :: 221;
    ControlBarrier                                                        :: 224;
    MemoryBarrier                                                         :: 225;
    AtomicLoad                                                            :: 227;
    AtomicStore                                                           :: 228;
    AtomicExchange                                                        :: 229;
    AtomicCompareExchange                                                 :: 230;
    AtomicCompareExchangeWeak                                             :: 231;
    AtomicIIncrement                                                      :: 232;
    AtomicIDecrement                                                      :: 233;
    AtomicIAdd                                                            :: 234;
    AtomicISub                                                            :: 235;
    AtomicSMin                                                            :: 236;
    AtomicUMin                                                            :: 237;
    AtomicSMax                                                            :: 238;
    AtomicUMax                                                            :: 239;
    AtomicAnd                                                             :: 240;
    AtomicOr                                                              :: 241;
    AtomicXor                                                             :: 242;
    Phi                                                                   :: 245;
    LoopMerge                                                             :: 246;
    SelectionMerge                                                        :: 247;
    Label                                                                 :: 248;
    Branch                                                                :: 249;
    BranchConditional                                                     :: 250;
    Switch                                                                :: 251;
    Kill                                                                  :: 252;
    Return                                                                :: 253;
    ReturnValue                                                           :: 254;
    Unreachable                                                           :: 255;
    LifetimeStart                                                         :: 256;
    LifetimeStop                                                          :: 257;
    GroupAsyncCopy                                                        :: 259;
    GroupWaitEvents                                                       :: 260;
    GroupAll                                                              :: 261;
    GroupAny                                                              :: 262;
    GroupBroadcast                                                        :: 263;
    GroupIAdd                                                             :: 264;
    GroupFAdd                                                             :: 265;
    GroupFMin                                                             :: 266;
    GroupUMin                                                             :: 267;
    GroupSMin                                                             :: 268;
    GroupFMax                                                             :: 269;
    GroupUMax                                                             :: 270;
    GroupSMax                                                             :: 271;
    ReadPipe                                                              :: 274;
    WritePipe                                                             :: 275;
    ReservedReadPipe                                                      :: 276;
    ReservedWritePipe                                                     :: 277;
    ReserveReadPipePackets                                                :: 278;
    ReserveWritePipePackets                                               :: 279;
    CommitReadPipe                                                        :: 280;
    CommitWritePipe                                                       :: 281;
    IsValidReserveId                                                      :: 282;
    GetNumPipePackets                                                     :: 283;
    GetMaxPipePackets                                                     :: 284;
    GroupReserveReadPipePackets                                           :: 285;
    GroupReserveWritePipePackets                                          :: 286;
    GroupCommitReadPipe                                                   :: 287;
    GroupCommitWritePipe                                                  :: 288;
    EnqueueMarker                                                         :: 291;
    EnqueueKernel                                                         :: 292;
    GetKernelNDrangeSubGroupCount                                         :: 293;
    GetKernelNDrangeMaxSubGroupSize                                       :: 294;
    GetKernelWorkGroupSize                                                :: 295;
    GetKernelPreferredWorkGroupSizeMultiple                               :: 296;
    RetainEvent                                                           :: 297;
    ReleaseEvent                                                          :: 298;
    CreateUserEvent                                                       :: 299;
    IsValidEvent                                                          :: 300;
    SetUserEventStatus                                                    :: 301;
    CaptureEventProfilingInfo                                             :: 302;
    GetDefaultQueue                                                       :: 303;
    BuildNDRange                                                          :: 304;
    ImageSparseSampleImplicitLod                                          :: 305;
    ImageSparseSampleExplicitLod                                          :: 306;
    ImageSparseSampleDrefImplicitLod                                      :: 307;
    ImageSparseSampleDrefExplicitLod                                      :: 308;
    ImageSparseSampleProjImplicitLod                                      :: 309;
    ImageSparseSampleProjExplicitLod                                      :: 310;
    ImageSparseSampleProjDrefImplicitLod                                  :: 311;
    ImageSparseSampleProjDrefExplicitLod                                  :: 312;
    ImageSparseFetch                                                      :: 313;
    ImageSparseGather                                                     :: 314;
    ImageSparseDrefGather                                                 :: 315;
    ImageSparseTexelsResident                                             :: 316;
    NoLine                                                                :: 317;
    AtomicFlagTestAndSet                                                  :: 318;
    AtomicFlagClear                                                       :: 319;
    ImageSparseRead                                                       :: 320;
    SizeOf                                                                :: 321;
    TypePipeStorage                                                       :: 322;
    ConstantPipeStorage                                                   :: 323;
    CreatePipeFromPipeStorage                                             :: 324;
    GetKernelLocalSizeForSubgroupCount                                    :: 325;
    GetKernelMaxNumSubgroups                                              :: 326;
    TypeNamedBarrier                                                      :: 327;
    NamedBarrierInitialize                                                :: 328;
    MemoryNamedBarrier                                                    :: 329;
    ModuleProcessed                                                       :: 330;
    ExecutionModeId                                                       :: 331;
    DecorateId                                                            :: 332;
    GroupNonUniformElect                                                  :: 333;
    GroupNonUniformAll                                                    :: 334;
    GroupNonUniformAny                                                    :: 335;
    GroupNonUniformAllEqual                                               :: 336;
    GroupNonUniformBroadcast                                              :: 337;
    GroupNonUniformBroadcastFirst                                         :: 338;
    GroupNonUniformBallot                                                 :: 339;
    GroupNonUniformInverseBallot                                          :: 340;
    GroupNonUniformBallotBitExtract                                       :: 341;
    GroupNonUniformBallotBitCount                                         :: 342;
    GroupNonUniformBallotFindLSB                                          :: 343;
    GroupNonUniformBallotFindMSB                                          :: 344;
    GroupNonUniformShuffle                                                :: 345;
    GroupNonUniformShuffleXor                                             :: 346;
    GroupNonUniformShuffleUp                                              :: 347;
    GroupNonUniformShuffleDown                                            :: 348;
    GroupNonUniformIAdd                                                   :: 349;
    GroupNonUniformFAdd                                                   :: 350;
    GroupNonUniformIMul                                                   :: 351;
    GroupNonUniformFMul                                                   :: 352;
    GroupNonUniformSMin                                                   :: 353;
    GroupNonUniformUMin                                                   :: 354;
    GroupNonUniformFMin                                                   :: 355;
    GroupNonUniformSMax                                                   :: 356;
    GroupNonUniformUMax                                                   :: 357;
    GroupNonUniformFMax                                                   :: 358;
    GroupNonUniformBitwiseAnd                                             :: 359;
    GroupNonUniformBitwiseOr                                              :: 360;
    GroupNonUniformBitwiseXor                                             :: 361;
    GroupNonUniformLogicalAnd                                             :: 362;
    GroupNonUniformLogicalOr                                              :: 363;
    GroupNonUniformLogicalXor                                             :: 364;
    GroupNonUniformQuadBroadcast                                          :: 365;
    GroupNonUniformQuadSwap                                               :: 366;
    CopyLogical                                                           :: 400;
    PtrEqual                                                              :: 401;
    PtrNotEqual                                                           :: 402;
    PtrDiff                                                               :: 403;
    ColorAttachmentReadEXT                                                :: 4160;
    DepthAttachmentReadEXT                                                :: 4161;
    StencilAttachmentReadEXT                                              :: 4162;
    TypeTensorARM                                                         :: 4163;
    TensorReadARM                                                         :: 4164;
    TensorWriteARM                                                        :: 4165;
    TensorQuerySizeARM                                                    :: 4166;
    GraphConstantARM                                                      :: 4181;
    GraphEntryPointARM                                                    :: 4182;
    GraphARM                                                              :: 4183;
    GraphInputARM                                                         :: 4184;
    GraphSetOutputARM                                                     :: 4185;
    GraphEndARM                                                           :: 4186;
    TypeGraphARM                                                          :: 4190;
    TerminateInvocation                                                   :: 4416;
    TypeUntypedPointerKHR                                                 :: 4417;
    UntypedVariableKHR                                                    :: 4418;
    UntypedAccessChainKHR                                                 :: 4419;
    UntypedInBoundsAccessChainKHR                                         :: 4420;
    SubgroupBallotKHR                                                     :: 4421;
    SubgroupFirstInvocationKHR                                            :: 4422;
    UntypedPtrAccessChainKHR                                              :: 4423;
    UntypedInBoundsPtrAccessChainKHR                                      :: 4424;
    UntypedArrayLengthKHR                                                 :: 4425;
    UntypedPrefetchKHR                                                    :: 4426;
    SubgroupAllKHR                                                        :: 4428;
    SubgroupAnyKHR                                                        :: 4429;
    SubgroupAllEqualKHR                                                   :: 4430;
    GroupNonUniformRotateKHR                                              :: 4431;
    SubgroupReadInvocationKHR                                             :: 4432;
    ExtInstWithForwardRefsKHR                                             :: 4433;
    UntypedGroupAsyncCopyKHR                                              :: 4434;
    TraceRayKHR                                                           :: 4445;
    ExecuteCallableKHR                                                    :: 4446;
    ConvertUToAccelerationStructureKHR                                    :: 4447;
    IgnoreIntersectionKHR                                                 :: 4448;
    TerminateRayKHR                                                       :: 4449;
    SDot                                                                  :: 4450;
    SDotKHR                                                               :: 4450;
    UDot                                                                  :: 4451;
    UDotKHR                                                               :: 4451;
    SUDot                                                                 :: 4452;
    SUDotKHR                                                              :: 4452;
    SDotAccSat                                                            :: 4453;
    SDotAccSatKHR                                                         :: 4453;
    UDotAccSat                                                            :: 4454;
    UDotAccSatKHR                                                         :: 4454;
    SUDotAccSat                                                           :: 4455;
    SUDotAccSatKHR                                                        :: 4455;
    TypeCooperativeMatrixKHR                                              :: 4456;
    CooperativeMatrixLoadKHR                                              :: 4457;
    CooperativeMatrixStoreKHR                                             :: 4458;
    CooperativeMatrixMulAddKHR                                            :: 4459;
    CooperativeMatrixLengthKHR                                            :: 4460;
    ConstantCompositeReplicateEXT                                         :: 4461;
    SpecConstantCompositeReplicateEXT                                     :: 4462;
    CompositeConstructReplicateEXT                                        :: 4463;
    TypeRayQueryKHR                                                       :: 4472;
    RayQueryInitializeKHR                                                 :: 4473;
    RayQueryTerminateKHR                                                  :: 4474;
    RayQueryGenerateIntersectionKHR                                       :: 4475;
    RayQueryConfirmIntersectionKHR                                        :: 4476;
    RayQueryProceedKHR                                                    :: 4477;
    RayQueryGetIntersectionTypeKHR                                        :: 4479;
    ImageSampleWeightedQCOM                                               :: 4480;
    ImageBoxFilterQCOM                                                    :: 4481;
    ImageBlockMatchSSDQCOM                                                :: 4482;
    ImageBlockMatchSADQCOM                                                :: 4483;
    BitCastArrayQCOM                                                      :: 4497;
    ImageBlockMatchWindowSSDQCOM                                          :: 4500;
    ImageBlockMatchWindowSADQCOM                                          :: 4501;
    ImageBlockMatchGatherSSDQCOM                                          :: 4502;
    ImageBlockMatchGatherSADQCOM                                          :: 4503;
    CompositeConstructCoopMatQCOM                                         :: 4540;
    CompositeExtractCoopMatQCOM                                           :: 4541;
    ExtractSubArrayQCOM                                                   :: 4542;
    GroupIAddNonUniformAMD                                                :: 5000;
    GroupFAddNonUniformAMD                                                :: 5001;
    GroupFMinNonUniformAMD                                                :: 5002;
    GroupUMinNonUniformAMD                                                :: 5003;
    GroupSMinNonUniformAMD                                                :: 5004;
    GroupFMaxNonUniformAMD                                                :: 5005;
    GroupUMaxNonUniformAMD                                                :: 5006;
    GroupSMaxNonUniformAMD                                                :: 5007;
    FragmentMaskFetchAMD                                                  :: 5011;
    FragmentFetchAMD                                                      :: 5012;
    ReadClockKHR                                                          :: 5056;
    AllocateNodePayloadsAMDX                                              :: 5074;
    EnqueueNodePayloadsAMDX                                               :: 5075;
    TypeNodePayloadArrayAMDX                                              :: 5076;
    FinishWritingNodePayloadAMDX                                          :: 5078;
    NodePayloadArrayLengthAMDX                                            :: 5090;
    IsNodePayloadValidAMDX                                                :: 5101;
    ConstantStringAMDX                                                    :: 5103;
    SpecConstantStringAMDX                                                :: 5104;
    GroupNonUniformQuadAllKHR                                             :: 5110;
    GroupNonUniformQuadAnyKHR                                             :: 5111;
    HitObjectRecordHitMotionNV                                            :: 5249;
    HitObjectRecordHitWithIndexMotionNV                                   :: 5250;
    HitObjectRecordMissMotionNV                                           :: 5251;
    HitObjectGetWorldToObjectNV                                           :: 5252;
    HitObjectGetObjectToWorldNV                                           :: 5253;
    HitObjectGetObjectRayDirectionNV                                      :: 5254;
    HitObjectGetObjectRayOriginNV                                         :: 5255;
    HitObjectTraceRayMotionNV                                             :: 5256;
    HitObjectGetShaderRecordBufferHandleNV                                :: 5257;
    HitObjectGetShaderBindingTableRecordIndexNV                           :: 5258;
    HitObjectRecordEmptyNV                                                :: 5259;
    HitObjectTraceRayNV                                                   :: 5260;
    HitObjectRecordHitNV                                                  :: 5261;
    HitObjectRecordHitWithIndexNV                                         :: 5262;
    HitObjectRecordMissNV                                                 :: 5263;
    HitObjectExecuteShaderNV                                              :: 5264;
    HitObjectGetCurrentTimeNV                                             :: 5265;
    HitObjectGetAttributesNV                                              :: 5266;
    HitObjectGetHitKindNV                                                 :: 5267;
    HitObjectGetPrimitiveIndexNV                                          :: 5268;
    HitObjectGetGeometryIndexNV                                           :: 5269;
    HitObjectGetInstanceIdNV                                              :: 5270;
    HitObjectGetInstanceCustomIndexNV                                     :: 5271;
    HitObjectGetWorldRayDirectionNV                                       :: 5272;
    HitObjectGetWorldRayOriginNV                                          :: 5273;
    HitObjectGetRayTMaxNV                                                 :: 5274;
    HitObjectGetRayTMinNV                                                 :: 5275;
    HitObjectIsEmptyNV                                                    :: 5276;
    HitObjectIsHitNV                                                      :: 5277;
    HitObjectIsMissNV                                                     :: 5278;
    ReorderThreadWithHitObjectNV                                          :: 5279;
    ReorderThreadWithHintNV                                               :: 5280;
    TypeHitObjectNV                                                       :: 5281;
    ImageSampleFootprintNV                                                :: 5283;
    TypeCooperativeVectorNV                                               :: 5288;
    CooperativeVectorMatrixMulNV                                          :: 5289;
    CooperativeVectorOuterProductAccumulateNV                             :: 5290;
    CooperativeVectorReduceSumAccumulateNV                                :: 5291;
    CooperativeVectorMatrixMulAddNV                                       :: 5292;
    CooperativeMatrixConvertNV                                            :: 5293;
    EmitMeshTasksEXT                                                      :: 5294;
    SetMeshOutputsEXT                                                     :: 5295;
    GroupNonUniformPartitionNV                                            :: 5296;
    WritePackedPrimitiveIndices4x8NV                                      :: 5299;
    FetchMicroTriangleVertexPositionNV                                    :: 5300;
    FetchMicroTriangleVertexBarycentricNV                                 :: 5301;
    CooperativeVectorLoadNV                                               :: 5302;
    CooperativeVectorStoreNV                                              :: 5303;
    ReportIntersectionKHR                                                 :: 5334;
    ReportIntersectionNV                                                  :: 5334;
    IgnoreIntersectionNV                                                  :: 5335;
    TerminateRayNV                                                        :: 5336;
    TraceNV                                                               :: 5337;
    TraceMotionNV                                                         :: 5338;
    TraceRayMotionNV                                                      :: 5339;
    RayQueryGetIntersectionTriangleVertexPositionsKHR                     :: 5340;
    TypeAccelerationStructureKHR                                          :: 5341;
    TypeAccelerationStructureNV                                           :: 5341;
    ExecuteCallableNV                                                     :: 5344;
    RayQueryGetClusterIdNV                                                :: 5345;
    RayQueryGetIntersectionClusterIdNV                                    :: 5345;
    HitObjectGetClusterIdNV                                               :: 5346;
    TypeCooperativeMatrixNV                                               :: 5358;
    CooperativeMatrixLoadNV                                               :: 5359;
    CooperativeMatrixStoreNV                                              :: 5360;
    CooperativeMatrixMulAddNV                                             :: 5361;
    CooperativeMatrixLengthNV                                             :: 5362;
    BeginInvocationInterlockEXT                                           :: 5364;
    EndInvocationInterlockEXT                                             :: 5365;
    CooperativeMatrixReduceNV                                             :: 5366;
    CooperativeMatrixLoadTensorNV                                         :: 5367;
    CooperativeMatrixStoreTensorNV                                        :: 5368;
    CooperativeMatrixPerElementOpNV                                       :: 5369;
    TypeTensorLayoutNV                                                    :: 5370;
    TypeTensorViewNV                                                      :: 5371;
    CreateTensorLayoutNV                                                  :: 5372;
    TensorLayoutSetDimensionNV                                            :: 5373;
    TensorLayoutSetStrideNV                                               :: 5374;
    TensorLayoutSliceNV                                                   :: 5375;
    TensorLayoutSetClampValueNV                                           :: 5376;
    CreateTensorViewNV                                                    :: 5377;
    TensorViewSetDimensionNV                                              :: 5378;
    TensorViewSetStrideNV                                                 :: 5379;
    DemoteToHelperInvocation                                              :: 5380;
    DemoteToHelperInvocationEXT                                           :: 5380;
    IsHelperInvocationEXT                                                 :: 5381;
    TensorViewSetClipNV                                                   :: 5382;
    TensorLayoutSetBlockSizeNV                                            :: 5384;
    CooperativeMatrixTransposeNV                                          :: 5390;
    ConvertUToImageNV                                                     :: 5391;
    ConvertUToSamplerNV                                                   :: 5392;
    ConvertImageToUNV                                                     :: 5393;
    ConvertSamplerToUNV                                                   :: 5394;
    ConvertUToSampledImageNV                                              :: 5395;
    ConvertSampledImageToUNV                                              :: 5396;
    SamplerImageAddressingModeNV                                          :: 5397;
    RawAccessChainNV                                                      :: 5398;
    RayQueryGetIntersectionSpherePositionNV                               :: 5427;
    RayQueryGetIntersectionSphereRadiusNV                                 :: 5428;
    RayQueryGetIntersectionLSSPositionsNV                                 :: 5429;
    RayQueryGetIntersectionLSSRadiiNV                                     :: 5430;
    RayQueryGetIntersectionLSSHitValueNV                                  :: 5431;
    HitObjectGetSpherePositionNV                                          :: 5432;
    HitObjectGetSphereRadiusNV                                            :: 5433;
    HitObjectGetLSSPositionsNV                                            :: 5434;
    HitObjectGetLSSRadiiNV                                                :: 5435;
    HitObjectIsSphereHitNV                                                :: 5436;
    HitObjectIsLSSHitNV                                                   :: 5437;
    RayQueryIsSphereHitNV                                                 :: 5438;
    RayQueryIsLSSHitNV                                                    :: 5439;
    SubgroupShuffleINTEL                                                  :: 5571;
    SubgroupShuffleDownINTEL                                              :: 5572;
    SubgroupShuffleUpINTEL                                                :: 5573;
    SubgroupShuffleXorINTEL                                               :: 5574;
    SubgroupBlockReadINTEL                                                :: 5575;
    SubgroupBlockWriteINTEL                                               :: 5576;
    SubgroupImageBlockReadINTEL                                           :: 5577;
    SubgroupImageBlockWriteINTEL                                          :: 5578;
    SubgroupImageMediaBlockReadINTEL                                      :: 5580;
    SubgroupImageMediaBlockWriteINTEL                                     :: 5581;
    UCountLeadingZerosINTEL                                               :: 5585;
    UCountTrailingZerosINTEL                                              :: 5586;
    AbsISubINTEL                                                          :: 5587;
    AbsUSubINTEL                                                          :: 5588;
    IAddSatINTEL                                                          :: 5589;
    UAddSatINTEL                                                          :: 5590;
    IAverageINTEL                                                         :: 5591;
    UAverageINTEL                                                         :: 5592;
    IAverageRoundedINTEL                                                  :: 5593;
    UAverageRoundedINTEL                                                  :: 5594;
    ISubSatINTEL                                                          :: 5595;
    USubSatINTEL                                                          :: 5596;
    IMul32x16INTEL                                                        :: 5597;
    UMul32x16INTEL                                                        :: 5598;
    ConstantFunctionPointerINTEL                                          :: 5600;
    FunctionPointerCallINTEL                                              :: 5601;
    AsmTargetINTEL                                                        :: 5609;
    AsmINTEL                                                              :: 5610;
    AsmCallINTEL                                                          :: 5611;
    AtomicFMinEXT                                                         :: 5614;
    AtomicFMaxEXT                                                         :: 5615;
    AssumeTrueKHR                                                         :: 5630;
    ExpectKHR                                                             :: 5631;
    DecorateString                                                        :: 5632;
    DecorateStringGOOGLE                                                  :: 5632;
    MemberDecorateString                                                  :: 5633;
    MemberDecorateStringGOOGLE                                            :: 5633;
    VmeImageINTEL                                                         :: 5699;
    TypeVmeImageINTEL                                                     :: 5700;
    TypeAvcImePayloadINTEL                                                :: 5701;
    TypeAvcRefPayloadINTEL                                                :: 5702;
    TypeAvcSicPayloadINTEL                                                :: 5703;
    TypeAvcMcePayloadINTEL                                                :: 5704;
    TypeAvcMceResultINTEL                                                 :: 5705;
    TypeAvcImeResultINTEL                                                 :: 5706;
    TypeAvcImeResultSingleReferenceStreamoutINTEL                         :: 5707;
    TypeAvcImeResultDualReferenceStreamoutINTEL                           :: 5708;
    TypeAvcImeSingleReferenceStreaminINTEL                                :: 5709;
    TypeAvcImeDualReferenceStreaminINTEL                                  :: 5710;
    TypeAvcRefResultINTEL                                                 :: 5711;
    TypeAvcSicResultINTEL                                                 :: 5712;
    SubgroupAvcMceGetDefaultInterBaseMultiReferencePenaltyINTEL           :: 5713;
    SubgroupAvcMceSetInterBaseMultiReferencePenaltyINTEL                  :: 5714;
    SubgroupAvcMceGetDefaultInterShapePenaltyINTEL                        :: 5715;
    SubgroupAvcMceSetInterShapePenaltyINTEL                               :: 5716;
    SubgroupAvcMceGetDefaultInterDirectionPenaltyINTEL                    :: 5717;
    SubgroupAvcMceSetInterDirectionPenaltyINTEL                           :: 5718;
    SubgroupAvcMceGetDefaultIntraLumaShapePenaltyINTEL                    :: 5719;
    SubgroupAvcMceGetDefaultInterMotionVectorCostTableINTEL               :: 5720;
    SubgroupAvcMceGetDefaultHighPenaltyCostTableINTEL                     :: 5721;
    SubgroupAvcMceGetDefaultMediumPenaltyCostTableINTEL                   :: 5722;
    SubgroupAvcMceGetDefaultLowPenaltyCostTableINTEL                      :: 5723;
    SubgroupAvcMceSetMotionVectorCostFunctionINTEL                        :: 5724;
    SubgroupAvcMceGetDefaultIntraLumaModePenaltyINTEL                     :: 5725;
    SubgroupAvcMceGetDefaultNonDcLumaIntraPenaltyINTEL                    :: 5726;
    SubgroupAvcMceGetDefaultIntraChromaModeBasePenaltyINTEL               :: 5727;
    SubgroupAvcMceSetAcOnlyHaarINTEL                                      :: 5728;
    SubgroupAvcMceSetSourceInterlacedFieldPolarityINTEL                   :: 5729;
    SubgroupAvcMceSetSingleReferenceInterlacedFieldPolarityINTEL          :: 5730;
    SubgroupAvcMceSetDualReferenceInterlacedFieldPolaritiesINTEL          :: 5731;
    SubgroupAvcMceConvertToImePayloadINTEL                                :: 5732;
    SubgroupAvcMceConvertToImeResultINTEL                                 :: 5733;
    SubgroupAvcMceConvertToRefPayloadINTEL                                :: 5734;
    SubgroupAvcMceConvertToRefResultINTEL                                 :: 5735;
    SubgroupAvcMceConvertToSicPayloadINTEL                                :: 5736;
    SubgroupAvcMceConvertToSicResultINTEL                                 :: 5737;
    SubgroupAvcMceGetMotionVectorsINTEL                                   :: 5738;
    SubgroupAvcMceGetInterDistortionsINTEL                                :: 5739;
    SubgroupAvcMceGetBestInterDistortionsINTEL                            :: 5740;
    SubgroupAvcMceGetInterMajorShapeINTEL                                 :: 5741;
    SubgroupAvcMceGetInterMinorShapeINTEL                                 :: 5742;
    SubgroupAvcMceGetInterDirectionsINTEL                                 :: 5743;
    SubgroupAvcMceGetInterMotionVectorCountINTEL                          :: 5744;
    SubgroupAvcMceGetInterReferenceIdsINTEL                               :: 5745;
    SubgroupAvcMceGetInterReferenceInterlacedFieldPolaritiesINTEL         :: 5746;
    SubgroupAvcImeInitializeINTEL                                         :: 5747;
    SubgroupAvcImeSetSingleReferenceINTEL                                 :: 5748;
    SubgroupAvcImeSetDualReferenceINTEL                                   :: 5749;
    SubgroupAvcImeRefWindowSizeINTEL                                      :: 5750;
    SubgroupAvcImeAdjustRefOffsetINTEL                                    :: 5751;
    SubgroupAvcImeConvertToMcePayloadINTEL                                :: 5752;
    SubgroupAvcImeSetMaxMotionVectorCountINTEL                            :: 5753;
    SubgroupAvcImeSetUnidirectionalMixDisableINTEL                        :: 5754;
    SubgroupAvcImeSetEarlySearchTerminationThresholdINTEL                 :: 5755;
    SubgroupAvcImeSetWeightedSadINTEL                                     :: 5756;
    SubgroupAvcImeEvaluateWithSingleReferenceINTEL                        :: 5757;
    SubgroupAvcImeEvaluateWithDualReferenceINTEL                          :: 5758;
    SubgroupAvcImeEvaluateWithSingleReferenceStreaminINTEL                :: 5759;
    SubgroupAvcImeEvaluateWithDualReferenceStreaminINTEL                  :: 5760;
    SubgroupAvcImeEvaluateWithSingleReferenceStreamoutINTEL               :: 5761;
    SubgroupAvcImeEvaluateWithDualReferenceStreamoutINTEL                 :: 5762;
    SubgroupAvcImeEvaluateWithSingleReferenceStreaminoutINTEL             :: 5763;
    SubgroupAvcImeEvaluateWithDualReferenceStreaminoutINTEL               :: 5764;
    SubgroupAvcImeConvertToMceResultINTEL                                 :: 5765;
    SubgroupAvcImeGetSingleReferenceStreaminINTEL                         :: 5766;
    SubgroupAvcImeGetDualReferenceStreaminINTEL                           :: 5767;
    SubgroupAvcImeStripSingleReferenceStreamoutINTEL                      :: 5768;
    SubgroupAvcImeStripDualReferenceStreamoutINTEL                        :: 5769;
    SubgroupAvcImeGetStreamoutSingleReferenceMajorShapeMotionVectorsINTEL :: 5770;
    SubgroupAvcImeGetStreamoutSingleReferenceMajorShapeDistortionsINTEL   :: 5771;
    SubgroupAvcImeGetStreamoutSingleReferenceMajorShapeReferenceIdsINTEL  :: 5772;
    SubgroupAvcImeGetStreamoutDualReferenceMajorShapeMotionVectorsINTEL   :: 5773;
    SubgroupAvcImeGetStreamoutDualReferenceMajorShapeDistortionsINTEL     :: 5774;
    SubgroupAvcImeGetStreamoutDualReferenceMajorShapeReferenceIdsINTEL    :: 5775;
    SubgroupAvcImeGetBorderReachedINTEL                                   :: 5776;
    SubgroupAvcImeGetTruncatedSearchIndicationINTEL                       :: 5777;
    SubgroupAvcImeGetUnidirectionalEarlySearchTerminationINTEL            :: 5778;
    SubgroupAvcImeGetWeightingPatternMinimumMotionVectorINTEL             :: 5779;
    SubgroupAvcImeGetWeightingPatternMinimumDistortionINTEL               :: 5780;
    SubgroupAvcFmeInitializeINTEL                                         :: 5781;
    SubgroupAvcBmeInitializeINTEL                                         :: 5782;
    SubgroupAvcRefConvertToMcePayloadINTEL                                :: 5783;
    SubgroupAvcRefSetBidirectionalMixDisableINTEL                         :: 5784;
    SubgroupAvcRefSetBilinearFilterEnableINTEL                            :: 5785;
    SubgroupAvcRefEvaluateWithSingleReferenceINTEL                        :: 5786;
    SubgroupAvcRefEvaluateWithDualReferenceINTEL                          :: 5787;
    SubgroupAvcRefEvaluateWithMultiReferenceINTEL                         :: 5788;
    SubgroupAvcRefEvaluateWithMultiReferenceInterlacedINTEL               :: 5789;
    SubgroupAvcRefConvertToMceResultINTEL                                 :: 5790;
    SubgroupAvcSicInitializeINTEL                                         :: 5791;
    SubgroupAvcSicConfigureSkcINTEL                                       :: 5792;
    SubgroupAvcSicConfigureIpeLumaINTEL                                   :: 5793;
    SubgroupAvcSicConfigureIpeLumaChromaINTEL                             :: 5794;
    SubgroupAvcSicGetMotionVectorMaskINTEL                                :: 5795;
    SubgroupAvcSicConvertToMcePayloadINTEL                                :: 5796;
    SubgroupAvcSicSetIntraLumaShapePenaltyINTEL                           :: 5797;
    SubgroupAvcSicSetIntraLumaModeCostFunctionINTEL                       :: 5798;
    SubgroupAvcSicSetIntraChromaModeCostFunctionINTEL                     :: 5799;
    SubgroupAvcSicSetBilinearFilterEnableINTEL                            :: 5800;
    SubgroupAvcSicSetSkcForwardTransformEnableINTEL                       :: 5801;
    SubgroupAvcSicSetBlockBasedRawSkipSadINTEL                            :: 5802;
    SubgroupAvcSicEvaluateIpeINTEL                                        :: 5803;
    SubgroupAvcSicEvaluateWithSingleReferenceINTEL                        :: 5804;
    SubgroupAvcSicEvaluateWithDualReferenceINTEL                          :: 5805;
    SubgroupAvcSicEvaluateWithMultiReferenceINTEL                         :: 5806;
    SubgroupAvcSicEvaluateWithMultiReferenceInterlacedINTEL               :: 5807;
    SubgroupAvcSicConvertToMceResultINTEL                                 :: 5808;
    SubgroupAvcSicGetIpeLumaShapeINTEL                                    :: 5809;
    SubgroupAvcSicGetBestIpeLumaDistortionINTEL                           :: 5810;
    SubgroupAvcSicGetBestIpeChromaDistortionINTEL                         :: 5811;
    SubgroupAvcSicGetPackedIpeLumaModesINTEL                              :: 5812;
    SubgroupAvcSicGetIpeChromaModeINTEL                                   :: 5813;
    SubgroupAvcSicGetPackedSkcLumaCountThresholdINTEL                     :: 5814;
    SubgroupAvcSicGetPackedSkcLumaSumThresholdINTEL                       :: 5815;
    SubgroupAvcSicGetInterRawSadsINTEL                                    :: 5816;
    VariableLengthArrayINTEL                                              :: 5818;
    SaveMemoryINTEL                                                       :: 5819;
    RestoreMemoryINTEL                                                    :: 5820;
    ArbitraryFloatSinCosPiINTEL                                           :: 5840;
    ArbitraryFloatCastINTEL                                               :: 5841;
    ArbitraryFloatCastFromIntINTEL                                        :: 5842;
    ArbitraryFloatCastToIntINTEL                                          :: 5843;
    ArbitraryFloatAddINTEL                                                :: 5846;
    ArbitraryFloatSubINTEL                                                :: 5847;
    ArbitraryFloatMulINTEL                                                :: 5848;
    ArbitraryFloatDivINTEL                                                :: 5849;
    ArbitraryFloatGTINTEL                                                 :: 5850;
    ArbitraryFloatGEINTEL                                                 :: 5851;
    ArbitraryFloatLTINTEL                                                 :: 5852;
    ArbitraryFloatLEINTEL                                                 :: 5853;
    ArbitraryFloatEQINTEL                                                 :: 5854;
    ArbitraryFloatRecipINTEL                                              :: 5855;
    ArbitraryFloatRSqrtINTEL                                              :: 5856;
    ArbitraryFloatCbrtINTEL                                               :: 5857;
    ArbitraryFloatHypotINTEL                                              :: 5858;
    ArbitraryFloatSqrtINTEL                                               :: 5859;
    ArbitraryFloatLogINTEL                                                :: 5860;
    ArbitraryFloatLog2INTEL                                               :: 5861;
    ArbitraryFloatLog10INTEL                                              :: 5862;
    ArbitraryFloatLog1pINTEL                                              :: 5863;
    ArbitraryFloatExpINTEL                                                :: 5864;
    ArbitraryFloatExp2INTEL                                               :: 5865;
    ArbitraryFloatExp10INTEL                                              :: 5866;
    ArbitraryFloatExpm1INTEL                                              :: 5867;
    ArbitraryFloatSinINTEL                                                :: 5868;
    ArbitraryFloatCosINTEL                                                :: 5869;
    ArbitraryFloatSinCosINTEL                                             :: 5870;
    ArbitraryFloatSinPiINTEL                                              :: 5871;
    ArbitraryFloatCosPiINTEL                                              :: 5872;
    ArbitraryFloatASinINTEL                                               :: 5873;
    ArbitraryFloatASinPiINTEL                                             :: 5874;
    ArbitraryFloatACosINTEL                                               :: 5875;
    ArbitraryFloatACosPiINTEL                                             :: 5876;
    ArbitraryFloatATanINTEL                                               :: 5877;
    ArbitraryFloatATanPiINTEL                                             :: 5878;
    ArbitraryFloatATan2INTEL                                              :: 5879;
    ArbitraryFloatPowINTEL                                                :: 5880;
    ArbitraryFloatPowRINTEL                                               :: 5881;
    ArbitraryFloatPowNINTEL                                               :: 5882;
    LoopControlINTEL                                                      :: 5887;
    AliasDomainDeclINTEL                                                  :: 5911;
    AliasScopeDeclINTEL                                                   :: 5912;
    AliasScopeListDeclINTEL                                               :: 5913;
    FixedSqrtINTEL                                                        :: 5923;
    FixedRecipINTEL                                                       :: 5924;
    FixedRsqrtINTEL                                                       :: 5925;
    FixedSinINTEL                                                         :: 5926;
    FixedCosINTEL                                                         :: 5927;
    FixedSinCosINTEL                                                      :: 5928;
    FixedSinPiINTEL                                                       :: 5929;
    FixedCosPiINTEL                                                       :: 5930;
    FixedSinCosPiINTEL                                                    :: 5931;
    FixedLogINTEL                                                         :: 5932;
    FixedExpINTEL                                                         :: 5933;
    PtrCastToCrossWorkgroupINTEL                                          :: 5934;
    CrossWorkgroupCastToPtrINTEL                                          :: 5938;
    ReadPipeBlockingINTEL                                                 :: 5946;
    WritePipeBlockingINTEL                                                :: 5947;
    FPGARegINTEL                                                          :: 5949;
    RayQueryGetRayTMinKHR                                                 :: 6016;
    RayQueryGetRayFlagsKHR                                                :: 6017;
    RayQueryGetIntersectionTKHR                                           :: 6018;
    RayQueryGetIntersectionInstanceCustomIndexKHR                         :: 6019;
    RayQueryGetIntersectionInstanceIdKHR                                  :: 6020;
    RayQueryGetIntersectionInstanceShaderBindingTableRecordOffsetKHR      :: 6021;
    RayQueryGetIntersectionGeometryIndexKHR                               :: 6022;
    RayQueryGetIntersectionPrimitiveIndexKHR                              :: 6023;
    RayQueryGetIntersectionBarycentricsKHR                                :: 6024;
    RayQueryGetIntersectionFrontFaceKHR                                   :: 6025;
    RayQueryGetIntersectionCandidateAABBOpaqueKHR                         :: 6026;
    RayQueryGetIntersectionObjectRayDirectionKHR                          :: 6027;
    RayQueryGetIntersectionObjectRayOriginKHR                             :: 6028;
    RayQueryGetWorldRayDirectionKHR                                       :: 6029;
    RayQueryGetWorldRayOriginKHR                                          :: 6030;
    RayQueryGetIntersectionObjectToWorldKHR                               :: 6031;
    RayQueryGetIntersectionWorldToObjectKHR                               :: 6032;
    AtomicFAddEXT                                                         :: 6035;
    TypeBufferSurfaceINTEL                                                :: 6086;
    TypeStructContinuedINTEL                                              :: 6090;
    ConstantCompositeContinuedINTEL                                       :: 6091;
    SpecConstantCompositeContinuedINTEL                                   :: 6092;
    CompositeConstructContinuedINTEL                                      :: 6096;
    ConvertFToBF16INTEL                                                   :: 6116;
    ConvertBF16ToFINTEL                                                   :: 6117;
    ControlBarrierArriveINTEL                                             :: 6142;
    ControlBarrierWaitINTEL                                               :: 6143;
    ArithmeticFenceEXT                                                    :: 6145;
    TaskSequenceCreateINTEL                                               :: 6163;
    TaskSequenceAsyncINTEL                                                :: 6164;
    TaskSequenceGetINTEL                                                  :: 6165;
    TaskSequenceReleaseINTEL                                              :: 6166;
    TypeTaskSequenceINTEL                                                 :: 6199;
    SubgroupBlockPrefetchINTEL                                            :: 6221;
    Subgroup2DBlockLoadINTEL                                              :: 6231;
    Subgroup2DBlockLoadTransformINTEL                                     :: 6232;
    Subgroup2DBlockLoadTransposeINTEL                                     :: 6233;
    Subgroup2DBlockPrefetchINTEL                                          :: 6234;
    Subgroup2DBlockStoreINTEL                                             :: 6235;
    SubgroupMatrixMultiplyAccumulateINTEL                                 :: 6237;
    BitwiseFunctionINTEL                                                  :: 6242;
    UntypedVariableLengthArrayINTEL                                       :: 6244;
    ConditionalExtensionINTEL                                             :: 6248;
    ConditionalEntryPointINTEL                                            :: 6249;
    ConditionalCapabilityINTEL                                            :: 6250;
    SpecConstantTargetINTEL                                               :: 6251;
    SpecConstantArchitectureINTEL                                         :: 6252;
    SpecConstantCapabilitiesINTEL                                         :: 6253;
    ConditionalCopyObjectINTEL                                            :: 6254;
    GroupIMulKHR                                                          :: 6401;
    GroupFMulKHR                                                          :: 6402;
    GroupBitwiseAndKHR                                                    :: 6403;
    GroupBitwiseOrKHR                                                     :: 6404;
    GroupBitwiseXorKHR                                                    :: 6405;
    GroupLogicalAndKHR                                                    :: 6406;
    GroupLogicalOrKHR                                                     :: 6407;
    GroupLogicalXorKHR                                                    :: 6408;
    RoundFToTF32INTEL                                                     :: 6426;
    MaskedGatherINTEL                                                     :: 6428;
    MaskedScatterINTEL                                                    :: 6429;
    ConvertHandleToImageINTEL                                             :: 6529;
    ConvertHandleToSamplerINTEL                                           :: 6530;
    ConvertHandleToSampledImageINTEL                                      :: 6531;
    Max                                                                   :: 2147483647;
}

SpvOp :: SpvOp_;

/*! @enum SpvReflectResult

*/
SpvReflectResult :: enum u32 {
    SUCCESS                                    :: 0;
    NOT_READY                                  :: 1;
    ERROR_PARSE_FAILED                         :: 2;
    ERROR_ALLOC_FAILED                         :: 3;
    ERROR_RANGE_EXCEEDED                       :: 4;
    ERROR_NULL_POINTER                         :: 5;
    ERROR_INTERNAL_ERROR                       :: 6;
    ERROR_COUNT_MISMATCH                       :: 7;
    ERROR_ELEMENT_NOT_FOUND                    :: 8;
    ERROR_SPIRV_INVALID_CODE_SIZE              :: 9;
    ERROR_SPIRV_INVALID_MAGIC_NUMBER           :: 10;
    ERROR_SPIRV_UNEXPECTED_EOF                 :: 11;
    ERROR_SPIRV_INVALID_ID_REFERENCE           :: 12;
    ERROR_SPIRV_SET_NUMBER_OVERFLOW            :: 13;
    ERROR_SPIRV_INVALID_STORAGE_CLASS          :: 14;
    ERROR_SPIRV_RECURSION                      :: 15;
    ERROR_SPIRV_INVALID_INSTRUCTION            :: 16;
    ERROR_SPIRV_UNEXPECTED_BLOCK_DATA          :: 17;
    ERROR_SPIRV_INVALID_BLOCK_MEMBER_REFERENCE :: 18;
    ERROR_SPIRV_INVALID_ENTRY_POINT            :: 19;
    ERROR_SPIRV_INVALID_EXECUTION_MODE         :: 20;
    ERROR_SPIRV_MAX_RECURSIVE_EXCEEDED         :: 21;
}

/*! @enum SpvReflectModuleFlagBits

SPV_REFLECT_MODULE_FLAG_NO_COPY - Disables copying of SPIR-V code
when a SPIRV-Reflect shader module is created. It is the
responsibility of the calling program to ensure that the pointer
remains valid and the memory it's pointing to is not freed while
SPIRV-Reflect operations are taking place. Freeing the backing
memory will cause undefined behavior or most likely a crash.
This is flag is intended for cases where the memory overhead of
storing the copied SPIR-V is undesirable.

*/
SpvReflectModuleFlagBits :: enum u32 {
    NONE    :: 0;
    NO_COPY :: 1;
}

SpvReflectModuleFlags :: u32;

/*! @enum SpvReflectTypeFlagBits

*/
SpvReflectTypeFlagBits :: enum u32 {
    UNDEFINED                       :: 0;
    VOID                            :: 1;
    BOOL                            :: 2;
    INT                             :: 4;
    FLOAT                           :: 8;
    VECTOR                          :: 256;
    MATRIX                          :: 512;
    EXTERNAL_IMAGE                  :: 65536;
    EXTERNAL_SAMPLER                :: 131072;
    EXTERNAL_SAMPLED_IMAGE          :: 262144;
    EXTERNAL_BLOCK                  :: 524288;
    EXTERNAL_ACCELERATION_STRUCTURE :: 1048576;
    EXTERNAL_MASK                   :: 16711680;
    STRUCT                          :: 268435456;
    ARRAY                           :: 536870912;
    REF                             :: 1073741824;
}

SpvReflectTypeFlags :: u32;

/*! @enum SpvReflectDecorationBits

NOTE: HLSL row_major and column_major decorations are reversed
in SPIR-V. Meaning that matrices declrations with row_major
will get reflected as column_major and vice versa. The
row and column decorations get appied during the compilation.
SPIRV-Reflect reads the data as is and does not make any
attempt to correct it to match what's in the source.

The Patch, PerVertex, and PerTask are used for Interface
variables that can have array

*/
SpvReflectDecorationFlagBits :: enum u32 {
    NONE                :: 0;
    BLOCK               :: 1;
    BUFFER_BLOCK        :: 2;
    ROW_MAJOR           :: 4;
    COLUMN_MAJOR        :: 8;
    BUILT_IN            :: 16;
    NOPERSPECTIVE       :: 32;
    FLAT                :: 64;
    NON_WRITABLE        :: 128;
    RELAXED_PRECISION   :: 256;
    NON_READABLE        :: 512;
    PATCH               :: 1024;
    PER_VERTEX          :: 2048;
    PER_TASK            :: 4096;
    WEIGHT_TEXTURE      :: 8192;
    BLOCK_MATCH_TEXTURE :: 16384;
}

SpvReflectDecorationFlags :: u32;

// Based of SPV_GOOGLE_user_type
SpvReflectUserType :: enum u32 {
    INVALID                                :: 0;
    CBUFFER                                :: 1;
    TBUFFER                                :: 2;
    APPEND_STRUCTURED_BUFFER               :: 3;
    BUFFER                                 :: 4;
    BYTE_ADDRESS_BUFFER                    :: 5;
    CONSTANT_BUFFER                        :: 6;
    CONSUME_STRUCTURED_BUFFER              :: 7;
    INPUT_PATCH                            :: 8;
    OUTPUT_PATCH                           :: 9;
    RASTERIZER_ORDERED_BUFFER              :: 10;
    RASTERIZER_ORDERED_BYTE_ADDRESS_BUFFER :: 11;
    RASTERIZER_ORDERED_STRUCTURED_BUFFER   :: 12;
    RASTERIZER_ORDERED_TEXTURE_1D          :: 13;
    RASTERIZER_ORDERED_TEXTURE_1D_ARRAY    :: 14;
    RASTERIZER_ORDERED_TEXTURE_2D          :: 15;
    RASTERIZER_ORDERED_TEXTURE_2D_ARRAY    :: 16;
    RASTERIZER_ORDERED_TEXTURE_3D          :: 17;
    RAYTRACING_ACCELERATION_STRUCTURE      :: 18;
    RW_BUFFER                              :: 19;
    RW_BYTE_ADDRESS_BUFFER                 :: 20;
    RW_STRUCTURED_BUFFER                   :: 21;
    RW_TEXTURE_1D                          :: 22;
    RW_TEXTURE_1D_ARRAY                    :: 23;
    RW_TEXTURE_2D                          :: 24;
    RW_TEXTURE_2D_ARRAY                    :: 25;
    RW_TEXTURE_3D                          :: 26;
    STRUCTURED_BUFFER                      :: 27;
    SUBPASS_INPUT                          :: 28;
    SUBPASS_INPUT_MS                       :: 29;
    TEXTURE_1D                             :: 30;
    TEXTURE_1D_ARRAY                       :: 31;
    TEXTURE_2D                             :: 32;
    TEXTURE_2D_ARRAY                       :: 33;
    TEXTURE_2DMS                           :: 34;
    TEXTURE_2DMS_ARRAY                     :: 35;
    TEXTURE_3D                             :: 36;
    TEXTURE_BUFFER                         :: 37;
    TEXTURE_CUBE                           :: 38;
    TEXTURE_CUBE_ARRAY                     :: 39;
}

/*! @enum SpvReflectResourceType

*/
SpvReflectResourceType :: enum u32 {
    UNDEFINED :: 0;
    SAMPLER   :: 1;
    CBV       :: 2;
    SRV       :: 4;
    UAV       :: 8;
}

/*! @enum SpvReflectFormat

*/
SpvReflectFormat :: enum u32 {
    UNDEFINED           :: 0;
    R16_UINT            :: 74;
    R16_SINT            :: 75;
    R16_SFLOAT          :: 76;
    R16G16_UINT         :: 81;
    R16G16_SINT         :: 82;
    R16G16_SFLOAT       :: 83;
    R16G16B16_UINT      :: 88;
    R16G16B16_SINT      :: 89;
    R16G16B16_SFLOAT    :: 90;
    R16G16B16A16_UINT   :: 95;
    R16G16B16A16_SINT   :: 96;
    R16G16B16A16_SFLOAT :: 97;
    R32_UINT            :: 98;
    R32_SINT            :: 99;
    R32_SFLOAT          :: 100;
    R32G32_UINT         :: 101;
    R32G32_SINT         :: 102;
    R32G32_SFLOAT       :: 103;
    R32G32B32_UINT      :: 104;
    R32G32B32_SINT      :: 105;
    R32G32B32_SFLOAT    :: 106;
    R32G32B32A32_UINT   :: 107;
    R32G32B32A32_SINT   :: 108;
    R32G32B32A32_SFLOAT :: 109;
    R64_UINT            :: 110;
    R64_SINT            :: 111;
    R64_SFLOAT          :: 112;
    R64G64_UINT         :: 113;
    R64G64_SINT         :: 114;
    R64G64_SFLOAT       :: 115;
    R64G64B64_UINT      :: 116;
    R64G64B64_SINT      :: 117;
    R64G64B64_SFLOAT    :: 118;
    R64G64B64A64_UINT   :: 119;
    R64G64B64A64_SINT   :: 120;
    R64G64B64A64_SFLOAT :: 121;
}

/*! @enum SpvReflectVariableFlagBits

*/
SpvReflectVariableFlagBits :: enum u32 {
    NONE                  :: 0;
    UNUSED                :: 1;

    PHYSICAL_POINTER_COPY :: 2;
}

SpvReflectVariableFlags :: u32;

/*! @enum SpvReflectDescriptorType

*/
SpvReflectDescriptorType :: enum u32 {
    SAMPLER                    :: 0;
    COMBINED_IMAGE_SAMPLER     :: 1;
    SAMPLED_IMAGE              :: 2;
    STORAGE_IMAGE              :: 3;
    UNIFORM_TEXEL_BUFFER       :: 4;
    STORAGE_TEXEL_BUFFER       :: 5;
    UNIFORM_BUFFER             :: 6;
    STORAGE_BUFFER             :: 7;
    UNIFORM_BUFFER_DYNAMIC     :: 8;
    STORAGE_BUFFER_DYNAMIC     :: 9;
    INPUT_ATTACHMENT           :: 10;
    ACCELERATION_STRUCTURE_KHR :: 1000150000;
}

/*! @enum SpvReflectShaderStageFlagBits

*/
SpvReflectShaderStageFlagBits :: enum u32 {
    VERTEX_BIT                  :: 1;
    TESSELLATION_CONTROL_BIT    :: 2;
    TESSELLATION_EVALUATION_BIT :: 4;
    GEOMETRY_BIT                :: 8;
    FRAGMENT_BIT                :: 16;
    COMPUTE_BIT                 :: 32;
    TASK_BIT_NV                 :: 64;
    TASK_BIT_EXT                :: 64;
    MESH_BIT_NV                 :: 128;
    MESH_BIT_EXT                :: 128;
    RAYGEN_BIT_KHR              :: 256;
    ANY_HIT_BIT_KHR             :: 512;
    CLOSEST_HIT_BIT_KHR         :: 1024;
    MISS_BIT_KHR                :: 2048;
    INTERSECTION_BIT_KHR        :: 4096;
    CALLABLE_BIT_KHR            :: 8192;
}

/*! @enum SpvReflectGenerator

*/
SpvReflectGenerator :: enum u32 {
    KHRONOS_LLVM_SPIRV_TRANSLATOR         :: 6;
    KHRONOS_SPIRV_TOOLS_ASSEMBLER         :: 7;
    KHRONOS_GLSLANG_REFERENCE_FRONT_END   :: 8;
    GOOGLE_SHADERC_OVER_GLSLANG           :: 13;
    GOOGLE_SPIREGG                        :: 14;
    GOOGLE_RSPIRV                         :: 15;
    X_LEGEND_MESA_MESAIR_SPIRV_TRANSLATOR :: 16;
    KHRONOS_SPIRV_TOOLS_LINKER            :: 17;
    WINE_VKD3D_SHADER_COMPILER            :: 18;
    CLAY_CLAY_SHADER_COMPILER             :: 19;
    SLANG_SHADER_COMPILER                 :: 40;
}

SPV_REFLECT_MAX :: enum u32 {
    ARRAY_DIMS      :: 32;
    DESCRIPTOR_SETS :: 64;
}

SPV_REFLECT :: enum s32 {
    BINDING_NUMBER_DONT_CHANGE :: -1;
    SET_NUMBER_DONT_CHANGE     :: -1;
}

SpvReflectNumericTraits :: struct {
    Scalar :: struct {
        width:      u32;
        signedness: u32;
    }

    scalar: Scalar;

    Vector :: struct {
        component_count: u32;
    }

    vector: Vector;

    Matrix :: struct {
        column_count: u32;
        row_count:    u32;
        stride:       u32; // Measured in bytes
    }

    matrix: Matrix;
}

SpvReflectImageTraits :: struct {
    dim:          SpvDim;
    depth:        u32;
    arrayed:      u32;
    ms:           u32; // 0: single-sampled; 1: multisampled
    sampled:      u32;
    image_format: SpvImageFormat;
}

SpvReflectArrayDimType :: enum u32 {
    SPV_REFLECT_ARRAY_DIM_RUNTIME :: 0;
}

SpvReflectArrayTraits :: struct {
    dims_count:           u32;

    // Each entry is either:
    // - specialization constant dimension
    // - OpTypeRuntimeArray
    // - the array length otherwise
    dims:                 [32] u32;

    // Stores Ids for dimensions that are specialization constants
    spec_constant_op_ids: [32] u32;
    stride:               u32; // Measured in bytes
}

SpvReflectBindingArrayTraits :: struct {
    dims_count: u32;
    dims:       [32] u32;
}

/*! @struct SpvReflectTypeDescription
@brief Information about an OpType* instruction
*/
SpvReflectTypeDescription :: struct {
    id:                      u32;
    op:                      SpvOp;
    type_name:               *u8;

    // Non-NULL if type is member of a struct
    struct_member_name:      *u8;

    // The storage class (SpvStorageClass) if the type, and -1 if it does not have a storage class.
    storage_class:           s32;
    type_flags:              SpvReflectTypeFlags;
    decoration_flags:        SpvReflectDecorationFlags;

    Traits :: struct {
        numeric: SpvReflectNumericTraits;
        image:   SpvReflectImageTraits;
        array:   SpvReflectArrayTraits;
    }

    traits:                  Traits;

    // If underlying type is a struct (ex. array of structs)
    // this gives access to the OpTypeStruct
    struct_type_description: *SpvReflectTypeDescription;

    // Some pointers to SpvReflectTypeDescription are really
    // just copies of another reference to the same OpType
    copied:                  u32;

    // @deprecated use struct_type_description instead
    member_count:            u32;

    // @deprecated use struct_type_description instead
    members:                 *SpvReflectTypeDescription;
}

/*! @struct SpvReflectInterfaceVariable
@brief The OpVariable that is either an Input or Output to the module
*/
SpvReflectInterfaceVariable :: struct {
    spirv_id:         u32;
    name:             *u8;
    location:         u32;
    component:        u32;
    storage_class:    SpvStorageClass;
    semantic:         *u8;
    decoration_flags: SpvReflectDecorationFlags;

    // The builtin id (SpvBuiltIn) if the variable is a builtin, and -1 otherwise.
    built_in:         s32;
    numeric:          SpvReflectNumericTraits;
    array:            SpvReflectArrayTraits;

    member_count:     u32;
    members:          *SpvReflectInterfaceVariable;

    format:           SpvReflectFormat;

    // NOTE: SPIR-V shares type references for variables
    //       that have the same underlying type. This means
    //       that the same type name will appear for multiple
    //       variables.
    type_description: *SpvReflectTypeDescription;

    word_offset:      struct {
        location: u32;
    };
}

/*! @struct SpvReflectBlockVariable

*/
SpvReflectBlockVariable :: struct {
    spirv_id:         u32;
    name:             *u8;

    offset:           u32; // Measured in bytes
    absolute_offset:  u32; // Measured in bytes
    size:             u32; // Measured in bytes
    padded_size:      u32; // Measured in bytes
    decoration_flags: SpvReflectDecorationFlags;
    numeric:          SpvReflectNumericTraits;
    array:            SpvReflectArrayTraits;
    flags:            SpvReflectVariableFlags;

    member_count:     u32;
    members:          *SpvReflectBlockVariable;

    type_description: *SpvReflectTypeDescription;

    word_offset:      struct {
        offset: u32;
    };
}

/*! @struct SpvReflectDescriptorBinding

*/
SpvReflectDescriptorBinding :: struct {
    spirv_id:                         u32;
    name:                             *u8;
    binding:                          u32;
    input_attachment_index:           u32;
    set:                              u32;
    descriptor_type:                  SpvReflectDescriptorType;
    resource_type:                    SpvReflectResourceType;
    image:                            SpvReflectImageTraits;
    block:                            SpvReflectBlockVariable;
    array:                            SpvReflectBindingArrayTraits;
    count:                            u32;
    accessed:                         u32;
    uav_counter_id:                   u32;
    uav_counter_binding:              *SpvReflectDescriptorBinding;
    byte_address_buffer_offset_count: u32;
    byte_address_buffer_offsets:      *u32;

    type_description:                 *SpvReflectTypeDescription;

    word_offset:                      struct {
        binding: u32;
        set:     u32;
    };

    decoration_flags:                 SpvReflectDecorationFlags;

    // Requires SPV_GOOGLE_user_type
    user_type:                        SpvReflectUserType;
}

/*! @struct SpvReflectDescriptorSet

*/
SpvReflectDescriptorSet :: struct {
    set:           u32;
    binding_count: u32;
    bindings:      **SpvReflectDescriptorBinding;
}

SpvReflectExecutionModeValue :: enum u32 {
    SPV_REFLECT_EXECUTION_MODE_SPEC_CONSTANT :: 4294967295;
}

/*! @struct SpvReflectEntryPoint

*/
SpvReflectEntryPoint :: struct {
    name:                     *u8;
    id:                       u32;

    spirv_execution_model:    SpvExecutionModel;
    shader_stage:             SpvReflectShaderStageFlagBits;

    input_variable_count:     u32;
    input_variables:          **SpvReflectInterfaceVariable;
    output_variable_count:    u32;
    output_variables:         **SpvReflectInterfaceVariable;
    interface_variable_count: u32;
    interface_variables:      *SpvReflectInterfaceVariable;

    descriptor_set_count:     u32;
    descriptor_sets:          *SpvReflectDescriptorSet;

    used_uniform_count:       u32;
    used_uniforms:            *u32;
    used_push_constant_count: u32;
    used_push_constants:      *u32;

    execution_mode_count:     u32;
    execution_modes:          *SpvExecutionMode;

    LocalSize :: struct {
        x: u32;
        y: u32;
        z: u32;
    }

    local_size:               LocalSize;
    invocations:              u32; // valid for geometry
    output_vertices:          u32; // valid for geometry, tesselation
}

/*! @struct SpvReflectCapability

*/
SpvReflectCapability :: struct {
    value:       SpvCapability;
    word_offset: u32;
}

/*! @struct SpvReflectSpecId

*/
SpvReflectSpecializationConstant :: struct {
    spirv_id:           u32;
    constant_id:        u32;
    name:               *u8;
    type_description:   *SpvReflectTypeDescription;

    // Size of the default value in bytes (always a multiple of 4).
    // Will be 4 for 8/16/32-bit constants and 8 for 64-bit constants.
    default_value_size: u32;

    // Pointer to the raw default value data.
    // The interpretation of this data depends on type_description->op:
    // - SpvOpSpecConstantTrue:  size = 4, data = uint32_t(1)
    // - SpvOpSpecConstantFalse: size = 4, data = uint32_t(0)
    // - SpvOpSpecConstant:      data contains the bit pattern of the default value
    //   * The type will be a scalar integer or float.
    //   * Types 32 bits wide or smaller take one word.
    //   * Larger types take multiple words, with low-order words appearing first.
    default_value:      *void;
}

/*! @struct SpvReflectShaderModule

*/
SpvReflectShaderModule :: struct {
    generator:                 SpvReflectGenerator;
    entry_point_name:          *u8;
    entry_point_id:            u32;
    entry_point_count:         u32;
    entry_points:              *SpvReflectEntryPoint;
    source_language:           SpvSourceLanguage;
    source_language_version:   u32;
    source_file:               *u8;
    source_source:             *u8;
    capability_count:          u32;
    capabilities:              *SpvReflectCapability;
    spirv_execution_model:     SpvExecutionModel; // Uses value(s) from first entry point
    shader_stage:              SpvReflectShaderStageFlagBits; // Uses value(s) from first entry point
    descriptor_binding_count:  u32; // Uses value(s) from first entry point
    descriptor_bindings:       *SpvReflectDescriptorBinding; // Uses value(s) from first entry point
    descriptor_set_count:      u32; // Uses value(s) from first entry point
    descriptor_sets:           [64] SpvReflectDescriptorSet; // Uses value(s) from first entry point
    input_variable_count:      u32; // Uses value(s) from first entry point
    input_variables:           **SpvReflectInterfaceVariable; // Uses value(s) from first entry point
    output_variable_count:     u32; // Uses value(s) from first entry point
    output_variables:          **SpvReflectInterfaceVariable; // Uses value(s) from first entry point
    interface_variable_count:  u32; // Uses value(s) from first entry point
    interface_variables:       *SpvReflectInterfaceVariable; // Uses value(s) from first entry point
    push_constant_block_count: u32; // Uses value(s) from first entry point
    push_constant_blocks:      *SpvReflectBlockVariable; // Uses value(s) from first entry point
    spec_constant_count:       u32; // Uses value(s) from first entry point
    spec_constants:            *SpvReflectSpecializationConstant; // Uses value(s) from first entry point

    Internal :: struct {
        module_flags:           SpvReflectModuleFlags;
        spirv_size:             u64;
        spirv_code:             *u32;
        spirv_word_count:       u32;

        type_description_count: u64;
        type_descriptions:      *SpvReflectTypeDescription;
    }

    _internal:                 *Internal;
}

/*! @fn spvReflectCreateShaderModule2

@param  flags     Flags for module creations.
@param  size      Size in bytes of SPIR-V code.
@param  p_code    Pointer to SPIR-V code.
@param  p_module  Pointer to an instance of SpvReflectShaderModule.
@return           SPV_REFLECT_RESULT_SUCCESS on success.

*/
spvReflectCreateShaderModule2 :: (flags: SpvReflectModuleFlags, size: u64, p_code: *void, p_module: *SpvReflectShaderModule) -> SpvReflectResult #foreign libspirv_reflect;

/*! @fn spvReflectDestroyShaderModule

@param  p_module  Pointer to an instance of SpvReflectShaderModule.

*/
spvReflectDestroyShaderModule :: (p_module: *SpvReflectShaderModule) -> void #foreign libspirv_reflect;

/*! @fn spvReflectEnumerateDescriptorSets

@param  p_module  Pointer to an instance of SpvReflectShaderModule.
@param  p_count   If pp_sets is NULL, the module's descriptor set
count will be stored here.
If pp_sets is not NULL, *p_count must contain the
module's descriptor set count.
@param  pp_sets   If NULL, the module's total descriptor set count
will be written to *p_count.
If non-NULL, pp_sets must point to an array with
*p_count entries, where pointers to the module's
descriptor sets will be written. The caller must not
free the descriptor set pointers written to this array.
@return           If successful, returns SPV_REFLECT_RESULT_SUCCESS.
Otherwise, the error code indicates the cause of the
failure.

*/
spvReflectEnumerateDescriptorSets :: (p_module: *SpvReflectShaderModule, p_count: *u32, pp_sets: **SpvReflectDescriptorSet) -> SpvReflectResult #foreign libspirv_reflect;

/*! @fn spvReflectEnumeratePushConstantBlocks
@brief  Note: If the module contains multiple entry points, this will only get
the push constant blocks for the first one.
@param  p_module   Pointer to an instance of SpvReflectShaderModule.
@param  p_count    If pp_blocks is NULL, the module's push constant
block count will be stored here.
If pp_blocks is not NULL, *p_count must
contain the module's push constant block count.
@param  pp_blocks  If NULL, the module's push constant block count
will be written to *p_count.
If non-NULL, pp_blocks must point to an
array with *p_count entries, where pointers to
the module's push constant blocks will be written.
The caller must not free the block variables written
to this array.
@return            If successful, returns SPV_REFLECT_RESULT_SUCCESS.
Otherwise, the error code indicates the cause of the
failure.

*/
spvReflectEnumeratePushConstantBlocks :: (p_module: *SpvReflectShaderModule, p_count: *u32, pp_blocks: **SpvReflectBlockVariable) -> SpvReflectResult #foreign libspirv_reflect;

// clang-format off
SPIRV :: enum u32 {
    STARTING_WORD_INDEX           :: 5;
    WORD_SIZE                     :: 4;
    BYTE_WIDTH                    :: 8;
    MINIMUM_FILE_SIZE             :: 20;
    DATA_ALIGNMENT                :: 16;
    ACCESS_CHAIN_INDEX_OFFSET     :: 4;
    PHYSICAL_STORAGE_POINTER_SIZE :: 8;
}

anon_enum :: enum u32 {
    INVALID_VALUE :: 4294967295;
}

MAX :: enum u32 {
    NODE_NAME_LENGTH                 :: 1024;

    RECURSIVE_PHYSICAL_POINTER_CHECK :: 128;
}

IMAGE :: enum u32 {
    SAMPLED :: 1;
    STORAGE :: 2;
}

SpvReflectPrvArrayTraits :: struct {
    element_type_id: u32;
    length_id:       u32;
}

SpvReflectPrvImageTraits :: struct {
    sampled_type_id: u32;
    dim:             SpvDim;
    depth:           u32;
    arrayed:         u32;
    ms:              u32;
    sampled:         u32;
    image_format:    SpvImageFormat;
}

SpvReflectPrvNumberDecoration :: struct {
    word_offset: u32;
    value:       u32;
}

SpvReflectPrvStringDecoration :: struct {
    word_offset: u32;
    value:       *u8;
}

SpvReflectPrvDecorations :: struct {
    is_relaxed_precision:   bool;
    is_block:               bool;
    is_buffer_block:        bool;
    is_row_major:           bool;
    is_column_major:        bool;
    is_built_in:            bool;
    is_noperspective:       bool;
    is_flat:                bool;
    is_non_writable:        bool;
    is_non_readable:        bool;
    is_patch:               bool;
    is_per_vertex:          bool;
    is_per_task:            bool;
    is_weight_texture:      bool;
    is_block_match_texture: bool;
    user_type:              SpvReflectUserType;
    set:                    SpvReflectPrvNumberDecoration;
    binding:                SpvReflectPrvNumberDecoration;
    input_attachment_index: SpvReflectPrvNumberDecoration;
    location:               SpvReflectPrvNumberDecoration;
    component:              SpvReflectPrvNumberDecoration;
    offset:                 SpvReflectPrvNumberDecoration;
    uav_counter_buffer:     SpvReflectPrvNumberDecoration;
    semantic:               SpvReflectPrvStringDecoration;
    array_stride:           u32;
    matrix_stride:          u32;
    spec_id:                u32;
    built_in:               SpvBuiltIn;
}

SpvReflectPrvNode :: struct {
    result_id:          u32;
    op:                 SpvOp;
    result_type_id:     u32;
    type_id:            u32;
    capability:         SpvCapability;
    storage_class:      SpvStorageClass;
    word_offset:        u32;
    word_count:         u32;
    is_type:            bool;

    array_traits:       SpvReflectPrvArrayTraits;
    image_traits:       SpvReflectPrvImageTraits;
    image_type_id:      u32;

    name:               *u8;
    decorations:        SpvReflectPrvDecorations;
    member_count:       u32;
    member_names:       **u8;
    member_decorations: *SpvReflectPrvDecorations;
}

SpvReflectPrvString :: struct {
    result_id: u32;
    _string:   *u8;
}

// There are a limit set of instructions that can touch an OpVariable,
// these are represented here with how it was accessed
// Examples:
//    OpImageRead  -> OpLoad -> OpVariable
//    OpImageWrite -> OpLoad -> OpVariable
//    OpStore      -> OpAccessChain -> OpAccessChain -> OpVariable
//    OpAtomicIAdd -> OpAccessChain -> OpVariable
//    OpAtomicLoad -> OpImageTexelPointer -> OpVariable
SpvReflectPrvAccessedVariable :: struct {
    p_node:                   *SpvReflectPrvNode;
    result_id:                u32;
    variable_ptr:             u32;
    function_id:              u32;
    function_parameter_index: u32;
}

SpvReflectPrvFunction :: struct {
    id:                      u32;
    parameter_count:         u32;
    parameters:              *u32;
    callee_count:            u32;
    callees:                 *u32;
    callee_ptrs:             **SpvReflectPrvFunction;
    accessed_variable_count: u32;
    accessed_variables:      *SpvReflectPrvAccessedVariable;
}

SpvReflectPrvAccessChain :: struct {
    result_id:      u32;
    result_type_id: u32;

    //
    // Pointing to the base of a composite object.
    // Generally the id of descriptor block variable
    base_id:        u32;

    //
    // From spec:
    //   The first index in Indexes will select the
    //   top-level member/element/component/element
    //   of the base composite
    index_count:    u32;
    indexes:        *u32;

    //
    // Block variable ac is pointing to (for block references)
    block_var:      *SpvReflectBlockVariable;
}

// To prevent infinite recursion, we never walk down a
// PhysicalStorageBuffer struct twice, but incase a 2nd variable
// needs to use that struct, save a copy
SpvReflectPrvPhysicalPointerStruct :: struct {
    struct_id: u32;

    // first variable to see the PhysicalStorageBuffer struct
    p_var:     *SpvReflectBlockVariable;
}

SpvReflectPrvParser :: struct {
    spirv_word_count:              u64;
    spirv_code:                    *u32;
    string_count:                  u32;
    strings:                       *SpvReflectPrvString;
    source_language:               SpvSourceLanguage;
    source_language_version:       u32;
    source_file_id:                u32;
    source_embedded:               *u8;
    node_count:                    u64;
    nodes:                         *SpvReflectPrvNode;
    entry_point_count:             u32;
    capability_count:              u32;
    function_count:                u32;
    functions:                     *SpvReflectPrvFunction;
    access_chain_count:            u32;
    access_chains:                 *SpvReflectPrvAccessChain;

    type_count:                    u32;
    descriptor_count:              u32;
    push_constant_count:           u32;
    spec_constant_count:           u32;

    physical_pointer_check:        [128] *SpvReflectTypeDescription;
    physical_pointer_count:        u32;

    physical_pointer_structs:      *SpvReflectPrvPhysicalPointerStruct;
    physical_pointer_struct_count: u32;
}

IsPointerToPointer :: (p_parser: *SpvReflectPrvParser, type_id: u32) -> bool #foreign libspirv_reflect;

#scope_file

#import "Basic"; // For assert


#run {
    {
        info := type_info(SpvReflectNumericTraits.Scalar);
        for info.members {
            if it.name == {
                case "width";
                    assert(it.offset_in_bytes == 0, "SpvReflectNumericTraits.Scalar.width has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectNumericTraits.Scalar.width has unexpected size % instead of 4", it.type.runtime_size);
                case "signedness";
                    assert(it.offset_in_bytes == 4, "SpvReflectNumericTraits.Scalar.signedness has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectNumericTraits.Scalar.signedness has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectNumericTraits.Scalar) == 8, "SpvReflectNumericTraits.Scalar has size % instead of 8", size_of(SpvReflectNumericTraits.Scalar));
    }

    {
        info := type_info(SpvReflectNumericTraits.Vector);
        for info.members {
            if it.name == {
                case "component_count";
                    assert(it.offset_in_bytes == 0, "SpvReflectNumericTraits.Vector.component_count has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectNumericTraits.Vector.component_count has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectNumericTraits.Vector) == 4, "SpvReflectNumericTraits.Vector has size % instead of 4", size_of(SpvReflectNumericTraits.Vector));
    }

    {
        info := type_info(SpvReflectNumericTraits.Matrix);
        for info.members {
            if it.name == {
                case "column_count";
                    assert(it.offset_in_bytes == 0, "SpvReflectNumericTraits.Matrix.column_count has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectNumericTraits.Matrix.column_count has unexpected size % instead of 4", it.type.runtime_size);
                case "row_count";
                    assert(it.offset_in_bytes == 4, "SpvReflectNumericTraits.Matrix.row_count has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectNumericTraits.Matrix.row_count has unexpected size % instead of 4", it.type.runtime_size);
                case "stride";
                    assert(it.offset_in_bytes == 8, "SpvReflectNumericTraits.Matrix.stride has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectNumericTraits.Matrix.stride has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectNumericTraits.Matrix) == 12, "SpvReflectNumericTraits.Matrix has size % instead of 12", size_of(SpvReflectNumericTraits.Matrix));
    }

    {
        info := type_info(SpvReflectNumericTraits);
        for info.members {
            if it.name == {
                case "scalar";
                    assert(it.offset_in_bytes == 0, "SpvReflectNumericTraits.scalar has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectNumericTraits.scalar has unexpected size % instead of 8", it.type.runtime_size);
                case "vector";
                    assert(it.offset_in_bytes == 8, "SpvReflectNumericTraits.vector has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectNumericTraits.vector has unexpected size % instead of 4", it.type.runtime_size);
                case "matrix";
                    assert(it.offset_in_bytes == 12, "SpvReflectNumericTraits.matrix has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "SpvReflectNumericTraits.matrix has unexpected size % instead of 12", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectNumericTraits) == 24, "SpvReflectNumericTraits has size % instead of 24", size_of(SpvReflectNumericTraits));
    }

    {
        info := type_info(SpvReflectImageTraits);
        for info.members {
            if it.name == {
                case "dim";
                    assert(it.offset_in_bytes == 0, "SpvReflectImageTraits.dim has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectImageTraits.dim has unexpected size % instead of 4", it.type.runtime_size);
                case "depth";
                    assert(it.offset_in_bytes == 4, "SpvReflectImageTraits.depth has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectImageTraits.depth has unexpected size % instead of 4", it.type.runtime_size);
                case "arrayed";
                    assert(it.offset_in_bytes == 8, "SpvReflectImageTraits.arrayed has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectImageTraits.arrayed has unexpected size % instead of 4", it.type.runtime_size);
                case "ms";
                    assert(it.offset_in_bytes == 12, "SpvReflectImageTraits.ms has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectImageTraits.ms has unexpected size % instead of 4", it.type.runtime_size);
                case "sampled";
                    assert(it.offset_in_bytes == 16, "SpvReflectImageTraits.sampled has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectImageTraits.sampled has unexpected size % instead of 4", it.type.runtime_size);
                case "image_format";
                    assert(it.offset_in_bytes == 20, "SpvReflectImageTraits.image_format has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectImageTraits.image_format has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectImageTraits) == 24, "SpvReflectImageTraits has size % instead of 24", size_of(SpvReflectImageTraits));
    }

    {
        info := type_info(SpvReflectArrayTraits);
        for info.members {
            if it.name == {
                case "dims_count";
                    assert(it.offset_in_bytes == 0, "SpvReflectArrayTraits.dims_count has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectArrayTraits.dims_count has unexpected size % instead of 4", it.type.runtime_size);
                case "dims";
                    assert(it.offset_in_bytes == 4, "SpvReflectArrayTraits.dims has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 128, "SpvReflectArrayTraits.dims has unexpected size % instead of 128", it.type.runtime_size);
                case "spec_constant_op_ids";
                    assert(it.offset_in_bytes == 132, "SpvReflectArrayTraits.spec_constant_op_ids has unexpected offset % instead of 132", it.offset_in_bytes);
                    assert(it.type.runtime_size == 128, "SpvReflectArrayTraits.spec_constant_op_ids has unexpected size % instead of 128", it.type.runtime_size);
                case "stride";
                    assert(it.offset_in_bytes == 260, "SpvReflectArrayTraits.stride has unexpected offset % instead of 260", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectArrayTraits.stride has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectArrayTraits) == 264, "SpvReflectArrayTraits has size % instead of 264", size_of(SpvReflectArrayTraits));
    }

    {
        info := type_info(SpvReflectBindingArrayTraits);
        for info.members {
            if it.name == {
                case "dims_count";
                    assert(it.offset_in_bytes == 0, "SpvReflectBindingArrayTraits.dims_count has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectBindingArrayTraits.dims_count has unexpected size % instead of 4", it.type.runtime_size);
                case "dims";
                    assert(it.offset_in_bytes == 4, "SpvReflectBindingArrayTraits.dims has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 128, "SpvReflectBindingArrayTraits.dims has unexpected size % instead of 128", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectBindingArrayTraits) == 132, "SpvReflectBindingArrayTraits has size % instead of 132", size_of(SpvReflectBindingArrayTraits));
    }

    {
        info := type_info(SpvReflectTypeDescription.Traits);
        for info.members {
            if it.name == {
                case "numeric";
                    assert(it.offset_in_bytes == 0, "SpvReflectTypeDescription.Traits.numeric has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "SpvReflectTypeDescription.Traits.numeric has unexpected size % instead of 24", it.type.runtime_size);
                case "image";
                    assert(it.offset_in_bytes == 24, "SpvReflectTypeDescription.Traits.image has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "SpvReflectTypeDescription.Traits.image has unexpected size % instead of 24", it.type.runtime_size);
                case "array";
                    assert(it.offset_in_bytes == 48, "SpvReflectTypeDescription.Traits.array has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 264, "SpvReflectTypeDescription.Traits.array has unexpected size % instead of 264", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectTypeDescription.Traits) == 312, "SpvReflectTypeDescription.Traits has size % instead of 312", size_of(SpvReflectTypeDescription.Traits));
    }

    {
        info := type_info(SpvReflectTypeDescription);
        for info.members {
            if it.name == {
                case "id";
                    assert(it.offset_in_bytes == 0, "SpvReflectTypeDescription.id has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectTypeDescription.id has unexpected size % instead of 4", it.type.runtime_size);
                case "op";
                    assert(it.offset_in_bytes == 4, "SpvReflectTypeDescription.op has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectTypeDescription.op has unexpected size % instead of 4", it.type.runtime_size);
                case "type_name";
                    assert(it.offset_in_bytes == 8, "SpvReflectTypeDescription.type_name has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectTypeDescription.type_name has unexpected size % instead of 8", it.type.runtime_size);
                case "struct_member_name";
                    assert(it.offset_in_bytes == 16, "SpvReflectTypeDescription.struct_member_name has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectTypeDescription.struct_member_name has unexpected size % instead of 8", it.type.runtime_size);
                case "storage_class";
                    assert(it.offset_in_bytes == 24, "SpvReflectTypeDescription.storage_class has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectTypeDescription.storage_class has unexpected size % instead of 4", it.type.runtime_size);
                case "type_flags";
                    assert(it.offset_in_bytes == 28, "SpvReflectTypeDescription.type_flags has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectTypeDescription.type_flags has unexpected size % instead of 4", it.type.runtime_size);
                case "decoration_flags";
                    assert(it.offset_in_bytes == 32, "SpvReflectTypeDescription.decoration_flags has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectTypeDescription.decoration_flags has unexpected size % instead of 4", it.type.runtime_size);
                case "traits";
                    assert(it.offset_in_bytes == 36, "SpvReflectTypeDescription.traits has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 312, "SpvReflectTypeDescription.traits has unexpected size % instead of 312", it.type.runtime_size);
                case "struct_type_description";
                    assert(it.offset_in_bytes == 352, "SpvReflectTypeDescription.struct_type_description has unexpected offset % instead of 352", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectTypeDescription.struct_type_description has unexpected size % instead of 8", it.type.runtime_size);
                case "copied";
                    assert(it.offset_in_bytes == 360, "SpvReflectTypeDescription.copied has unexpected offset % instead of 360", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectTypeDescription.copied has unexpected size % instead of 4", it.type.runtime_size);
                case "member_count";
                    assert(it.offset_in_bytes == 364, "SpvReflectTypeDescription.member_count has unexpected offset % instead of 364", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectTypeDescription.member_count has unexpected size % instead of 4", it.type.runtime_size);
                case "members";
                    assert(it.offset_in_bytes == 368, "SpvReflectTypeDescription.members has unexpected offset % instead of 368", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectTypeDescription.members has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectTypeDescription) == 376, "SpvReflectTypeDescription has size % instead of 376", size_of(SpvReflectTypeDescription));
    }

    {
        info := type_info(SpvReflectInterfaceVariable);
        for info.members {
            if it.name == {
                case "spirv_id";
                    assert(it.offset_in_bytes == 0, "SpvReflectInterfaceVariable.spirv_id has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectInterfaceVariable.spirv_id has unexpected size % instead of 4", it.type.runtime_size);
                case "name";
                    assert(it.offset_in_bytes == 8, "SpvReflectInterfaceVariable.name has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectInterfaceVariable.name has unexpected size % instead of 8", it.type.runtime_size);
                case "location";
                    assert(it.offset_in_bytes == 16, "SpvReflectInterfaceVariable.location has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectInterfaceVariable.location has unexpected size % instead of 4", it.type.runtime_size);
                case "component";
                    assert(it.offset_in_bytes == 20, "SpvReflectInterfaceVariable.component has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectInterfaceVariable.component has unexpected size % instead of 4", it.type.runtime_size);
                case "storage_class";
                    assert(it.offset_in_bytes == 24, "SpvReflectInterfaceVariable.storage_class has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectInterfaceVariable.storage_class has unexpected size % instead of 4", it.type.runtime_size);
                case "semantic";
                    assert(it.offset_in_bytes == 32, "SpvReflectInterfaceVariable.semantic has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectInterfaceVariable.semantic has unexpected size % instead of 8", it.type.runtime_size);
                case "decoration_flags";
                    assert(it.offset_in_bytes == 40, "SpvReflectInterfaceVariable.decoration_flags has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectInterfaceVariable.decoration_flags has unexpected size % instead of 4", it.type.runtime_size);
                case "built_in";
                    assert(it.offset_in_bytes == 44, "SpvReflectInterfaceVariable.built_in has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectInterfaceVariable.built_in has unexpected size % instead of 4", it.type.runtime_size);
                case "numeric";
                    assert(it.offset_in_bytes == 48, "SpvReflectInterfaceVariable.numeric has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "SpvReflectInterfaceVariable.numeric has unexpected size % instead of 24", it.type.runtime_size);
                case "array";
                    assert(it.offset_in_bytes == 72, "SpvReflectInterfaceVariable.array has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 264, "SpvReflectInterfaceVariable.array has unexpected size % instead of 264", it.type.runtime_size);
                case "member_count";
                    assert(it.offset_in_bytes == 336, "SpvReflectInterfaceVariable.member_count has unexpected offset % instead of 336", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectInterfaceVariable.member_count has unexpected size % instead of 4", it.type.runtime_size);
                case "members";
                    assert(it.offset_in_bytes == 344, "SpvReflectInterfaceVariable.members has unexpected offset % instead of 344", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectInterfaceVariable.members has unexpected size % instead of 8", it.type.runtime_size);
                case "format";
                    assert(it.offset_in_bytes == 352, "SpvReflectInterfaceVariable.format has unexpected offset % instead of 352", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectInterfaceVariable.format has unexpected size % instead of 4", it.type.runtime_size);
                case "type_description";
                    assert(it.offset_in_bytes == 360, "SpvReflectInterfaceVariable.type_description has unexpected offset % instead of 360", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectInterfaceVariable.type_description has unexpected size % instead of 8", it.type.runtime_size);
                case "word_offset";
                    assert(it.offset_in_bytes == 368, "SpvReflectInterfaceVariable.word_offset has unexpected offset % instead of 368", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectInterfaceVariable.word_offset has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectInterfaceVariable) == 376, "SpvReflectInterfaceVariable has size % instead of 376", size_of(SpvReflectInterfaceVariable));
    }

    {
        info := type_info(SpvReflectBlockVariable);
        for info.members {
            if it.name == {
                case "spirv_id";
                    assert(it.offset_in_bytes == 0, "SpvReflectBlockVariable.spirv_id has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectBlockVariable.spirv_id has unexpected size % instead of 4", it.type.runtime_size);
                case "name";
                    assert(it.offset_in_bytes == 8, "SpvReflectBlockVariable.name has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectBlockVariable.name has unexpected size % instead of 8", it.type.runtime_size);
                case "offset";
                    assert(it.offset_in_bytes == 16, "SpvReflectBlockVariable.offset has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectBlockVariable.offset has unexpected size % instead of 4", it.type.runtime_size);
                case "absolute_offset";
                    assert(it.offset_in_bytes == 20, "SpvReflectBlockVariable.absolute_offset has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectBlockVariable.absolute_offset has unexpected size % instead of 4", it.type.runtime_size);
                case "size";
                    assert(it.offset_in_bytes == 24, "SpvReflectBlockVariable.size has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectBlockVariable.size has unexpected size % instead of 4", it.type.runtime_size);
                case "padded_size";
                    assert(it.offset_in_bytes == 28, "SpvReflectBlockVariable.padded_size has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectBlockVariable.padded_size has unexpected size % instead of 4", it.type.runtime_size);
                case "decoration_flags";
                    assert(it.offset_in_bytes == 32, "SpvReflectBlockVariable.decoration_flags has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectBlockVariable.decoration_flags has unexpected size % instead of 4", it.type.runtime_size);
                case "numeric";
                    assert(it.offset_in_bytes == 36, "SpvReflectBlockVariable.numeric has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "SpvReflectBlockVariable.numeric has unexpected size % instead of 24", it.type.runtime_size);
                case "array";
                    assert(it.offset_in_bytes == 60, "SpvReflectBlockVariable.array has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 264, "SpvReflectBlockVariable.array has unexpected size % instead of 264", it.type.runtime_size);
                case "flags";
                    assert(it.offset_in_bytes == 324, "SpvReflectBlockVariable.flags has unexpected offset % instead of 324", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectBlockVariable.flags has unexpected size % instead of 4", it.type.runtime_size);
                case "member_count";
                    assert(it.offset_in_bytes == 328, "SpvReflectBlockVariable.member_count has unexpected offset % instead of 328", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectBlockVariable.member_count has unexpected size % instead of 4", it.type.runtime_size);
                case "members";
                    assert(it.offset_in_bytes == 336, "SpvReflectBlockVariable.members has unexpected offset % instead of 336", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectBlockVariable.members has unexpected size % instead of 8", it.type.runtime_size);
                case "type_description";
                    assert(it.offset_in_bytes == 344, "SpvReflectBlockVariable.type_description has unexpected offset % instead of 344", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectBlockVariable.type_description has unexpected size % instead of 8", it.type.runtime_size);
                case "word_offset";
                    assert(it.offset_in_bytes == 352, "SpvReflectBlockVariable.word_offset has unexpected offset % instead of 352", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectBlockVariable.word_offset has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectBlockVariable) == 360, "SpvReflectBlockVariable has size % instead of 360", size_of(SpvReflectBlockVariable));
    }

    {
        info := type_info(SpvReflectDescriptorBinding);
        for info.members {
            if it.name == {
                case "spirv_id";
                    assert(it.offset_in_bytes == 0, "SpvReflectDescriptorBinding.spirv_id has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectDescriptorBinding.spirv_id has unexpected size % instead of 4", it.type.runtime_size);
                case "name";
                    assert(it.offset_in_bytes == 8, "SpvReflectDescriptorBinding.name has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectDescriptorBinding.name has unexpected size % instead of 8", it.type.runtime_size);
                case "binding";
                    assert(it.offset_in_bytes == 16, "SpvReflectDescriptorBinding.binding has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectDescriptorBinding.binding has unexpected size % instead of 4", it.type.runtime_size);
                case "input_attachment_index";
                    assert(it.offset_in_bytes == 20, "SpvReflectDescriptorBinding.input_attachment_index has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectDescriptorBinding.input_attachment_index has unexpected size % instead of 4", it.type.runtime_size);
                case "set";
                    assert(it.offset_in_bytes == 24, "SpvReflectDescriptorBinding.set has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectDescriptorBinding.set has unexpected size % instead of 4", it.type.runtime_size);
                case "descriptor_type";
                    assert(it.offset_in_bytes == 28, "SpvReflectDescriptorBinding.descriptor_type has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectDescriptorBinding.descriptor_type has unexpected size % instead of 4", it.type.runtime_size);
                case "resource_type";
                    assert(it.offset_in_bytes == 32, "SpvReflectDescriptorBinding.resource_type has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectDescriptorBinding.resource_type has unexpected size % instead of 4", it.type.runtime_size);
                case "image";
                    assert(it.offset_in_bytes == 36, "SpvReflectDescriptorBinding.image has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "SpvReflectDescriptorBinding.image has unexpected size % instead of 24", it.type.runtime_size);
                case "block";
                    assert(it.offset_in_bytes == 64, "SpvReflectDescriptorBinding.block has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 360, "SpvReflectDescriptorBinding.block has unexpected size % instead of 360", it.type.runtime_size);
                case "array";
                    assert(it.offset_in_bytes == 424, "SpvReflectDescriptorBinding.array has unexpected offset % instead of 424", it.offset_in_bytes);
                    assert(it.type.runtime_size == 132, "SpvReflectDescriptorBinding.array has unexpected size % instead of 132", it.type.runtime_size);
                case "count";
                    assert(it.offset_in_bytes == 556, "SpvReflectDescriptorBinding.count has unexpected offset % instead of 556", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectDescriptorBinding.count has unexpected size % instead of 4", it.type.runtime_size);
                case "accessed";
                    assert(it.offset_in_bytes == 560, "SpvReflectDescriptorBinding.accessed has unexpected offset % instead of 560", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectDescriptorBinding.accessed has unexpected size % instead of 4", it.type.runtime_size);
                case "uav_counter_id";
                    assert(it.offset_in_bytes == 564, "SpvReflectDescriptorBinding.uav_counter_id has unexpected offset % instead of 564", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectDescriptorBinding.uav_counter_id has unexpected size % instead of 4", it.type.runtime_size);
                case "uav_counter_binding";
                    assert(it.offset_in_bytes == 568, "SpvReflectDescriptorBinding.uav_counter_binding has unexpected offset % instead of 568", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectDescriptorBinding.uav_counter_binding has unexpected size % instead of 8", it.type.runtime_size);
                case "byte_address_buffer_offset_count";
                    assert(it.offset_in_bytes == 576, "SpvReflectDescriptorBinding.byte_address_buffer_offset_count has unexpected offset % instead of 576", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectDescriptorBinding.byte_address_buffer_offset_count has unexpected size % instead of 4", it.type.runtime_size);
                case "byte_address_buffer_offsets";
                    assert(it.offset_in_bytes == 584, "SpvReflectDescriptorBinding.byte_address_buffer_offsets has unexpected offset % instead of 584", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectDescriptorBinding.byte_address_buffer_offsets has unexpected size % instead of 8", it.type.runtime_size);
                case "type_description";
                    assert(it.offset_in_bytes == 592, "SpvReflectDescriptorBinding.type_description has unexpected offset % instead of 592", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectDescriptorBinding.type_description has unexpected size % instead of 8", it.type.runtime_size);
                case "word_offset";
                    assert(it.offset_in_bytes == 600, "SpvReflectDescriptorBinding.word_offset has unexpected offset % instead of 600", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectDescriptorBinding.word_offset has unexpected size % instead of 8", it.type.runtime_size);
                case "decoration_flags";
                    assert(it.offset_in_bytes == 608, "SpvReflectDescriptorBinding.decoration_flags has unexpected offset % instead of 608", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectDescriptorBinding.decoration_flags has unexpected size % instead of 4", it.type.runtime_size);
                case "user_type";
                    assert(it.offset_in_bytes == 612, "SpvReflectDescriptorBinding.user_type has unexpected offset % instead of 612", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectDescriptorBinding.user_type has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectDescriptorBinding) == 616, "SpvReflectDescriptorBinding has size % instead of 616", size_of(SpvReflectDescriptorBinding));
    }

    {
        info := type_info(SpvReflectDescriptorSet);
        for info.members {
            if it.name == {
                case "set";
                    assert(it.offset_in_bytes == 0, "SpvReflectDescriptorSet.set has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectDescriptorSet.set has unexpected size % instead of 4", it.type.runtime_size);
                case "binding_count";
                    assert(it.offset_in_bytes == 4, "SpvReflectDescriptorSet.binding_count has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectDescriptorSet.binding_count has unexpected size % instead of 4", it.type.runtime_size);
                case "bindings";
                    assert(it.offset_in_bytes == 8, "SpvReflectDescriptorSet.bindings has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectDescriptorSet.bindings has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectDescriptorSet) == 16, "SpvReflectDescriptorSet has size % instead of 16", size_of(SpvReflectDescriptorSet));
    }

    {
        info := type_info(SpvReflectEntryPoint.LocalSize);
        for info.members {
            if it.name == {
                case "x";
                    assert(it.offset_in_bytes == 0, "SpvReflectEntryPoint.LocalSize.x has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectEntryPoint.LocalSize.x has unexpected size % instead of 4", it.type.runtime_size);
                case "y";
                    assert(it.offset_in_bytes == 4, "SpvReflectEntryPoint.LocalSize.y has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectEntryPoint.LocalSize.y has unexpected size % instead of 4", it.type.runtime_size);
                case "z";
                    assert(it.offset_in_bytes == 8, "SpvReflectEntryPoint.LocalSize.z has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectEntryPoint.LocalSize.z has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectEntryPoint.LocalSize) == 12, "SpvReflectEntryPoint.LocalSize has size % instead of 12", size_of(SpvReflectEntryPoint.LocalSize));
    }

    {
        info := type_info(SpvReflectEntryPoint);
        for info.members {
            if it.name == {
                case "name";
                    assert(it.offset_in_bytes == 0, "SpvReflectEntryPoint.name has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectEntryPoint.name has unexpected size % instead of 8", it.type.runtime_size);
                case "id";
                    assert(it.offset_in_bytes == 8, "SpvReflectEntryPoint.id has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectEntryPoint.id has unexpected size % instead of 4", it.type.runtime_size);
                case "spirv_execution_model";
                    assert(it.offset_in_bytes == 12, "SpvReflectEntryPoint.spirv_execution_model has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectEntryPoint.spirv_execution_model has unexpected size % instead of 4", it.type.runtime_size);
                case "shader_stage";
                    assert(it.offset_in_bytes == 16, "SpvReflectEntryPoint.shader_stage has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectEntryPoint.shader_stage has unexpected size % instead of 4", it.type.runtime_size);
                case "input_variable_count";
                    assert(it.offset_in_bytes == 20, "SpvReflectEntryPoint.input_variable_count has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectEntryPoint.input_variable_count has unexpected size % instead of 4", it.type.runtime_size);
                case "input_variables";
                    assert(it.offset_in_bytes == 24, "SpvReflectEntryPoint.input_variables has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectEntryPoint.input_variables has unexpected size % instead of 8", it.type.runtime_size);
                case "output_variable_count";
                    assert(it.offset_in_bytes == 32, "SpvReflectEntryPoint.output_variable_count has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectEntryPoint.output_variable_count has unexpected size % instead of 4", it.type.runtime_size);
                case "output_variables";
                    assert(it.offset_in_bytes == 40, "SpvReflectEntryPoint.output_variables has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectEntryPoint.output_variables has unexpected size % instead of 8", it.type.runtime_size);
                case "interface_variable_count";
                    assert(it.offset_in_bytes == 48, "SpvReflectEntryPoint.interface_variable_count has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectEntryPoint.interface_variable_count has unexpected size % instead of 4", it.type.runtime_size);
                case "interface_variables";
                    assert(it.offset_in_bytes == 56, "SpvReflectEntryPoint.interface_variables has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectEntryPoint.interface_variables has unexpected size % instead of 8", it.type.runtime_size);
                case "descriptor_set_count";
                    assert(it.offset_in_bytes == 64, "SpvReflectEntryPoint.descriptor_set_count has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectEntryPoint.descriptor_set_count has unexpected size % instead of 4", it.type.runtime_size);
                case "descriptor_sets";
                    assert(it.offset_in_bytes == 72, "SpvReflectEntryPoint.descriptor_sets has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectEntryPoint.descriptor_sets has unexpected size % instead of 8", it.type.runtime_size);
                case "used_uniform_count";
                    assert(it.offset_in_bytes == 80, "SpvReflectEntryPoint.used_uniform_count has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectEntryPoint.used_uniform_count has unexpected size % instead of 4", it.type.runtime_size);
                case "used_uniforms";
                    assert(it.offset_in_bytes == 88, "SpvReflectEntryPoint.used_uniforms has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectEntryPoint.used_uniforms has unexpected size % instead of 8", it.type.runtime_size);
                case "used_push_constant_count";
                    assert(it.offset_in_bytes == 96, "SpvReflectEntryPoint.used_push_constant_count has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectEntryPoint.used_push_constant_count has unexpected size % instead of 4", it.type.runtime_size);
                case "used_push_constants";
                    assert(it.offset_in_bytes == 104, "SpvReflectEntryPoint.used_push_constants has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectEntryPoint.used_push_constants has unexpected size % instead of 8", it.type.runtime_size);
                case "execution_mode_count";
                    assert(it.offset_in_bytes == 112, "SpvReflectEntryPoint.execution_mode_count has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectEntryPoint.execution_mode_count has unexpected size % instead of 4", it.type.runtime_size);
                case "execution_modes";
                    assert(it.offset_in_bytes == 120, "SpvReflectEntryPoint.execution_modes has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectEntryPoint.execution_modes has unexpected size % instead of 8", it.type.runtime_size);
                case "local_size";
                    assert(it.offset_in_bytes == 128, "SpvReflectEntryPoint.local_size has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "SpvReflectEntryPoint.local_size has unexpected size % instead of 12", it.type.runtime_size);
                case "invocations";
                    assert(it.offset_in_bytes == 140, "SpvReflectEntryPoint.invocations has unexpected offset % instead of 140", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectEntryPoint.invocations has unexpected size % instead of 4", it.type.runtime_size);
                case "output_vertices";
                    assert(it.offset_in_bytes == 144, "SpvReflectEntryPoint.output_vertices has unexpected offset % instead of 144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectEntryPoint.output_vertices has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectEntryPoint) == 152, "SpvReflectEntryPoint has size % instead of 152", size_of(SpvReflectEntryPoint));
    }

    {
        info := type_info(SpvReflectCapability);
        for info.members {
            if it.name == {
                case "value";
                    assert(it.offset_in_bytes == 0, "SpvReflectCapability.value has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectCapability.value has unexpected size % instead of 4", it.type.runtime_size);
                case "word_offset";
                    assert(it.offset_in_bytes == 4, "SpvReflectCapability.word_offset has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectCapability.word_offset has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectCapability) == 8, "SpvReflectCapability has size % instead of 8", size_of(SpvReflectCapability));
    }

    {
        info := type_info(SpvReflectSpecializationConstant);
        for info.members {
            if it.name == {
                case "spirv_id";
                    assert(it.offset_in_bytes == 0, "SpvReflectSpecializationConstant.spirv_id has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectSpecializationConstant.spirv_id has unexpected size % instead of 4", it.type.runtime_size);
                case "constant_id";
                    assert(it.offset_in_bytes == 4, "SpvReflectSpecializationConstant.constant_id has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectSpecializationConstant.constant_id has unexpected size % instead of 4", it.type.runtime_size);
                case "name";
                    assert(it.offset_in_bytes == 8, "SpvReflectSpecializationConstant.name has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectSpecializationConstant.name has unexpected size % instead of 8", it.type.runtime_size);
                case "type_description";
                    assert(it.offset_in_bytes == 16, "SpvReflectSpecializationConstant.type_description has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectSpecializationConstant.type_description has unexpected size % instead of 8", it.type.runtime_size);
                case "default_value_size";
                    assert(it.offset_in_bytes == 24, "SpvReflectSpecializationConstant.default_value_size has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectSpecializationConstant.default_value_size has unexpected size % instead of 4", it.type.runtime_size);
                case "default_value";
                    assert(it.offset_in_bytes == 32, "SpvReflectSpecializationConstant.default_value has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectSpecializationConstant.default_value has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectSpecializationConstant) == 40, "SpvReflectSpecializationConstant has size % instead of 40", size_of(SpvReflectSpecializationConstant));
    }

    {
        info := type_info(SpvReflectShaderModule.Internal);
        for info.members {
            if it.name == {
                case "module_flags";
                    assert(it.offset_in_bytes == 0, "SpvReflectShaderModule.Internal.module_flags has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.Internal.module_flags has unexpected size % instead of 4", it.type.runtime_size);
                case "spirv_size";
                    assert(it.offset_in_bytes == 8, "SpvReflectShaderModule.Internal.spirv_size has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule.Internal.spirv_size has unexpected size % instead of 8", it.type.runtime_size);
                case "spirv_code";
                    assert(it.offset_in_bytes == 16, "SpvReflectShaderModule.Internal.spirv_code has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule.Internal.spirv_code has unexpected size % instead of 8", it.type.runtime_size);
                case "spirv_word_count";
                    assert(it.offset_in_bytes == 24, "SpvReflectShaderModule.Internal.spirv_word_count has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.Internal.spirv_word_count has unexpected size % instead of 4", it.type.runtime_size);
                case "type_description_count";
                    assert(it.offset_in_bytes == 32, "SpvReflectShaderModule.Internal.type_description_count has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule.Internal.type_description_count has unexpected size % instead of 8", it.type.runtime_size);
                case "type_descriptions";
                    assert(it.offset_in_bytes == 40, "SpvReflectShaderModule.Internal.type_descriptions has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule.Internal.type_descriptions has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectShaderModule.Internal) == 48, "SpvReflectShaderModule.Internal has size % instead of 48", size_of(SpvReflectShaderModule.Internal));
    }

    {
        info := type_info(SpvReflectShaderModule);
        for info.members {
            if it.name == {
                case "generator";
                    assert(it.offset_in_bytes == 0, "SpvReflectShaderModule.generator has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.generator has unexpected size % instead of 4", it.type.runtime_size);
                case "entry_point_name";
                    assert(it.offset_in_bytes == 8, "SpvReflectShaderModule.entry_point_name has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule.entry_point_name has unexpected size % instead of 8", it.type.runtime_size);
                case "entry_point_id";
                    assert(it.offset_in_bytes == 16, "SpvReflectShaderModule.entry_point_id has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.entry_point_id has unexpected size % instead of 4", it.type.runtime_size);
                case "entry_point_count";
                    assert(it.offset_in_bytes == 20, "SpvReflectShaderModule.entry_point_count has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.entry_point_count has unexpected size % instead of 4", it.type.runtime_size);
                case "entry_points";
                    assert(it.offset_in_bytes == 24, "SpvReflectShaderModule.entry_points has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule.entry_points has unexpected size % instead of 8", it.type.runtime_size);
                case "source_language";
                    assert(it.offset_in_bytes == 32, "SpvReflectShaderModule.source_language has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.source_language has unexpected size % instead of 4", it.type.runtime_size);
                case "source_language_version";
                    assert(it.offset_in_bytes == 36, "SpvReflectShaderModule.source_language_version has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.source_language_version has unexpected size % instead of 4", it.type.runtime_size);
                case "source_file";
                    assert(it.offset_in_bytes == 40, "SpvReflectShaderModule.source_file has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule.source_file has unexpected size % instead of 8", it.type.runtime_size);
                case "source_source";
                    assert(it.offset_in_bytes == 48, "SpvReflectShaderModule.source_source has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule.source_source has unexpected size % instead of 8", it.type.runtime_size);
                case "capability_count";
                    assert(it.offset_in_bytes == 56, "SpvReflectShaderModule.capability_count has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.capability_count has unexpected size % instead of 4", it.type.runtime_size);
                case "capabilities";
                    assert(it.offset_in_bytes == 64, "SpvReflectShaderModule.capabilities has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule.capabilities has unexpected size % instead of 8", it.type.runtime_size);
                case "spirv_execution_model";
                    assert(it.offset_in_bytes == 72, "SpvReflectShaderModule.spirv_execution_model has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.spirv_execution_model has unexpected size % instead of 4", it.type.runtime_size);
                case "shader_stage";
                    assert(it.offset_in_bytes == 76, "SpvReflectShaderModule.shader_stage has unexpected offset % instead of 76", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.shader_stage has unexpected size % instead of 4", it.type.runtime_size);
                case "descriptor_binding_count";
                    assert(it.offset_in_bytes == 80, "SpvReflectShaderModule.descriptor_binding_count has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.descriptor_binding_count has unexpected size % instead of 4", it.type.runtime_size);
                case "descriptor_bindings";
                    assert(it.offset_in_bytes == 88, "SpvReflectShaderModule.descriptor_bindings has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule.descriptor_bindings has unexpected size % instead of 8", it.type.runtime_size);
                case "descriptor_set_count";
                    assert(it.offset_in_bytes == 96, "SpvReflectShaderModule.descriptor_set_count has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.descriptor_set_count has unexpected size % instead of 4", it.type.runtime_size);
                case "descriptor_sets";
                    assert(it.offset_in_bytes == 104, "SpvReflectShaderModule.descriptor_sets has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1024, "SpvReflectShaderModule.descriptor_sets has unexpected size % instead of 1024", it.type.runtime_size);
                case "input_variable_count";
                    assert(it.offset_in_bytes == 1128, "SpvReflectShaderModule.input_variable_count has unexpected offset % instead of 1128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.input_variable_count has unexpected size % instead of 4", it.type.runtime_size);
                case "input_variables";
                    assert(it.offset_in_bytes == 1136, "SpvReflectShaderModule.input_variables has unexpected offset % instead of 1136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule.input_variables has unexpected size % instead of 8", it.type.runtime_size);
                case "output_variable_count";
                    assert(it.offset_in_bytes == 1144, "SpvReflectShaderModule.output_variable_count has unexpected offset % instead of 1144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.output_variable_count has unexpected size % instead of 4", it.type.runtime_size);
                case "output_variables";
                    assert(it.offset_in_bytes == 1152, "SpvReflectShaderModule.output_variables has unexpected offset % instead of 1152", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule.output_variables has unexpected size % instead of 8", it.type.runtime_size);
                case "interface_variable_count";
                    assert(it.offset_in_bytes == 1160, "SpvReflectShaderModule.interface_variable_count has unexpected offset % instead of 1160", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.interface_variable_count has unexpected size % instead of 4", it.type.runtime_size);
                case "interface_variables";
                    assert(it.offset_in_bytes == 1168, "SpvReflectShaderModule.interface_variables has unexpected offset % instead of 1168", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule.interface_variables has unexpected size % instead of 8", it.type.runtime_size);
                case "push_constant_block_count";
                    assert(it.offset_in_bytes == 1176, "SpvReflectShaderModule.push_constant_block_count has unexpected offset % instead of 1176", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.push_constant_block_count has unexpected size % instead of 4", it.type.runtime_size);
                case "push_constant_blocks";
                    assert(it.offset_in_bytes == 1184, "SpvReflectShaderModule.push_constant_blocks has unexpected offset % instead of 1184", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule.push_constant_blocks has unexpected size % instead of 8", it.type.runtime_size);
                case "spec_constant_count";
                    assert(it.offset_in_bytes == 1192, "SpvReflectShaderModule.spec_constant_count has unexpected offset % instead of 1192", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectShaderModule.spec_constant_count has unexpected size % instead of 4", it.type.runtime_size);
                case "spec_constants";
                    assert(it.offset_in_bytes == 1200, "SpvReflectShaderModule.spec_constants has unexpected offset % instead of 1200", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule.spec_constants has unexpected size % instead of 8", it.type.runtime_size);
                case "_internal";
                    assert(it.offset_in_bytes == 1208, "SpvReflectShaderModule._internal has unexpected offset % instead of 1208", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectShaderModule._internal has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectShaderModule) == 1216, "SpvReflectShaderModule has size % instead of 1216", size_of(SpvReflectShaderModule));
    }

    {
        info := type_info(SpvReflectPrvArrayTraits);
        for info.members {
            if it.name == {
                case "element_type_id";
                    assert(it.offset_in_bytes == 0, "SpvReflectPrvArrayTraits.element_type_id has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvArrayTraits.element_type_id has unexpected size % instead of 4", it.type.runtime_size);
                case "length_id";
                    assert(it.offset_in_bytes == 4, "SpvReflectPrvArrayTraits.length_id has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvArrayTraits.length_id has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectPrvArrayTraits) == 8, "SpvReflectPrvArrayTraits has size % instead of 8", size_of(SpvReflectPrvArrayTraits));
    }

    {
        info := type_info(SpvReflectPrvImageTraits);
        for info.members {
            if it.name == {
                case "sampled_type_id";
                    assert(it.offset_in_bytes == 0, "SpvReflectPrvImageTraits.sampled_type_id has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvImageTraits.sampled_type_id has unexpected size % instead of 4", it.type.runtime_size);
                case "dim";
                    assert(it.offset_in_bytes == 4, "SpvReflectPrvImageTraits.dim has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvImageTraits.dim has unexpected size % instead of 4", it.type.runtime_size);
                case "depth";
                    assert(it.offset_in_bytes == 8, "SpvReflectPrvImageTraits.depth has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvImageTraits.depth has unexpected size % instead of 4", it.type.runtime_size);
                case "arrayed";
                    assert(it.offset_in_bytes == 12, "SpvReflectPrvImageTraits.arrayed has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvImageTraits.arrayed has unexpected size % instead of 4", it.type.runtime_size);
                case "ms";
                    assert(it.offset_in_bytes == 16, "SpvReflectPrvImageTraits.ms has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvImageTraits.ms has unexpected size % instead of 4", it.type.runtime_size);
                case "sampled";
                    assert(it.offset_in_bytes == 20, "SpvReflectPrvImageTraits.sampled has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvImageTraits.sampled has unexpected size % instead of 4", it.type.runtime_size);
                case "image_format";
                    assert(it.offset_in_bytes == 24, "SpvReflectPrvImageTraits.image_format has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvImageTraits.image_format has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectPrvImageTraits) == 28, "SpvReflectPrvImageTraits has size % instead of 28", size_of(SpvReflectPrvImageTraits));
    }

    {
        info := type_info(SpvReflectPrvNumberDecoration);
        for info.members {
            if it.name == {
                case "word_offset";
                    assert(it.offset_in_bytes == 0, "SpvReflectPrvNumberDecoration.word_offset has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvNumberDecoration.word_offset has unexpected size % instead of 4", it.type.runtime_size);
                case "value";
                    assert(it.offset_in_bytes == 4, "SpvReflectPrvNumberDecoration.value has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvNumberDecoration.value has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectPrvNumberDecoration) == 8, "SpvReflectPrvNumberDecoration has size % instead of 8", size_of(SpvReflectPrvNumberDecoration));
    }

    {
        info := type_info(SpvReflectPrvStringDecoration);
        for info.members {
            if it.name == {
                case "word_offset";
                    assert(it.offset_in_bytes == 0, "SpvReflectPrvStringDecoration.word_offset has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvStringDecoration.word_offset has unexpected size % instead of 4", it.type.runtime_size);
                case "value";
                    assert(it.offset_in_bytes == 8, "SpvReflectPrvStringDecoration.value has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvStringDecoration.value has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectPrvStringDecoration) == 16, "SpvReflectPrvStringDecoration has size % instead of 16", size_of(SpvReflectPrvStringDecoration));
    }

    {
        info := type_info(SpvReflectPrvDecorations);
        for info.members {
            if it.name == {
                case "is_relaxed_precision";
                    assert(it.offset_in_bytes == 0, "SpvReflectPrvDecorations.is_relaxed_precision has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvDecorations.is_relaxed_precision has unexpected size % instead of 1", it.type.runtime_size);
                case "is_block";
                    assert(it.offset_in_bytes == 1, "SpvReflectPrvDecorations.is_block has unexpected offset % instead of 1", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvDecorations.is_block has unexpected size % instead of 1", it.type.runtime_size);
                case "is_buffer_block";
                    assert(it.offset_in_bytes == 2, "SpvReflectPrvDecorations.is_buffer_block has unexpected offset % instead of 2", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvDecorations.is_buffer_block has unexpected size % instead of 1", it.type.runtime_size);
                case "is_row_major";
                    assert(it.offset_in_bytes == 3, "SpvReflectPrvDecorations.is_row_major has unexpected offset % instead of 3", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvDecorations.is_row_major has unexpected size % instead of 1", it.type.runtime_size);
                case "is_column_major";
                    assert(it.offset_in_bytes == 4, "SpvReflectPrvDecorations.is_column_major has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvDecorations.is_column_major has unexpected size % instead of 1", it.type.runtime_size);
                case "is_built_in";
                    assert(it.offset_in_bytes == 5, "SpvReflectPrvDecorations.is_built_in has unexpected offset % instead of 5", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvDecorations.is_built_in has unexpected size % instead of 1", it.type.runtime_size);
                case "is_noperspective";
                    assert(it.offset_in_bytes == 6, "SpvReflectPrvDecorations.is_noperspective has unexpected offset % instead of 6", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvDecorations.is_noperspective has unexpected size % instead of 1", it.type.runtime_size);
                case "is_flat";
                    assert(it.offset_in_bytes == 7, "SpvReflectPrvDecorations.is_flat has unexpected offset % instead of 7", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvDecorations.is_flat has unexpected size % instead of 1", it.type.runtime_size);
                case "is_non_writable";
                    assert(it.offset_in_bytes == 8, "SpvReflectPrvDecorations.is_non_writable has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvDecorations.is_non_writable has unexpected size % instead of 1", it.type.runtime_size);
                case "is_non_readable";
                    assert(it.offset_in_bytes == 9, "SpvReflectPrvDecorations.is_non_readable has unexpected offset % instead of 9", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvDecorations.is_non_readable has unexpected size % instead of 1", it.type.runtime_size);
                case "is_patch";
                    assert(it.offset_in_bytes == 10, "SpvReflectPrvDecorations.is_patch has unexpected offset % instead of 10", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvDecorations.is_patch has unexpected size % instead of 1", it.type.runtime_size);
                case "is_per_vertex";
                    assert(it.offset_in_bytes == 11, "SpvReflectPrvDecorations.is_per_vertex has unexpected offset % instead of 11", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvDecorations.is_per_vertex has unexpected size % instead of 1", it.type.runtime_size);
                case "is_per_task";
                    assert(it.offset_in_bytes == 12, "SpvReflectPrvDecorations.is_per_task has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvDecorations.is_per_task has unexpected size % instead of 1", it.type.runtime_size);
                case "is_weight_texture";
                    assert(it.offset_in_bytes == 13, "SpvReflectPrvDecorations.is_weight_texture has unexpected offset % instead of 13", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvDecorations.is_weight_texture has unexpected size % instead of 1", it.type.runtime_size);
                case "is_block_match_texture";
                    assert(it.offset_in_bytes == 14, "SpvReflectPrvDecorations.is_block_match_texture has unexpected offset % instead of 14", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvDecorations.is_block_match_texture has unexpected size % instead of 1", it.type.runtime_size);
                case "user_type";
                    assert(it.offset_in_bytes == 16, "SpvReflectPrvDecorations.user_type has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvDecorations.user_type has unexpected size % instead of 4", it.type.runtime_size);
                case "set";
                    assert(it.offset_in_bytes == 20, "SpvReflectPrvDecorations.set has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvDecorations.set has unexpected size % instead of 8", it.type.runtime_size);
                case "binding";
                    assert(it.offset_in_bytes == 28, "SpvReflectPrvDecorations.binding has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvDecorations.binding has unexpected size % instead of 8", it.type.runtime_size);
                case "input_attachment_index";
                    assert(it.offset_in_bytes == 36, "SpvReflectPrvDecorations.input_attachment_index has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvDecorations.input_attachment_index has unexpected size % instead of 8", it.type.runtime_size);
                case "location";
                    assert(it.offset_in_bytes == 44, "SpvReflectPrvDecorations.location has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvDecorations.location has unexpected size % instead of 8", it.type.runtime_size);
                case "component";
                    assert(it.offset_in_bytes == 52, "SpvReflectPrvDecorations.component has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvDecorations.component has unexpected size % instead of 8", it.type.runtime_size);
                case "offset";
                    assert(it.offset_in_bytes == 60, "SpvReflectPrvDecorations.offset has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvDecorations.offset has unexpected size % instead of 8", it.type.runtime_size);
                case "uav_counter_buffer";
                    assert(it.offset_in_bytes == 68, "SpvReflectPrvDecorations.uav_counter_buffer has unexpected offset % instead of 68", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvDecorations.uav_counter_buffer has unexpected size % instead of 8", it.type.runtime_size);
                case "semantic";
                    assert(it.offset_in_bytes == 80, "SpvReflectPrvDecorations.semantic has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "SpvReflectPrvDecorations.semantic has unexpected size % instead of 16", it.type.runtime_size);
                case "array_stride";
                    assert(it.offset_in_bytes == 96, "SpvReflectPrvDecorations.array_stride has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvDecorations.array_stride has unexpected size % instead of 4", it.type.runtime_size);
                case "matrix_stride";
                    assert(it.offset_in_bytes == 100, "SpvReflectPrvDecorations.matrix_stride has unexpected offset % instead of 100", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvDecorations.matrix_stride has unexpected size % instead of 4", it.type.runtime_size);
                case "spec_id";
                    assert(it.offset_in_bytes == 104, "SpvReflectPrvDecorations.spec_id has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvDecorations.spec_id has unexpected size % instead of 4", it.type.runtime_size);
                case "built_in";
                    assert(it.offset_in_bytes == 108, "SpvReflectPrvDecorations.built_in has unexpected offset % instead of 108", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvDecorations.built_in has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectPrvDecorations) == 112, "SpvReflectPrvDecorations has size % instead of 112", size_of(SpvReflectPrvDecorations));
    }

    {
        info := type_info(SpvReflectPrvNode);
        for info.members {
            if it.name == {
                case "result_id";
                    assert(it.offset_in_bytes == 0, "SpvReflectPrvNode.result_id has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvNode.result_id has unexpected size % instead of 4", it.type.runtime_size);
                case "op";
                    assert(it.offset_in_bytes == 4, "SpvReflectPrvNode.op has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvNode.op has unexpected size % instead of 4", it.type.runtime_size);
                case "result_type_id";
                    assert(it.offset_in_bytes == 8, "SpvReflectPrvNode.result_type_id has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvNode.result_type_id has unexpected size % instead of 4", it.type.runtime_size);
                case "type_id";
                    assert(it.offset_in_bytes == 12, "SpvReflectPrvNode.type_id has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvNode.type_id has unexpected size % instead of 4", it.type.runtime_size);
                case "capability";
                    assert(it.offset_in_bytes == 16, "SpvReflectPrvNode.capability has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvNode.capability has unexpected size % instead of 4", it.type.runtime_size);
                case "storage_class";
                    assert(it.offset_in_bytes == 20, "SpvReflectPrvNode.storage_class has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvNode.storage_class has unexpected size % instead of 4", it.type.runtime_size);
                case "word_offset";
                    assert(it.offset_in_bytes == 24, "SpvReflectPrvNode.word_offset has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvNode.word_offset has unexpected size % instead of 4", it.type.runtime_size);
                case "word_count";
                    assert(it.offset_in_bytes == 28, "SpvReflectPrvNode.word_count has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvNode.word_count has unexpected size % instead of 4", it.type.runtime_size);
                case "is_type";
                    assert(it.offset_in_bytes == 32, "SpvReflectPrvNode.is_type has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "SpvReflectPrvNode.is_type has unexpected size % instead of 1", it.type.runtime_size);
                case "array_traits";
                    assert(it.offset_in_bytes == 36, "SpvReflectPrvNode.array_traits has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvNode.array_traits has unexpected size % instead of 8", it.type.runtime_size);
                case "image_traits";
                    assert(it.offset_in_bytes == 44, "SpvReflectPrvNode.image_traits has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "SpvReflectPrvNode.image_traits has unexpected size % instead of 28", it.type.runtime_size);
                case "image_type_id";
                    assert(it.offset_in_bytes == 72, "SpvReflectPrvNode.image_type_id has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvNode.image_type_id has unexpected size % instead of 4", it.type.runtime_size);
                case "name";
                    assert(it.offset_in_bytes == 80, "SpvReflectPrvNode.name has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvNode.name has unexpected size % instead of 8", it.type.runtime_size);
                case "decorations";
                    assert(it.offset_in_bytes == 88, "SpvReflectPrvNode.decorations has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 112, "SpvReflectPrvNode.decorations has unexpected size % instead of 112", it.type.runtime_size);
                case "member_count";
                    assert(it.offset_in_bytes == 200, "SpvReflectPrvNode.member_count has unexpected offset % instead of 200", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvNode.member_count has unexpected size % instead of 4", it.type.runtime_size);
                case "member_names";
                    assert(it.offset_in_bytes == 208, "SpvReflectPrvNode.member_names has unexpected offset % instead of 208", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvNode.member_names has unexpected size % instead of 8", it.type.runtime_size);
                case "member_decorations";
                    assert(it.offset_in_bytes == 216, "SpvReflectPrvNode.member_decorations has unexpected offset % instead of 216", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvNode.member_decorations has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectPrvNode) == 224, "SpvReflectPrvNode has size % instead of 224", size_of(SpvReflectPrvNode));
    }

    {
        info := type_info(SpvReflectPrvString);
        for info.members {
            if it.name == {
                case "result_id";
                    assert(it.offset_in_bytes == 0, "SpvReflectPrvString.result_id has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvString.result_id has unexpected size % instead of 4", it.type.runtime_size);
                case "_string";
                    assert(it.offset_in_bytes == 8, "SpvReflectPrvString._string has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvString._string has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectPrvString) == 16, "SpvReflectPrvString has size % instead of 16", size_of(SpvReflectPrvString));
    }

    {
        info := type_info(SpvReflectPrvAccessedVariable);
        for info.members {
            if it.name == {
                case "p_node";
                    assert(it.offset_in_bytes == 0, "SpvReflectPrvAccessedVariable.p_node has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvAccessedVariable.p_node has unexpected size % instead of 8", it.type.runtime_size);
                case "result_id";
                    assert(it.offset_in_bytes == 8, "SpvReflectPrvAccessedVariable.result_id has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvAccessedVariable.result_id has unexpected size % instead of 4", it.type.runtime_size);
                case "variable_ptr";
                    assert(it.offset_in_bytes == 12, "SpvReflectPrvAccessedVariable.variable_ptr has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvAccessedVariable.variable_ptr has unexpected size % instead of 4", it.type.runtime_size);
                case "function_id";
                    assert(it.offset_in_bytes == 16, "SpvReflectPrvAccessedVariable.function_id has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvAccessedVariable.function_id has unexpected size % instead of 4", it.type.runtime_size);
                case "function_parameter_index";
                    assert(it.offset_in_bytes == 20, "SpvReflectPrvAccessedVariable.function_parameter_index has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvAccessedVariable.function_parameter_index has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectPrvAccessedVariable) == 24, "SpvReflectPrvAccessedVariable has size % instead of 24", size_of(SpvReflectPrvAccessedVariable));
    }

    {
        info := type_info(SpvReflectPrvFunction);
        for info.members {
            if it.name == {
                case "id";
                    assert(it.offset_in_bytes == 0, "SpvReflectPrvFunction.id has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvFunction.id has unexpected size % instead of 4", it.type.runtime_size);
                case "parameter_count";
                    assert(it.offset_in_bytes == 4, "SpvReflectPrvFunction.parameter_count has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvFunction.parameter_count has unexpected size % instead of 4", it.type.runtime_size);
                case "parameters";
                    assert(it.offset_in_bytes == 8, "SpvReflectPrvFunction.parameters has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvFunction.parameters has unexpected size % instead of 8", it.type.runtime_size);
                case "callee_count";
                    assert(it.offset_in_bytes == 16, "SpvReflectPrvFunction.callee_count has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvFunction.callee_count has unexpected size % instead of 4", it.type.runtime_size);
                case "callees";
                    assert(it.offset_in_bytes == 24, "SpvReflectPrvFunction.callees has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvFunction.callees has unexpected size % instead of 8", it.type.runtime_size);
                case "callee_ptrs";
                    assert(it.offset_in_bytes == 32, "SpvReflectPrvFunction.callee_ptrs has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvFunction.callee_ptrs has unexpected size % instead of 8", it.type.runtime_size);
                case "accessed_variable_count";
                    assert(it.offset_in_bytes == 40, "SpvReflectPrvFunction.accessed_variable_count has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvFunction.accessed_variable_count has unexpected size % instead of 4", it.type.runtime_size);
                case "accessed_variables";
                    assert(it.offset_in_bytes == 48, "SpvReflectPrvFunction.accessed_variables has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvFunction.accessed_variables has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectPrvFunction) == 56, "SpvReflectPrvFunction has size % instead of 56", size_of(SpvReflectPrvFunction));
    }

    {
        info := type_info(SpvReflectPrvAccessChain);
        for info.members {
            if it.name == {
                case "result_id";
                    assert(it.offset_in_bytes == 0, "SpvReflectPrvAccessChain.result_id has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvAccessChain.result_id has unexpected size % instead of 4", it.type.runtime_size);
                case "result_type_id";
                    assert(it.offset_in_bytes == 4, "SpvReflectPrvAccessChain.result_type_id has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvAccessChain.result_type_id has unexpected size % instead of 4", it.type.runtime_size);
                case "base_id";
                    assert(it.offset_in_bytes == 8, "SpvReflectPrvAccessChain.base_id has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvAccessChain.base_id has unexpected size % instead of 4", it.type.runtime_size);
                case "index_count";
                    assert(it.offset_in_bytes == 12, "SpvReflectPrvAccessChain.index_count has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvAccessChain.index_count has unexpected size % instead of 4", it.type.runtime_size);
                case "indexes";
                    assert(it.offset_in_bytes == 16, "SpvReflectPrvAccessChain.indexes has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvAccessChain.indexes has unexpected size % instead of 8", it.type.runtime_size);
                case "block_var";
                    assert(it.offset_in_bytes == 24, "SpvReflectPrvAccessChain.block_var has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvAccessChain.block_var has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectPrvAccessChain) == 32, "SpvReflectPrvAccessChain has size % instead of 32", size_of(SpvReflectPrvAccessChain));
    }

    {
        info := type_info(SpvReflectPrvPhysicalPointerStruct);
        for info.members {
            if it.name == {
                case "struct_id";
                    assert(it.offset_in_bytes == 0, "SpvReflectPrvPhysicalPointerStruct.struct_id has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvPhysicalPointerStruct.struct_id has unexpected size % instead of 4", it.type.runtime_size);
                case "p_var";
                    assert(it.offset_in_bytes == 8, "SpvReflectPrvPhysicalPointerStruct.p_var has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvPhysicalPointerStruct.p_var has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectPrvPhysicalPointerStruct) == 16, "SpvReflectPrvPhysicalPointerStruct has size % instead of 16", size_of(SpvReflectPrvPhysicalPointerStruct));
    }

    {
        info := type_info(SpvReflectPrvParser);
        for info.members {
            if it.name == {
                case "spirv_word_count";
                    assert(it.offset_in_bytes == 0, "SpvReflectPrvParser.spirv_word_count has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvParser.spirv_word_count has unexpected size % instead of 8", it.type.runtime_size);
                case "spirv_code";
                    assert(it.offset_in_bytes == 8, "SpvReflectPrvParser.spirv_code has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvParser.spirv_code has unexpected size % instead of 8", it.type.runtime_size);
                case "string_count";
                    assert(it.offset_in_bytes == 16, "SpvReflectPrvParser.string_count has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvParser.string_count has unexpected size % instead of 4", it.type.runtime_size);
                case "strings";
                    assert(it.offset_in_bytes == 24, "SpvReflectPrvParser.strings has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvParser.strings has unexpected size % instead of 8", it.type.runtime_size);
                case "source_language";
                    assert(it.offset_in_bytes == 32, "SpvReflectPrvParser.source_language has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvParser.source_language has unexpected size % instead of 4", it.type.runtime_size);
                case "source_language_version";
                    assert(it.offset_in_bytes == 36, "SpvReflectPrvParser.source_language_version has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvParser.source_language_version has unexpected size % instead of 4", it.type.runtime_size);
                case "source_file_id";
                    assert(it.offset_in_bytes == 40, "SpvReflectPrvParser.source_file_id has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvParser.source_file_id has unexpected size % instead of 4", it.type.runtime_size);
                case "source_embedded";
                    assert(it.offset_in_bytes == 48, "SpvReflectPrvParser.source_embedded has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvParser.source_embedded has unexpected size % instead of 8", it.type.runtime_size);
                case "node_count";
                    assert(it.offset_in_bytes == 56, "SpvReflectPrvParser.node_count has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvParser.node_count has unexpected size % instead of 8", it.type.runtime_size);
                case "nodes";
                    assert(it.offset_in_bytes == 64, "SpvReflectPrvParser.nodes has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvParser.nodes has unexpected size % instead of 8", it.type.runtime_size);
                case "entry_point_count";
                    assert(it.offset_in_bytes == 72, "SpvReflectPrvParser.entry_point_count has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvParser.entry_point_count has unexpected size % instead of 4", it.type.runtime_size);
                case "capability_count";
                    assert(it.offset_in_bytes == 76, "SpvReflectPrvParser.capability_count has unexpected offset % instead of 76", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvParser.capability_count has unexpected size % instead of 4", it.type.runtime_size);
                case "function_count";
                    assert(it.offset_in_bytes == 80, "SpvReflectPrvParser.function_count has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvParser.function_count has unexpected size % instead of 4", it.type.runtime_size);
                case "functions";
                    assert(it.offset_in_bytes == 88, "SpvReflectPrvParser.functions has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvParser.functions has unexpected size % instead of 8", it.type.runtime_size);
                case "access_chain_count";
                    assert(it.offset_in_bytes == 96, "SpvReflectPrvParser.access_chain_count has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvParser.access_chain_count has unexpected size % instead of 4", it.type.runtime_size);
                case "access_chains";
                    assert(it.offset_in_bytes == 104, "SpvReflectPrvParser.access_chains has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvParser.access_chains has unexpected size % instead of 8", it.type.runtime_size);
                case "type_count";
                    assert(it.offset_in_bytes == 112, "SpvReflectPrvParser.type_count has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvParser.type_count has unexpected size % instead of 4", it.type.runtime_size);
                case "descriptor_count";
                    assert(it.offset_in_bytes == 116, "SpvReflectPrvParser.descriptor_count has unexpected offset % instead of 116", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvParser.descriptor_count has unexpected size % instead of 4", it.type.runtime_size);
                case "push_constant_count";
                    assert(it.offset_in_bytes == 120, "SpvReflectPrvParser.push_constant_count has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvParser.push_constant_count has unexpected size % instead of 4", it.type.runtime_size);
                case "spec_constant_count";
                    assert(it.offset_in_bytes == 124, "SpvReflectPrvParser.spec_constant_count has unexpected offset % instead of 124", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvParser.spec_constant_count has unexpected size % instead of 4", it.type.runtime_size);
                case "physical_pointer_check";
                    assert(it.offset_in_bytes == 128, "SpvReflectPrvParser.physical_pointer_check has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1024, "SpvReflectPrvParser.physical_pointer_check has unexpected size % instead of 1024", it.type.runtime_size);
                case "physical_pointer_count";
                    assert(it.offset_in_bytes == 1152, "SpvReflectPrvParser.physical_pointer_count has unexpected offset % instead of 1152", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvParser.physical_pointer_count has unexpected size % instead of 4", it.type.runtime_size);
                case "physical_pointer_structs";
                    assert(it.offset_in_bytes == 1160, "SpvReflectPrvParser.physical_pointer_structs has unexpected offset % instead of 1160", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SpvReflectPrvParser.physical_pointer_structs has unexpected size % instead of 8", it.type.runtime_size);
                case "physical_pointer_struct_count";
                    assert(it.offset_in_bytes == 1168, "SpvReflectPrvParser.physical_pointer_struct_count has unexpected offset % instead of 1168", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SpvReflectPrvParser.physical_pointer_struct_count has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SpvReflectPrvParser) == 1176, "SpvReflectPrvParser has size % instead of 1176", size_of(SpvReflectPrvParser));
    }
}

#if OS == .WINDOWS {
    libspirv_reflect :: #library,no_dll "windows/libspirv_reflect";
} else #if OS == .LINUX {
    libspirv_reflect :: #library,no_dll "linux/libspirv_reflect";
} else #if OS == .MACOS {
    libspirv_reflect :: #library,no_dll "macos/libspirv_reflect";
} else {
    #assert false "Unsupported OS";
}
