-- Conversor Analógico Digital Sigma-Delta
-- Estudiante: Fernandez, Rocio

library IEEE;
use IEEE.std_logic_1164.all;

entity ADC_SD is
  port(
    clk_i: in std_logic;  -- Clock
    rst_i: in std_logic;  -- Reset
    ena_i: in std_logic;  -- Enable
    D_vi: in std_logic;   -- Entrada
    Q_fb: out std_logic;  -- Realimentacion
    Q_proc: out std_logic -- Procesamiento
  );
end;

architecture ADC_SD_arq of ADC_SD is
component ffd -- llamo al codigo de Flip Flop D
  port(
    clk_i: in std_logic; -- Clock
    rst_i: in std_logic; -- Reset
    ena_i: in std_logic; -- Enable
    D_i: in std_logic; -- Dato
    Q_o: out std_logic -- Salida
  );
end component;

signal Q_aux: std_logic; -- Auxiliar para Q

begin
  ffd0: ffd
    port map(
      clk_i =>  clk_i,
      rst_i =>  rst_i,
      ena_i =>  ena_i,
      D_i   =>  D_vi,
      Q_o   =>  Q_aux
    );
  Q_fb <= not Q_aux;
  Q_proc <= Q_aux;
end;