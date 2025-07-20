--Test de ffd


entity ffd_tb is
end;

architecture ffd_tb_arq of ffd_tb is 

    component ffd is 
        port(
            clk_i   : in bit;
            rst_i   : in bit;
            ena_i   : in bit;
            d_i     : in bit;
            q_o     : out bit
        );
    end component;

    -- seniales del testbench (USAR bit, no bit)
    signal clk_i_tb   : bit := '0';
    signal rst_i_tb   : bit := '0';
    signal ena_i_tb   : bit := '0';
    signal d_i_tb     : bit := '0';
    signal q_o_tb     : bit;

begin 
    ena_i_tb    <= '1' after 10 ns, '0' after 70 ns; 
    d_i_tb      <= '1' after 20 ns, '0' after 30 ns, '1' after 40 ns, '0' after 80 ns; 
    rst_i_tb    <= '1' after 50 ns, '0' after 60 ns;     
    clk_i_tb    <= not clk_i_tb after 5 ns; 
    

    -- DUT
    DUT: ffd
        port map(
            clk_i => clk_i_tb,
            rst_i => rst_i_tb,
            ena_i => ena_i_tb,
            d_i   => d_i_tb,
            q_o   => q_o_tb
        );
end architecture;