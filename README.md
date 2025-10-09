# RSDKv4 Sonic for IRIX (big endian)

This is a copy of [RSDKv4-Decompilation](https://github.com/RSDKModding/RSDKv4-Decompilation) with modifications to run on IRIX 6.5.x

Follow the [README.md](https://github.com/RSDKModding/RSDKv4-Decompilation/blob/main/README.md) of the original project for general information on how to set up resources. Submodules are already included in this repo for IRIX, no need to initialize submodule dependencies.

## For IRIX you need: 

- [SGUG-RSE](https://github.com/sgidevnet/sgug-rse/) environment for libraries and gcc
- [SDL2 for IRIX](https://github.com/flexion-unity/SDL/tree/2.0.12-IRIX) with GL support (Note: SDL2-2.0.12 in SGUG-RSE 0.0.7 tdnf repo does not support GL yet)

## Compile on IRIX

- Clone this repo
- mkdir build && cd build
- cmake ..
- make
or "make -j4" if your SiliconGraphics box has 4 CPUs

Approximate build time: 6 minutes on a 600MHz MIPS R14000 (SGI Fuel)

Tested with Sonic 1 on Octane2 with V12 gfx.
Tested with Sonic 2 on Fuel with V10 gfx.


## Known issues

- Sonic 1 start intro + menu and in-game options menu still have serious 3D glitches.
for now, set "SkipStartMenu=true" in your settings.ini to skip the intro and proceed straight to the game.


