ghdl -s  ../Fuentes/comp_Nb.vhd ../Fuentes/comp_Nb_tb.vhd
ghdl -a  ../Fuentes/comp_Nb.vhd ../Fuentes/comp_Nb_tb.vhd
ghdl -e comp_Nb_tb
ghdl -r comp_Nb_tb --vcd=comp_Nb_tb.vcd --stop-time=1000ns
gtkwave comp_Nb_tb.vcd
