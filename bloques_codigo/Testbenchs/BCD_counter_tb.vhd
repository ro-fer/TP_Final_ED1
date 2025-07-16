-- Test contador BCD

entity contador_bcd_tb is
end;

architecture contador_bcd_tb_arq of contador_bcd_tb is 

    component contador_bcd is 

        port(
            clk_bcd : in bit;
            ena_bcd : in bit;
            rst_bcd : in bit;
            q_bcd   : out bit_vector(3 downto 0)
        );
    end component;

    signal rst_bcd_tb   : bit := '0';
    signal clk_bcd_tb   : bit := '0';
    signal ena_bcd_tb   : bit := '0';
    signal q_bcd_tb     : bit_vector(3 downto 0) := "0000";

begin 

    ena_bcd_tb <= '1' after 10 ns, '0' after 100 ns, '1' after 120 ns; 
    rst_bcd_tb <= '1' after 30 ns, '0' after 50 ns, '1' after 450 ns;
    clk_bcd_tb <= not clk_bcd_tb after 5 ns;

    DUT: contador_bcd 
        port map(
            clk_bcd => clk_bcd_tb,
            rst_bcd => rst_bcd_tb,
            ena_bcd => ena_bcd_tb,
            q_bcd   => q_bcd_tb
        );
end;