enable_language(ASM)
enable_language(C)

SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS)

link_directories(${toolchain}/targets/arm32/cm3/atmel/sam3x/sam3x8e/deps)

include_directories(
        ${toolchain}/targets/arm32/cm3/deps
        ${toolchain}/targets/arm32/cm3/atmel/sam3x/deps
)

add_definitions(-D__SAM3X8E__)
add_definitions(-DDONT_USE_CMSIS_INIT)

set(compile_flags "-mcpu=cortex-m3 -mthumb -fomit-frame-pointer -march=armv7-m")

set(CMAKE_CXX_FLAGS
        "${CMAKE_CXX_FLAGS} ${compile_flags} -fno-exceptions"
)

set(CMAKE_C_FLAGS
        "${CMAKE_C_FLAGS} ${compile_flags}"
)

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Tsam3x8e_flash.ld -Wl,--gc-sections")

add_executable(${PROJECT_NAME}.elf
        ${toolchain}/targets/arm32/cm3/atmel/sam3x/sam3x8e/deps/startup_sam3xa.c
	    ${sources}
)

add_custom_target(${PROJECT_NAME}.hex DEPENDS ${PROJECT_NAME}.elf COMMAND ${OBJCOPY} -Oihex ${PROJECT_NAME}.elf ${PROJECT_NAME}.hex)
add_custom_target(${PROJECT_NAME}.bin DEPENDS ${PROJECT_NAME}.elf COMMAND ${OBJCOPY} -Obinary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin)
