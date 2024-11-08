cmake_minimum_required(VERSION 3.16)
project(GlobusSatProject C)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_C_COMPILER "arm-none-eabi-gcc")
set(CMAKE_OBJCOPY "arm-none-eabi-objcopy")
set(CMAKE_SIZE "arm-none-eabi-size")

# Set the target CPU and compiler options
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mcpu=arm926ej-s -O0 -ffunction-sections -Wall -Wextra -g -Dat91sam9g20")

add_compile_options(-Wno-bidi-chars)

# Specify the linker script and directories for libraries
set(LINKER_SCRIPT "${CMAKE_SOURCE_DIR}/hal/at91/linker-scripts/sdram.lds")
set(LIB_DIRS "${CMAKE_SOURCE_DIR}/hal/at91/lib"
             "${CMAKE_SOURCE_DIR}/satellite-subsystems/satellite-subsystems/lib"
             "${CMAKE_SOURCE_DIR}/hal/hcc/lib"
             "${CMAKE_SOURCE_DIR}/hal/freertos/lib"
             "${CMAKE_SOURCE_DIR}/hal/hal/lib"
           )

# Add libraries
set(LIBS HALD HCCD SatelliteSubsystemsD FreeRTOSD At91D)

# Find all source files in src directory and its subdirectories
file(GLOB_RECURSE SOURCE_FILES "${CMAKE_SOURCE_DIR}/src/*.c")
list(FILTER SOURCE_FILES EXCLUDE REGEX "${CMAKE_SOURCE_DIR}/src/TestingDemos/.*")

# Define the executable target
add_executable(GlobusSatProject.elf ${SOURCE_FILES})

target_include_directories(GlobusSatProject.elf PRIVATE 
             "${CMAKE_SOURCE_DIR}/hal/at91/include"
             "${CMAKE_SOURCE_DIR}/satellite-subsystems/satellite-subsystems/include"
             "${CMAKE_SOURCE_DIR}/hal/hcc/include"
             "${CMAKE_SOURCE_DIR}/hal/freertos/include"
             "${CMAKE_SOURCE_DIR}/hal/hal/include"
             "${CMAKE_SOURCE_DIR}/src"
           )

# Link the libraries and set linker options
target_link_libraries(GlobusSatProject.elf ${LIBS})
target_link_options(GlobusSatProject.elf PRIVATE 
    "-T${LINKER_SCRIPT}"
    "-Wl,-Map=GlobusSatProject.map"
    "-nostartfiles"
    "-Xlinker" "--gc-sections"
    "-lc" "-u _printf_float" "-u _scanf_float"
)

# Specify library search directories
target_link_directories(GlobusSatProject.elf PRIVATE ${LIB_DIRS})

# Define custom commands for creating the .bin and .siz files
add_custom_command(TARGET GlobusSatProject.elf POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:GlobusSatProject.elf> GlobusSatProject.bin
    COMMENT "Creating GlobusSatProject.bin"
)

add_custom_command(TARGET GlobusSatProject.elf POST_BUILD
    COMMAND ${CMAKE_SIZE} --format=berkeley $<TARGET_FILE:GlobusSatProject.elf>
    COMMENT "Calculating size of GlobusSatProject.elf"
)

# Add clean up command
add_custom_target(clean-all
    COMMAND ${CMAKE_COMMAND} -E rm -rf ${CMAKE_BINARY_DIR}/*
    COMMENT "Cleaning up generated files"
)
