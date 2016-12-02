find_program(nrfjprog "nrfjprog")
IF(NOT nrfjprog)
	message([warning] "Nrfjprog not found. This program is nessecery to flash a nrf chip. Please install this program before continuing.")
ENDIF()



enable_language(ASM)
enable_language(C)

SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS)

link_directories(targets/nordic/nrf52/deps)

include_directories(
	targets/nordic/nrf52/deps
        /home/carlos/gits/Kvasir/Lib
        )
add_definitions(-DNRF52)

set(CMAKE_CXX_FLAGS
        "${CMAKE_CXX_FLAGS} -mcpu=cortex-m4 -mthumb -mabi=aapcs -mfpu=fpv4-sp-d16 -mfloat-abi=hard"
)

set(CMAKE_C_FLAGS
        "${CMAKE_CXX_FLAGS}"
)



set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Tnrf52_xxaa.ld")

add_executable(${PROJECT_NAME}.elf
        targets/nordic/nrf52/deps/system_nrf52.c
        targets/nordic/nrf52/deps/gcc_startup_nrf52.s
	${sources}
	)

add_custom_target(${PROJECT_NAME}.hex DEPENDS ${PROJECT_NAME}.elf COMMAND ${OBJCOPY} -Oihex ${PROJECT_NAME}.elf ${PROJECT_NAME}.hex)
add_custom_target(${PROJECT_NAME}.bin DEPENDS ${PROJECT_NAME}.elf COMMAND ${OBJCOPY} -Obinary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin)

IF(nrfjprog)
	add_custom_target(flash DEPENDS ${PROJECT_NAME}.hex 
	        COMMAND nrfjprog -f NRF52 --program ${PROJECT_NAME}.hex --chiperase --verify
        	COMMAND nrfjprog -f NRF52 --reset
	)
else()
	add_custom_target(flash
		COMMAND echo "nrfjprog not in path. Add to path and run cmake again."
	)
endif()
