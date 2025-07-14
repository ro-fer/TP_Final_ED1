-- Testbench para Prueba 0
-- Estudiante: Fernández, Rocío

library IEEE;
use IEEE.std_logic_1164.all;

entity prueba0_tb is
end;

architecture sim of prueba0_tb is

    component prueba0 is
        port (
            clk_i          : in std_logic;
            rst_i          : in std_logic;
            data_volt_in_i : in std_logic;
            data_volt_out_o: out std_logic;
            hs_o           : out std_logic;
            vs_o           : out std_logic;
            red_o          : out std_logic;
            grn_o          : out std_logic;
            blu_o          : out std_logic
        );
    end component;

    signal clk_i          : std_logic := '0';
    signal rst_i          : std_logic := '1';
    signal data_volt_in_i : std_logic := '0';
    signal data_volt_out_o: std_logic;
    signal hs_o           : std_logic;
    signal vs_o           : std_logic;
    signal red_o          : std_logic;
    signal grn_o          : std_logic;
    signal blu_o          : std_logic;

begin

    -- Clock de 25 MHz
    clk_gen : process
    begin
        while true loop
            clk_i <= '0';
            wait for 20 ns;
            clk_i <= '1';
            wait for 20 ns;
        end loop;
    end process;

    -- Estímulos iniciales
    stim_proc : process
    begin
        wait for 100 ns;
        rst_i <= '0';

        -- Simula una entrada binaria tipo onda cuadrada
        for i in 0 to 100 loop
            data_volt_in_i <= '1';
            wait for 50 ns;
            data_volt_in_i <= '0';
            wait for 50 ns;
        end loop;

        wait;
    end process;

    DUT: prueba0
        port map (
            clk_i          => clk_i,
            rst_i          => rst_i,
            data_volt_in_i => data_volt_in_i,
            data_volt_out_o=> data_volt_out_o,
            hs_o           => hs_o,
            vs_o           => vs_o,
            red_o          => red_o,
            grn_o          => grn_o,
            blu_o          => blu_o
        );

end architecture;