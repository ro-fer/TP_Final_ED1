entity Voltimetro_tb is 
end;

architecture Voltimetro_tb_arq of Voltimetro_tb is 
    
    component Voltimetro is 
        port(
            clk_volti   : in bit;
            rst_volti   : in bit;
            voltaje_i   : in bit;   -- tension de entrada, va al dato de ingreso del FFD de entrada
            voltaje_s   : out bit;  -- salida negada del FFD de entrada
            ena : in bit;
            hs_o        : out bit;
            vs_o        : out bit;
            r_o         : out bit;
            g_o         : out bit;
            b_o         : out bit
        );
    end component;

    signal clk_volti_tb : bit := '0';
    signal rst_volti_tb : bit := '0';
    signal voltaje_i_tb : bit := '0';
    signal voltaje_s_tb : bit := '0';
    signal hs_o_tb      : bit := '0';
    signal vs_o_tb      : bit := '0';
    signal r_o_tb       : bit := '0';
    signal g_o_tb       : bit := '0';
    signal b_o_tb       : bit := '0';
    signal ena_tb       : bit := '0';

begin

    clk_volti_tb <= not clk_volti_tb after 5 ns;
	ena_tb <= '1' after 5 ns;
    voltaje_i_tb <= voltaje_s_tb;
    DUT: Voltimetro
        port map(
            clk_volti   => clk_volti_tb,
            rst_volti   => rst_volti_tb,
            voltaje_i   => voltaje_i_tb,
            voltaje_s   => voltaje_s_tb,
            ena         => ena_tb,
            hs_o        => hs_o_tb,
            vs_o        => vs_o_tb,
            r_o         => r_o_tb,
            g_o         => g_o_tb,
            b_o         => b_o_tb
        );
end;
