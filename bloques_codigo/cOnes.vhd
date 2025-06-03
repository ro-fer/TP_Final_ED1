-- Contador de Unos 
-- Estudiante: Fernández, Rocío

library IEEE;
use IEEE.std_logic_1164.all;
use work.utils.all;

entity cOnes is
  generic(
    N: natural := 5; -- Cantidad de contadores BCD (5 dígitos decimales)
    M: natural := 4  -- Cantidad de bits por contador BCD (4 bits para valores 0-9)
  );
  port(
    clk_i   : in std_logic;                      -- clock
    rst_i   : in std_logic;                      -- Reset 
    ena_i   : in std_logic;                      -- Entrada, cuenta unos
    BCD_o   : out vectBCD(N-1 downto 0)          -- Vector de salidas BCD (uno por dígito)
  );
end;

architecture cOnes_arq of cOnes is
  signal ena_aux: std_logic_vector(N downto 0);  -- Señales auxiliares de enable en cadena
  signal max_aux: std_logic_vector(N-1 downto 0);-- Salida 'máximo' de cada contador BCD

begin

  -- Generación de N contadores BCD conectados en cascada
  cOnes_gen: for i in 0 to N-1 generate
    BCD_counterN: entity work.BCD_counter
      generic map(N => M)
      port map(
        clk_i  => clk_i,         -- clock
        rst_i  => rst_i,         -- Reset 
        ena_i  => ena_aux(i),    -- Enable 
        count  => BCD_o(i),      -- Salida BCD del contador i
        max    => max_aux(i)     -- Salida de máximo (llegó a 9)
      );

    -- El enable del siguiente contador depende del enable actual y del acarreo del anterior
    ena_aux(i+1) <= ena_aux(i) and max_aux(i);
  end generate;

  -- Inicialización del primer enable con la señal externa 'ena_i'
  ena_aux(0) <= ena_i;

end architecture;