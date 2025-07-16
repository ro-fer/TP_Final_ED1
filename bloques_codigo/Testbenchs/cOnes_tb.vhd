--Test cones


entity cont_unos_tb is
end;

architecture cont_unos_tb_arq of cont_unos_tb is

    component cont_unos is 
        port (
            clk_unos:   in bit;
            rst_unos:   in bit;
            ena_unos:   in bit;
            q_bcd1:     out bit_vector(3 downto 0);
            q_bcd2:     out bit_vector(3 downto 0);
            q_bcd3:     out bit_vector(3 downto 0);
            q_bcd4:     out bit_vector(3 downto 0);
            q_bcd5:     out bit_vector(3 downto 0);
            q_bcd6:     out bit_vector(3 downto 0);
            q_bcd7:     out bit_vector(3 downto 0)
        );
    end component;

    signal salida_bcd1_tb :   bit_vector(3 downto 0) := (3 downto 0 => '0');
    signal salida_bcd2_tb :   bit_vector(3 downto 0) := (3 downto 0 => '0');
    signal salida_bcd3_tb :   bit_vector(3 downto 0) := (3 downto 0 => '0');
    signal salida_bcd4_tb :   bit_vector(3 downto 0) := (3 downto 0 => '0');
    signal salida_bcd5_tb :   bit_vector(3 downto 0) := (3 downto 0 => '0');
    signal salida_bcd6_tb :   bit_vector(3 downto 0) := (3 downto 0 => '0');
    signal salida_bcd7_tb :   bit_vector(3 downto 0) := (3 downto 0 => '0');

    signal clk_unos_tb  : bit := '0';
    signal rst_unos_tb  : bit := '0';
    signal ena_unos_tb  : bit := '0';

    begin

        ena_unos_tb <= '1' after 10 ns;
        clk_unos_tb <= not clk_unos_tb after 5 ns;
        
        rst_unos_tb <= '1' after 20 ns, '0' after 50 ns;

        DUT: cont_unos
            port map (
                clk_unos    => clk_unos_tb,
                rst_unos    => rst_unos_tb,
                ena_unos    => ena_unos_tb,
                q_bcd1      => salida_bcd1_tb,
                q_bcd2      => salida_bcd2_tb,
                q_bcd3      => salida_bcd3_tb,
                q_bcd4      => salida_bcd4_tb,
                q_bcd5      => salida_bcd5_tb,
                q_bcd6      => salida_bcd6_tb,
                q_bcd7      => salida_bcd7_tb
            );
    end;
    