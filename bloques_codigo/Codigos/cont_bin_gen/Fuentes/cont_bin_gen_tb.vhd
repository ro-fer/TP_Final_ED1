-- TEST DEL CONTADOR BINARIO GENERICO


entity cont_bin_gen_tb is
end;

architecture cont_bin_gen_tb_arq of cont_bin_gen_tb is 

    component cont_bin_gen is 
        generic(
            N: natural := 16 
        );
    
        port (
            clk_bin_gen : in bit;
            ena_bin_gen : in bit;
            rst_bin_gen : in bit;
            salida_gen  : out bit_vector(N-1 downto 0)
        );
    end component;

    constant N_tb   : natural := 16;
    signal rst_tb   : bit;
    signal ena_tb   : bit;
    signal clk_tb   : bit;
    signal salida   : bit_vector(N_tb-1 downto 0) := (N_tb-1 downto 0 => '0');

begin
    ena_tb <= '1' after 10 ns;
    clk_tb <= not clk_tb after 5 ns;
    -- rst_tb <= '1' after 80 ns, '0' after 110 ns; -- rest de sistema

    DUT: cont_bin_gen
        generic map(
            N => N_tb
        )

        port map (
            clk_bin_gen => clk_tb,
            ena_bin_gen => ena_tb,
            rst_bin_gen => rst_tb,
            salida_gen  => salida
        );
end;