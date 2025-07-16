----------------------------------------------------------------------------------
-- Modulo: 		Voltimetro_toplevel
-- Descripcion: Voltimetro implementado con un modulador sigma-delta
-- Autor: 		Electronica Digital I
--        		Universidad de San Martin - Escuela de Ciencia y Tecnologia
--
-- Fecha: 		01/09/2020
--              Actualizado: 26/05/2025
----------------------------------------------------------------------------------
library IEEE;
use IEEE.bit_1164.all;
use IEEE.numeric_std.all;

entity Voltimetro_toplevel is
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
end Voltimetro_toplevel;

architecture Voltimetro_toplevel_arq of Voltimetro_toplevel is

    -- Componente Voltimetro
    component Voltimetro is
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

    -- Componente contador binario
    component cont_bin is
        generic(
            N : natural := 2
        );
        port(
            clk_i : in bit;
            rst_i : in bit;
            ena_i : in bit;
            q_o   : out bit_vector(N-1 downto 0)
        );
    end component;

    -- Señales internas
    signal cuenta    : bit_vector(1 downto 0);
    signal clk25MHz  : bit;

begin

    -- Generador de reloj de 25 MHz (a partir de 100 MHz)
    clk25MHz_gen : cont_bin
        generic map(
            N => 2
        )
        port map (
            clk_i => clk_i,
            rst_i => rst_i,
            ena_i => '1',
            q_o   => cuenta
        );

    clk25MHz <= cuenta(1);  -- División por 4 = 25 MHz

    -- Instancia del voltímetro
    inst_voltimetro : Voltimetro
        port map (
            clk_i           => clk25MHz,
            rst_i           => rst_i,
            data_volt_in_i  => data_volt_in_i,
            data_volt_out_o => data_volt_out_o,
            hs_o            => hs_o,
            vs_o            => vs_o,
            red_o           => red_o,
            grn_o           => grn_o,
            blu_o           => blu_o
        );

end Voltimetro_toplevel_arq;
