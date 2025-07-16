-- Test Voltimetro

entity volti_tb is 
end;

architecture volti_tb_arq of volti_tb is 
    
    component volti is 
        port(
            --ena_volti   : in bit;
            clk_volti   : in bit;
            rst_volti   : in bit;
            voltaje_i   : in bit;   -- tension de entrada, va al dato de ingreso del FFD de entrada
            voltaje_s   : out bit;  -- salida negada del FFD de entrada
            hs_o        : out bit;
            vs_o        : out bit;
            r_o         : out bit;
            g_o         : out bit;
            b_o         : out bit
        );
    end component;

    --signal ena_volti_tb : bit := '0';
    signal clk_volti_tb : bit := '0';
    signal rst_volti_tb : bit := '0';
    signal voltaje_i_tb : bit := '0';
    signal voltaje_s_tb : bit := '0';
    signal hs_o_tb      : bit := '0';
    signal vs_o_tb      : bit := '0';
    signal r_o_tb       : bit := '0';
    signal g_o_tb       : bit := '0';
    signal b_o_tb       : bit := '0';

begin

    clk_volti_tb <= not clk_volti_tb after 10 ns;
    --ena_volti_tb <= '1' after 5 ns;
    voltaje_i_tb <= voltaje_s_tb;

    DUT: volti
        port map(
            --ena_volti   => ena_volti_tb,
            clk_volti   => clk_volti_tb,
            rst_volti   => rst_volti_tb,
            voltaje_i   => voltaje_i_tb,
            voltaje_s   => voltaje_s_tb,
            hs_o        => hs_o_tb,
            vs_o        => vs_o_tb,
            r_o         => r_o_tb,
            g_o         => g_o_tb,
            b_o         => b_o_tb
        );
end;