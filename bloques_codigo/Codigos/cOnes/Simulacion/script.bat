ghdl -s ../../ffd/Fuentes/ffd.vhd  ../../BCD_counter/Fuentes/BCD_counter.vhd   ../Fuentes/cOnes.vhd ../Fuentes/cOnes_tb.vhd
ghdl -a ../../ffd/Fuentes/ffd.vhd ../Fuentes/ADC_SD.vhd ../Fuentes/ADC_SD_tb.vhd
ghdl -e cOnes_tb
ghdl -r cOnes_tb --vcd=cOnes_tb.vcd --stop-time=1000ns
gtkwave cOnes_tb.vcd