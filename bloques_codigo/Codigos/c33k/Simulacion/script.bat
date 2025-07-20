ghdl -s ../../ffd/Fuentes/ffd.vhd ../../cont_bin_gen/Fuentes/cont_bin_gen.vhd  ../Fuentes/c33k.vhd ../Fuentes/c33k_tb.vhd
ghdl -a ../../ffd/Fuentes/ffd.vhd ../../cont_bin_gen/Fuentes/cont_bin_gen.vhd  ../Fuentes/c33k.vhd ../Fuentes/c33k_tb.vhd
ghdl -e c33k_tb
ghdl -r c33k_tb --vcd=c33k_tb.vcd --stop-time=1000ns
gtkwave c33k_tb.vcd
