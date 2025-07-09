--Test de ffd

-- Defino las variables 
-- descripcion --> prendo y apago el enable, el rst y dato ; antes activo el reloj

entity ffd_tb is
end;

architecture ffd_tb_arq of ffd_tb is 

    component ffd is 
        -- defino puertos de entrada y salida del componente a testear (ffd)
        port(
            clk_i   : in std_logic;
            rst_i   : in std_logic;
            ena_i   : in std_logic;
            d_i     : in std_logic;
            q_o     : out std_logic
        );
    end component;

    -- defino puertos del tb
    signal clk_i_tb   : bit := '0';
    signal rst_i_tb   : bit := '0';
    signal ena_i_tb   : bit := '0';
    signal d_i_tb   : bit := '0';
    signal q_o_tb   : bit := '0';

begin 
    ena_i_tb    <= '1' after 10 ns, '0' after 70 ns; 
	d_i_tb      <= '1' after 20 ns, '0' after 30 ns, '1' after 40 ns, '0' after 80 ns; 
	rst_i_tb    <= '1' after 50 ns, '0' after 60 ns; 
	clk_i_tb    <= not clk_i_tb after 5 ns; 

    DUT: ffd
        port map(
            clk_i => clk_i_tb,
            rst_i => rst_i_tb,
            ena_i => ena_i_tb,
            d_i => d_i_tb,
            q_o => q_o_tb
        );
end;