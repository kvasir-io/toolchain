# Kvasir::toolchain
This toolchain is part of the Kvasir project. Kvasir is a collection
of zero cost statically checked libraries for resource constrained
systems including microcontrollers. More information at
[kvasir.io](http://kvasir.io).

## Introduction
Kvasir toolchain is a cmake based toolchain with support for different
microcontrollers. It supports flashing for most supported chips.

## How to setup
To use the Kvasir toolchain, copy the
[example CMakeLists](/CMakeLists.txt.example) to your project
directory, or add the contents to your existing CMakeLists.txt.

The CMakeLists file contains several parameters that need to be
adjusted to your environment:

```cmake
# Where the toolchain is located on your pc.
set(toolchain ~/kvasir_toolchain) # Your path to kvasir-toolchain (this repository).

# The target chip that is compiled for:
include(${toolchain}/targets/arm32/cm4/nordic/nrf/nrf52/nrf52.cmake)

# The flashscript used to flash the binary (optional):
include(${toolchain}/targets/arm32/cm4/nordic/nrf/nrf52/flashscripts/nrfjprog.cmake)
```

For the compiler, target chip and flash script, you can use any of the
cmake files available in this repository (see Directory Structure), or
you can add your own.

## How to use
After setting up the CMakeLists.txt file, create a `build` directory
within your project directory and generate a Makefile using the
following comands:

```bash
mkdir build
cd build
cmake -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=<YOUR_PATH> ..
```

In the above cmake command, replace `<YOUR_PATH>` with a path to the
compiler toolchain cmake file you wish to use.
For example, if you've cloned Kvasir toolchain to `~/kvasir-toolchain`
and your target is `arm-none-eabi`, the command becomes:

    cmake -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE="~/kvasir-toolchain/compilers/arm-none-eabi.cmake" ..


In your build directory, run `make` to compile the source into an ELF
file.

If you've included a flash script, running `make flash` will create a
binary and flash your microcontroller.

## Directory structure
On the toplevel, the toolchain contains the following two directories:

### `compiler`
This contains cmake files for setting the compiler toolchain to be used.

### `targets`
The targets directory contains target cmake files and dependencies for
specific microcontrollers.

This directory hierarchy is ordered by architecture
(e.g. `arm32/cm3`), vendor (`atmel`), and then microcontroller model
(`sam3x/sam3x8e`).

Microcontroller-specific headers, startup code and linker scripts are
stored in the `deps` folders in the deepest levels of `/targets`. More
generic dependencies live in `deps` folders on higher levels.

## Contributing
If you want to contribute by adding a chip or flash script, please
copy one of the existing chip cmake files and edit it for the new
chip.
Try to keep to the current structure and create a pull request to get
feedback. Thanks in advance.

## Contributors
We'd like to thank the following contributors, in alphabetical order:

- Carlos van Rooijen ([@CvRXX](https://github.com/CvRXX))
- Chris Smeele ([@cjsmeele](https://github.com/cjsmeele))
- Jan Halsema ([@ManDeJan](https://github.com/ManDeJan))

## Maintainer
This library is maintained by Carlos van Rooijen
([@CvRXX](https://github.com/CvRXX)). Requests for push rights could
be addressed to him via kvasir (at) carlosvanrooijen.nl. The
maintainer is also the only one who could approve pull requests to
master.
