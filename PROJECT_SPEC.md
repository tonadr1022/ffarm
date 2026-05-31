## Graphics

- frontend renderer will be responsible for a potential render graph and all render passes, issuing graphics commands. The frontend renderer only interacts with the RHI, not platform specific functions.
- An RHI will abstract away graphics API specifics, such that Vulkan and Metal can be used by the same frontend renderer.

## Engine

End goal: engine can be used to make 2d and 3d games quickly. While some aspects can be code-driven, since jai compiles quickly, other aspects will still warrant editor tooling.