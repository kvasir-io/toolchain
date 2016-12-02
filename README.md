# Kvasir toolchain

Kvasir toolchain is a cmake based toolchain with support for diffrent micrcocontrollers. 

## Setting up
To use Kvasir toolchain you've to add the following lines to your CmakeLists.txt:

First set the path where the toolchain is located:
`set(toolchain /home/carlos/gits/kvasir_toolchain)`

Them you add the compiler file of choice. You could use one of the compilers in the compiler folder or write your own.
`include(compilers/arm-none-eabi.cmake)`

Include the target you want to build for:
`include(targets/arm32/cm4/nordic/nrf/nrf52/nrf52.cmake)`

Optionaly you could add a flashscript:
`include(targets/arm32/cm4/nordic/nrf/nrf52/flashscripts/nrfjprog.cmake)`

## Make targets
After setting up the toolchain there are multiple make targets that perform diffrent operations.

`make`
Running make without any parameters, the source will be build to a .elf file. 

`make flash`
If you have included a flashscript you could use make flash to build your sources and flash it to the chip.

## Contributing
If you want to contribute by adding a chip or flashfile please copy one of the excisting chip cmake files and edit it for the new chip. Try to keep to the current structure and create a pull request to get feedback. Thanks in advance.
