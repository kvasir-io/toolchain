find_program(nrfjprog "nrfjprog")
IF(NOT nrfjprog)
	message([warning] "Nrfjprog not found. This program is nessecery to flash a nrf chip. Please install this program before continuing.")
ENDIF()



enable_language(ASM)
enable_language(C)

SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS)

link_directories(${toolchain}/targets/arm32/cm4/nordic/nrf/nrf52/deps)

include_directories(
        ${toolchain}/targets/arm32/cm4/nordic/nrf/nrf52/deps
        ${toolchain}/targets/arm32/cm4/nordic/nrf/deps
        ${toolchain}/targets/arm32/cm4/deps
        )
add_definitions(-DNRF52)

set(CMAKE_CXX_FLAGS
        "${CMAKE_CXX_FLAGS} -Os -mcpu=cortex-m4 -mthumb -mabi=aapcs -mfpu=fpv4-sp-d16 -mfloat-abi=hard"
)

set(CMAKE_C_FLAGS
        "${CMAKE_CXX_FLAGS}"
)



set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Tnrf52_xxaa.ld")

add_executable(${PROJECT_NAME}.elf
        ${toolchain}/targets/arm32/cm4/nordic/nrf/nrf52/deps/system_nrf52.c
        ${toolchain}/targets/arm32/cm4/nordic/nrf/nrf52/deps/gcc_startup_nrf52.s
	${sources}
	)

add_custom_target(${PROJECT_NAME}.hex DEPENDS ${PROJECT_NAME}.elf COMMAND ${OBJCOPY} -Oihex ${PROJECT_NAME}.elf ${PROJECT_NAME}.hex)
add_custom_target(${PROJECT_NAME}.bin DEPENDS ${PROJECT_NAME}.elf COMMAND ${OBJCOPY} -Obinary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin)
