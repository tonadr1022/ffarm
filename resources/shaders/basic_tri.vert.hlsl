#include "shader_core.h"
#include "shared_basic_tri.h"
#include "shared_shader_core.h"

struct VOut {
  float4 pos : SV_Position;
  float2 uv : TEXCOORD0;
  float4 color : COLOR0;
};

StructuredBuffer<SpriteInstance> instances : register(t2);

CONSTANT_BUFFER(CameraData, camera, 0);

static const float2 k_corners[6] = {
    float2(-0.5, -0.5), float2(0.5, -0.5), float2(-0.5, 0.5),
    float2(0.5, 0.5),   float2(-0.5, 0.5), float2(0.5, -0.5),
};

VOut main(uint vert_id : SV_VertexID, uint inst_id : SV_InstanceID) {
  SpriteInstance s = instances[inst_id];
  float2 corner = k_corners[vert_id];
  float2 world = s.pos + corner * s.size;
  float2 clip = (world - camera.cam_pos) * camera.world_to_clip;

  VOut o;
  o.pos = float4(clip, s.depth, 1.0);
  o.uv = lerp(s.uv_min, s.uv_max, corner + 0.5);
  o.color = s.color;
  return o;
}
