-- Prueba 0 
-- Estudiante: Fernández, Rocío

library IEEE;
use IEEE.std_logic_1164.all;

entity prueba0 is
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
end;

architecture estructural of prueba0 is

    component Voltimetro is
        port (
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

begin

    DUT: Voltimetro
        port map (
            clk_i           => clk_i,
            rst_i           => rst_i,
            data_volt_in_i  => data_volt_in_i,
            data_volt_out_o => data_volt_out_o,
            hs_o            => hs_o,
            vs_o            => vs_o,
            red_o           => red_o,
            grn_o           => grn_o,
            blu_o           => blu_o
        );

end architecture;