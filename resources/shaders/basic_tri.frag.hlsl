#include "shader_core.h"
#include "shared_basic_tri.h"
#include "shared_shader_core.h"

struct FOut {
  float4 color : SV_Target0;
};

struct VOut {
  float4 pos : SV_Position;
  float2 uv : TEXCOORD0;
  float3 color : TEXCOORD1;
};

Texture2D albedo : register(t1);
SamplerState samp : register(s100);
CONSTANT_BUFFER(TintData, tint, 0);

FOut main(VOut vout) {
  FOut result;
  result.color =
      albedo.Sample(samp, vout.uv) * float4(vout.color, 1.0) * tint.color;
  return result;
}
