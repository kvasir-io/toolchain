#find_program(nrfjprog "nrfjprog")
#IF(NOT nrfjprog)
#	message([warning] "Nrfjprog not found. This program is nessecery to flash a nrf chip. Please install this program before continuing.")
#ENDIF()



enable_language(ASM)
enable_language(C)

SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS)

link_directories(${toolchain}/targets/arm32/cm4/nxp/kinetis/k/k64f/deps)

include_directories(
        ${toolchain}/targets/arm32/cm4/nxp/kinetis/k/k64f/deps
	#        ${toolchain}/targets/arm32/cm4/nordic/nrf/deps
        ${toolchain}/targets/arm32/cm4/deps
        )
add_definitions(-DCPU_MK64FN1M0VLL12)

set(CMAKE_CXX_FLAGS
        "${CMAKE_CXX_FLAGS} -DCPU_MK64FN1M0VLL12 -g -O0 -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -mthumb -MMD -MP -fno-common -ffunction-sections -fdata-sections -ffreestanding -fno-builtin -mapcs -fno-rtti -fno-exceptions"
)

set(CMAKE_C_FLAGS
        "${CMAKE_CXX_FLAGS}"
)



set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -TMK64FN1M0xxx12_flash.ld -g -flto -mcpu=cortex-m4 -Wall -mfloat-abi=hard -mfpu=fpv4-sp-d16 --specs=nano.specs --specs=nosys.specs -fno-common -ffunction-sections -fdata-sections -ffreestanding -fno-builtin -mthumb -mapcs -Xlinker --gc-sections -Xlinker -static -Xlinker -z -Xlinker muldefs")

add_executable(${PROJECT_NAME}.elf
	#${toolchain}/targets/arm32/cm4/nxp/kinetis/k/k64f/deps/arm_startup_MK64F12.S
        ${toolchain}/targets/arm32/cm4/nxp/kinetis/k/k64f/deps/gcc_startup_MK64F12.S
        ${toolchain}/targets/arm32/cm4/nxp/kinetis/k/k64f/deps/system_MK64F12.c
	#        ${toolchain}/targets/arm32/cm4/nordic/nrf/nrf52/deps/gcc_startup_MK64F12.S
	#        ${toolchain}/targets/arm32/cm4/nordic/nrf/nrf52/deps/gcc_startup_nrf52.s
	${sources}
	)

add_custom_target(${PROJECT_NAME}.hex DEPENDS ${PROJECT_NAME}.elf COMMAND ${OBJCOPY} -Oihex ${PROJECT_NAME}.elf ${PROJECT_NAME}.hex)
add_custom_target(${PROJECT_NAME}.bin DEPENDS ${PROJECT_NAME}.elf COMMAND ${OBJCOPY} -Obinary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin)
