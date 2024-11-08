target remote localhost:2331
monitor flash breakpoints = 0
monitor flash download = 0
monitor AllowSimulation = 0
monitor endian little
monitor writeu32 0xFFFFEF1C = 0x00020000 # Set EBI Slew-Rate to slow and voltage to 1.8V
monitor sleep 10
monitor writeu32 0xFFFFFC20 = 0x00004001 # Enable main oscillator
monitor sleep 10
monitor writeu32 0xFFFFEF1C = 0x00020000 # Set EBI Slew-Rate to slow and voltage to 1.8V
monitor sleep 10
monitor writeu32 0xFFFFFC28 = 0x202A3F01 # Set PLLA to 800MHz
monitor sleep 10
monitor writeu32 0xFFFFFC2C = 0x10193F05 # Set PLLB for USB usage
monitor sleep 10
monitor writeu32 0xFFFFFC30 = 0x00001300 # Select prescaler
monitor sleep 10
monitor writeu32 0xFFFFFC30 = 0x00001302 # Select master clock
monitor sleep 10
echo "Master clock ok."
echo "Configuring the SDRAM controller..."
monitor writeu32 0xFFFFEF1C = 0x2 # Enable EBI chip select for the SDRAM
monitor writeu32 0xFFFFF870 = 0xFFFF0000 # Enable PC16-PC31 pins
monitor writeu32 0xFFFFF874 = 0x00000000 # Enable PC16-PC31 pins
monitor writeu32 0xFFFFF804 = 0xFFFF0000 # Enable PC16-PC31 pins
monitor writeu32 0xFFFFEA08 = 0xF7339375 # SDRAM configuration for 32MB
monitor writeu32 0xFFFFEA00 = 0x1
monitor writeu32 0x20000000 = 0
monitor writeu32 0xFFFFEA00 = 0x2
monitor writeu32 0x20000000 = 0
monitor writeu32 0xFFFFEA00 = 0x4
monitor writeu32 0x20000000 = 0
monitor writeu32 0xFFFFEA00 = 0x4
monitor writeu32 0x20000000 = 0
monitor writeu32 0xFFFFEA00 = 0x4
monitor writeu32 0x20000000 = 0
monitor writeu32 0xFFFFEA00 = 0x4
monitor writeu32 0x20000000 = 0
monitor writeu32 0xFFFFEA00 = 0x4
monitor writeu32 0x20000000 = 0
monitor writeu32 0xFFFFEA00 = 0x4
monitor writeu32 0x20000000 = 0
monitor writeu32 0xFFFFEA00 = 0x3
monitor writeu32 0x20000000 = 0
monitor writeu32 0xFFFFEA00 = 0x0
monitor writeu32 0x20000000 = 0
monitor writeu32 0xFFFFEA04 = 0x39D
echo "SDRAM configuration ok."
monitor flash breakpoints = 0
monitor flash download = 0
monitor AllowSimulation = 0
load build/GlobusSatProject.elf 
break main
continue
