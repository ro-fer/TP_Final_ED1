library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Voltimetro_toplevel_tb is
end entity;

architecture sim of Voltimetro_toplevel_tb is

    -- Componente bajo prueba (DUT)
    component Voltimetro_toplevel is
        port(
            clk_i           : in std_logic;
            rst_i           : in std_logic;
            data_volt_in_i  : in std_logic;
            data_volt_out_o : out std_logic;
            hs_o            : out std_logic;
            vs_o            : out std_logic;
            red_o           : out std_logic;
            grn_o           : out std_logic;
            blu_o           : out std_logic
        );
    end component;

    -- Señales internas para conectar al DUT
    signal clk_tb           : std_logic := '0';
    signal rst_tb           : std_logic := '1';
    signal data_volt_in_tb  : std_logic := '0';
    signal data_volt_out_tb : std_logic;
    signal hs_tb            : std_logic;
    signal vs_tb            : std_logic;
    signal red_tb           : std_logic;
    signal grn_tb           : std_logic;
    signal blu_tb           : std_logic;

begin

    -- Instancia del DUT
    DUT: Voltimetro_toplevel
        port map (
            clk_i           => clk_tb,
            rst_i           => rst_tb,
            data_volt_in_i  => data_volt_in_tb,
            data_volt_out_o => data_volt_out_tb,
            hs_o            => hs_tb,
            vs_o            => vs_tb,
            red_o           => red_tb,
            grn_o           => grn_tb,
            blu_o           => blu_tb
        );

    -- Generador de clock de 100 MHz (10 ns de período)
    clk_process : process
    begin
        while true loop
            clk_tb <= '0';
            wait for 5 ns;
            clk_tb <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Proceso de estímulo
    stim_proc : process
    begin
        -- Reset activo por 50 ns
        wait for 50 ns;
        rst_tb <= '0';

        -- Simular señal cuadrada de ADC durante 2 ms
        for i in 0 to 999 loop
            data_volt_in_tb <= '1';
            wait for 100 ns;
            data_volt_in_tb <= '0';
            wait for 100 ns;
        end loop;

        wait;
    end process;

end architecture;
