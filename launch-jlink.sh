#!/bin/sh

# Define the path to the SEGGER J-Link GDB Server executable
JLINK_GDB_SERVER="JLinkGDBServer"


# Define the arguments for the J-Link GDB server
JLINK_ARGS="-select USB -device AT91SAM9G20 -if JTAG -speed adaptive"

# Execute the J-Link GDB server with the specified arguments
"$JLINK_GDB_SERVER" $JLINK_ARGS
