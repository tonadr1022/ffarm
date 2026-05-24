#if OS == .LINUX || OS == .MACOS {
    #load "sdl/window.jai";
    #load "sdl/platform.jai";
} else {
    #assert false, "Unsupported platform";
}