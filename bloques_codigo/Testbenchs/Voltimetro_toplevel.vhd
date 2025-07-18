library IEEE;
use IEEE.bit_1164.all;
use IEEE.numeric_std.all;

entity Voltimetro_toplevel_tb is
end entity;

architecture sim of Voltimetro_toplevel_tb is

    -- Componente bajo prueba (DUT)
    component Voltimetro_toplevel is
        port(
            clk_i           : in bit;
            rst_i           : in bit;
            data_volt_in_i  : in bit;
            data_volt_out_o : out bit;
            hs_o            : out bit;
            vs_o            : out bit;
            red_o           : out bit;
            grn_o           : out bit;
            blu_o           : out bit
        );
    end component;

    -- Señales internas para conectar al DUT
    signal clk_tb           : bit := '0';
    signal rst_tb           : bit := '1';
    signal data_volt_in_tb  : bit := '0';
    signal data_volt_out_tb : bit;
    signal hs_tb            : bit;
    signal vs_tb            : bit;
    signal red_tb           : bit;
    signal grn_tb           : bit;
    signal blu_tb           : bit;

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
