ghdl -s ../../ffd/Fuentes/ffd.vhd ../../cont_bin_gen/Fuentes/cont_bin_gen.vhd ../../comp_Nb/Fuentes/comp_Nb.vhd  ../Fuentes/vsync.vhd ../Fuentes/vsync_tb.vhd
ghdl -a ../../ffd/Fuentes/ffd.vhd ../../cont_bin_gen/Fuentes/cont_bin_gen.vhd ../../comp_Nb/Fuentes/comp_Nb.vhd  ../Fuentes/vsync.vhd ../Fuentes/vsync_tb.vhd
ghdl -e vsync_tb
ghdl -r vsync_tb --vcd=vsync_tb.vcd --stop-time=90000ns
gtkwave vsync_tb.vcd
