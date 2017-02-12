find_program(bossac "bossac")
IF(NOT bossac)
	message([warning] "bossac not found. This program is nessecery to flash the Arduino Due chip. Please install this program and add it to your path before continuing.")
ENDIF()

enable_language(ASM)
enable_language(C)

SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS)

link_directories(${toolchain}/targets/arm32/cm3/atmel/sam3x/sam3x8e/deps)

include_directories(
        ${toolchain}/targets/arm32/cm3/deps
        ${toolchain}/targets/arm32/cm3/atmel/sam3x/deps
        ${toolchain}/targets/arm32/cm3/atmel/sam3x/deps/include
        ${toolchain}/targets/arm32/cm3/atmel/sam3x/deps/source/templates
        ${toolchain}/targets/arm32/cm3/atmel/sam3x/deps/source/templates/gcc
        ${toolchain}/targets/arm32/cm3/atmel/sam3x/deps/source/templates
        ${toolchain}/targets/arm32/cm3/atmel/sam3x/sam3x8e/deps
        )
add_definitions(-D__SAM3X8E__)
add_definitions(-DDONT_USE_CMSIS_INIT)


set(CMAKE_CXX_FLAGS
        #"${CMAKE_CXX_FLAGS} -mcpu=cortex-m4 -mthumb -mabi=aapcs -mfpu=fpv4-sp-d16 -mfloat-abi=hard"
        "${CMAKE_CXX_FLAGS} -mcpu=cortex-m3 -mthumb"
)

set(CMAKE_C_FLAGS
        "${CMAKE_CXX_FLAGS}"
)

#Ik geloof dat dat het goeie flash script is
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}-Tflash.ld -Wl,--gc-sections -Wl,--entry=Reset_Handler")

add_executable(${PROJECT_NAME}.elf
        ${toolchain}/targets/arm32/cm3/atmel/sam3x/deps/source/templates/gcc/startup_sam3x.c
        # ${toolchain}/targets/arm32/cm3/atmel/sam3x/deps/include/sam3x8e.h
	${sources}
	)

add_custom_target(${PROJECT_NAME}.hex DEPENDS ${PROJECT_NAME}.elf COMMAND ${OBJCOPY} -Oihex ${PROJECT_NAME}.elf ${PROJECT_NAME}.hex)
add_custom_target(${PROJECT_NAME}.bin DEPENDS ${PROJECT_NAME}.elf COMMAND ${OBJCOPY} -Obinary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin)
