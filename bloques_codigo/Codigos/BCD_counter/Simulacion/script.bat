ghdl -s ../../ffd/Fuentes/ffd.vhd ../Fuentes/BCD_counter.vhd ../Fuentes/BCD_counter_tb.vhd
ghdl -a ../../ffd/Fuentes/ffd.vhd ../Fuentes/BCD_counter.vhd ../Fuentes/BCD_counter_tb.vhd
ghdl -e BCD_counter_tb
ghdl -r BCD_counter_tb --vcd=BCD_counter_tb.vcd --stop-time=1000ns
gtkwave BCD_counter_tb.vcd
