#include "shader_core.h"

struct VOut {
  float4 color;
};

struct Vertex {
  float3 position : SV_POSITION;
  float2 uv;
  float3 color;
};

StructuredBuffer<Vertex> vertices : register(t0);

VOut main(uint vert_id : SV_VertexID) {
  VOut o;
  o.color = float4(1, 1, 1, 1);
}
