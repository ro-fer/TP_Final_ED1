ghdl -s ../../ffd/Fuentes/ffd.vhd ../Fuentes/cont_bin_gen.vhd ../Fuentes/cont_bin_gen_tb.vhd
ghdl -a ../../ffd/Fuentes/ffd.vhd ../Fuentes/cont_bin_gen.vhd ../Fuentes/cont_bin_gen_tb.vhd
ghdl -e cont_bin_gen_tb
ghdl -r cont_bin_gen_tb --vcd=cont_bin_gen_tb.vcd --stop-time=1000ns
gtkwave cont_bin_gen_tb.vcd
