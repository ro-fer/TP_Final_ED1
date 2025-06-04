--  MAIN del voltimetro
-- Estudiante: Fernández, Rocío

library IEEE;
use IEEE.std_logic_1164.all;

entity main_volt is
  port(
    clk_i   : in  std_logic;                           -- Clockk 
    rst_i   : in  std_logic;                           -- Reset 
    adc_i   : in  std_logic;                           -- Bit  del ADC Sigma-Delta
    ones_o  : out std_logic_vector(7 downto 0)         -- Valor contado (medición)
  );
end entity;

architecture rtl of main_volt is

  -- Señales internas para habilitación y reseteo del contador de unos
  signal ena_cOnes : std_logic;
  signal rst_cOnes : std_logic;
  signal cOnes_q   : std_logic_vector(7 downto 0);

begin

  -- Contador de unos (cOnes): mide la cantidad de 1s que salen del ADC
  ones_counter : entity work.cOnes
    generic map(N => 8)
    port map(
      clk_i  => clk_i,
      rst_i  => rst_cOnes,
      ena_i  => ena_cOnes,
      adc_i  => adc_i,
      ones_o => cOnes_q
    );

  -- Contador de ventana (c33k): habilita el muestreo y resetea cOnes
  ventana_33k : entity work.c33k
    port map(
      clk_i   => clk_i,
      rst_i   => rst_i,
      ena_o   => ena_cOnes,
      rst_o   => rst_cOnes
    );

  -- Salida del sistema: resultado final de la medición
  ones_o <= cOnes_q;

end architecture;
