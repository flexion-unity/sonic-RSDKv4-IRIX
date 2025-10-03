
# RSDKv4 Sonic for IRIX (big endian)

![](irix_screenshot.png?raw=true)

This is a copy of [RSDKv4-Decompilation](https://github.com/RSDKModding/RSDKv4-Decompilation) with modifications to run on IRIX 6.5.x

Follow the [README.md](https://github.com/RSDKModding/RSDKv4-Decompilation/blob/main/README.md) of the original project for general information on how to set up resources. Submodules are already included in this repo for IRIX, no need to initialize submodule dependencies.

## For IRIX you need: 

- [SGUG-RSE](https://github.com/sgidevnet/sgug-rse/) environment for libraries and gcc
- unreleased SDL2 SGUG-RSE package with experimental GL support
- Good graphics card like VPro V12

## Compile on IRIX

- Clone this repo
- mkdir build && cd build
- cmake ..
- make
or "make -j4" if your SiliconGraphics box has 4 CPUs

Tested with Sonic 1 on Octane2 with V12 gfx.

## Known issues

- Start intro + menu and in-game options menu still have serious 3D glitches.
for now, set "SkipStartMenu=true" in your settings.ini to skip the intro and proceed straight to the game. 

