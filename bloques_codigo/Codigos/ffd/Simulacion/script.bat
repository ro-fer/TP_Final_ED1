ghdl -s ../../ffd/Fuentes/ffd.vhd ../Fuentes/ADC_SD.vhd ../Fuentes/ADC_SD_tb.vhd
ghdl -a ../../ffd/Fuentes/ffd.vhd ../Fuentes/ADC_SD.vhd ../Fuentes/ADC_SD_tb.vhd
ghdl -e ADC_SD_tb
ghdl -r ADC_SD_tb --vcd=ADC_SD_tb.vcd --stop-time=1000ns
gtkwave ADC_SD_tb.vcd
