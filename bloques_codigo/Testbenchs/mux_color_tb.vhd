-- Test MUX color

entity mux_color_tb is 
end;

architecture mux_color_tb_arq of mux_color_tb is 

    component mux_color is 
        port(
            RGB : in bit;
            B   : in bit;
            sel : in bit;
            sal : out bit
        );
    end component;

    signal RGB_tb   : bit := '0';
    signal B_tb     : bit := '0';
    signal sel_tb   : bit := '0';
    signal sal_tb   : bit := '0';

begin 

    -- le paso un color, si el selector es 1 me saca el color (RGB), si el selector es 0 saca B
    RGB_tb  <= '1' after 20 ns;
    B_tb    <= '1' after 10 ns;
    sel_tb  <= '0' after 20 ns, '1' after 30 ns, '0' after 40 ns;

    DUT: mux_color
        port map(
            RGB => RGB_tb,
            B   => B_tb, 
            sel => sel_tb,
            sal => sal_tb
        );
end;