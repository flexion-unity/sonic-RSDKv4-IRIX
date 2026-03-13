# PKG-CONFIG IS USED AS THE MAIN DRIVER
# bc cmake is inconsistent as fuuuckkk

find_package(PkgConfig REQUIRED)

add_executable(RetroEngine ${RETRO_FILES})

pkg_check_modules(OGG ogg)

if(NOT OGG_FOUND)
    set(COMPILE_OGG TRUE)
    message(NOTICE "libogg not found, attempting to build from source")
else()
    message("found libogg")
    target_link_libraries(RetroEngine PRIVATE ${OGG_STATIC_LIBRARIES})
    target_link_options(RetroEngine PRIVATE ${OGG_STATIC_LDLIBS_OTHER})
    target_compile_options(RetroEngine PRIVATE ${OGG_STATIC_CFLAGS})
endif()

pkg_check_modules(VORBIS vorbis vorbisfile) #idk what the names are

if(NOT VORBIS_FOUND)
    set(COMPILE_VORBIS TRUE)
    message(NOTICE "libvorbis not found, attempting to build from source")
else()
    message("found libvorbis")
    target_link_libraries(RetroEngine PRIVATE ${VORBIS_STATIC_LIBRARIES})
    target_link_options(RetroEngine PRIVATE ${VORBIS_STATIC_LDLIBS_OTHER})
    target_compile_options(RetroEngine PRIVATE ${VORBIS_STATIC_CFLAGS})
endif()

if(RETRO_USE_HW_RENDER)
    message(NOTICE "*** We are using Hardware Renderer ***")
#    pkg_check_modules(GLEW glew)

#    if(NOT GLEW_FOUND)
#        message(NOTICE "could not find glew, attempting to build from source")

#    else()
#        message("found GLEW")
#        target_link_libraries(RetroEngine PRIVATE ${GLEW_STATIC_LIBRARIES})
#        target_link_options(RetroEngine PRIVATE ${GLEW_STATIC_LDLIBS_OTHER})
#        target_compile_options(RetroEngine PRIVATE ${GLEW_STATIC_CFLAGS})
#    endif()
endif()

if(RETRO_SDL_VERSION STREQUAL "2")
    message(STATUS "-- Checking for SDL2 on IRIX --")
#    pkg_check_modules(SDL2 sdl2 REQUIRED)
#    find_library(MYSDL2LIB NAMES SDL2 PATHS ${CMAKE_SOURCE_DIR}/lib)


# For IRIX with SGUG-RSE we cannot use the default SDL2 library due to missing GL support
# use rpath to link to ./lib respectively ../lib/ with the SDL2-GL library included in this bundle
# (you will probably still need sdl2-dev for headers)


#  set(MYSDL2LIB "/usr/sgug-flx/lib32/libSDL2-2.0.so.0")
#  set(MYSDL2LIB "${CMAKE_SOURCE_DIR}/lib/libSDL2-2.0.so.0")

# 1. Priority 1: Check /usr/sgug-flx/lib32/
set(SGUGFLX_SDL2 "/usr/sgug-flx/lib32/libSDL2-2.0.so.0")
if(EXISTS "${SGUGFLX_SDL2}")
    set(MYSDL2LIB "${SGUGFLX_SDL2}")
# 2. Priority 2: Fallback to ./lib/
elseif(EXISTS "${CMAKE_SOURCE_DIR}/lib/libSDL2-2.0.so.0")
    set(MYSDL2LIB "${CMAKE_SOURCE_DIR}/lib/libSDL2-2.0.so.0")
else()
    message(FATAL_ERROR "SDL2 not found in /usr/sgug-flx/lib32 OR ${CMAKE_SOURCE_DIR}/lib")
endif()




  message(STATUS "Using SDL2: ${MYSDL2LIB}") 

  target_link_libraries(RetroEngine PRIVATE "${MYSDL2LIB}")

    set_target_properties(RetroEngine PROPERTIES
      BUILD_RPATH "\$ORIGIN/../lib"
    )

    target_link_libraries(RetroEngine PRIVATE
     GLcore
     audio
     pthread
    )

    target_compile_options(RetroEngine PRIVATE
      -I/usr/sgug/lib/gcc/mips-sgi-irix6.5/9/include
      -I/usr/include
      -I/usr/sgug/include
      -I/usr/sgug/include/SDL2
    )

    target_link_options(RetroEngine PRIVATE
      -Wl,--disable-new-dtags
      -Wl,-rpath,$ORIGIN/lib     # ONLY your lib directory
      -Wl,--allow-shlib-undefined
      -Wl,-rpath-link=/usr/lib32
      -Wl,-rpath=/usr/sgug-flx/lib32:./lib:../lib:/usr/lib32:/usr/sgug/lib32
    )

    target_compile_options(RetroEngine PRIVATE
     -I/usr/sgug/lib/gcc/mips-sgi-irix6.5/9/include
     -I/usr/include
     -I/usr/sgug/include
    )
 
 

elseif(RETRO_SDL_VERSION STREQUAL "1")
    pkg_check_modules(SDL1 sdl1 REQUIRED)
    target_link_libraries(RetroEngine ${SDL1_STATIC_LIBRARIES})
    target_link_options(RetroEngine PRIVATE ${SDL1_STATIC_LDLIBS_OTHER})
    target_compile_options(RetroEngine PRIVATE ${SDL1_STATIC_CFLAGS})
endif()

if(RETRO_MOD_LOADER)
    set_target_properties(RetroEngine PROPERTIES
        CXX_STANDARD 17
        CXX_STANDARD_REQUIRED ON
    )
endif()
