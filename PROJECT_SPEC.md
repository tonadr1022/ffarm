## Graphics

- frontend renderer will be responsible for a potential render graph and all render passes, issuing graphics commands. The frontend renderer only interacts with the RHI, not platform specific functions.
- An RHI will abstract away graphics API specifics, such that Vulkan and Metal can be used by the same frontend renderer.