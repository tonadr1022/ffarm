#ifndef SHARED_BASIC_TRI_H
#define SHARED_BASIC_TRI_H

struct CameraData {
  float2 cam_pos;
  float2 world_to_clip;
};

struct SpriteInstance {
  float2 pos;
  float2 size;
  float2 uv_min;
  float2 uv_max;
  float4 color;
  float depth;
  float3 _padding;
};

struct TintData {
  float4 color;
};

struct Vertex {
  float3 position;
  float2 uv;
  float3 color;
};

#endif
