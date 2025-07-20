ghdl -s ../../ffd/Fuentes/ffd.vhd ../../cont_bin_gen/Fuentes/cont_bin_gen.vhd ../../comp_Nb/Fuentes/comp_Nb.vhd  ../../vsync/Fuentes/vsync.vhd ../../hsync/Fuentes/hsync.vhd   ../../mux_color/Fuentes/mux_color.vhd    ../../mux_selector/Fuentes/mux_selector.vhd  ../../mux/Fuentes/mux.vhd  ../Fuentes/vga_controller.vhd ../Fuentes/vga_controller_tb.vhd
ghdl -a ../../ffd/Fuentes/ffd.vhd ../../cont_bin_gen/Fuentes/cont_bin_gen.vhd ../../comp_Nb/Fuentes/comp_Nb.vhd  ../../vsync/Fuentes/vsync.vhd ../../hsync/Fuentes/hsync.vhd   ../../mux_color/Fuentes/mux_color.vhd    ../../mux_selector/Fuentes/mux_selector.vhd  ../../mux/Fuentes/mux.vhd  ../Fuentes/vga_controller.vhd ../Fuentes/vga_controller_tb.vhd
ghdl -e vga_controller_tb
ghdl -r vga_controller_tb --vcd=vga_controller_tb.vcd --stop-time=50ms
gtkwave vga_controller_tb.vcd

