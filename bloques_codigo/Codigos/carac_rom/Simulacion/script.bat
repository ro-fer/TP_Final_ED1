ghdl -s ../Fuentes/carac_rom.vhd ../Fuentes/carac_rom_tb.vhd
ghdl -a ../Fuentes/carac_rom.vhd ../Fuentes/carac_rom_tb.vhd
ghdl -e carac_rom_tb
ghdl -r carac_rom_tb--vcd=carac_rom_tb.vcd --stop-time=1000ns
gtkwave carac_rom_tb.vcd
