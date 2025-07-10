library IEEE;
use IEEE.std_logic_1164.all;

entity ADC_SD_tb is
end;

architecture sim of ADC_SD_tb is

    -- Componente a testear
    component ADC_SD is
        port(
            clk_i   : in std_logic;
            rst_i   : in std_logic;
            ena_i   : in std_logic;
            D_vi    : in std_logic;
            Q_fb    : out std_logic;
            Q_proc  : out std_logic
        );
    end component;

    -- Señales internas para el banco de pruebas
    signal clk_i_tb   : std_logic := '0';
    signal rst_i_tb   : std_logic := '1';
    signal ena_i_tb   : std_logic := '0';
    signal D_vi_tb    : std_logic := '0';
    signal Q_fb_tb    : std_logic;
    signal Q_proc_tb  : std_logic;

begin

    -- Instancia del DUT
    DUT: ADC_SD
        port map (
            clk_i   => clk_i_tb,
            rst_i   => rst_i_tb,
            ena_i   => ena_i_tb,
            D_vi    => D_vi_tb,
            Q_fb    => Q_fb_tb,
            Q_proc  => Q_proc_tb
        );

    -- Clock de 10 ns
    clk_process : process
    begin
        while true loop
            clk_i_tb <= '0';
            wait for 5 ns;
            clk_i_tb <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Estimulos
    stim_proc : process
    begin
        -- Reset inicial
        wait for 10 ns;
        rst_i_tb <= '0';

        -- Activar enable y enviar valores en D_vi
        ena_i_tb <= '1';
        D_vi_tb <= '1';
        wait for 20 ns;

        D_vi_tb <= '0';
        wait for 20 ns;

        D_vi_tb <= '1';
        wait for 20 ns;

        ena_i_tb <= '0';  -- desactivar enable
        D_vi_tb <= '0';
        wait;

    end process;

end architecture;
