ghdl -s ../../ffd/Fuentes/ffd.vhd ../../cont_bin_gen/Fuentes/cont_bin_gen.vhd ../../comp_Nb/Fuentes/comp_Nb.vhd  ../Fuentes/hsync.vhd ../Fuentes/hsync_tb.vhd
ghdl -a ../../ffd/Fuentes/ffd.vhd ../../cont_bin_gen/Fuentes/cont_bin_gen.vhd ../../comp_Nb/Fuentes/comp_Nb.vhd  ../Fuentes/hsync.vhd ../Fuentes/hsync_tb.vhd
ghdl -e hsync_tb
ghdl -r hsync_tb --vcd=hsync_tb.vcd --stop-time=90000ns
gtkwave hsync_tb.vcd
