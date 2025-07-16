-- Sumador de 4 bits sin generate
-- Estudiante: Fernández, Rocío

library IEEE;
use IEEE.std_logic_1164.all;

entity sum_Nb_4bit is
  port(
    a_i : in  bit_vector(3 downto 0);  -- Entrada A
    b_i : in  bit_vector(3 downto 0);  -- Entrada B
    c_i : in  bit;                     -- Carry de entrada
    s_o : out bit_vector(3 downto 0); -- Suma
    c_o : out bit                     -- Carry de salida
  );
end entity;

architecture rtl of sum_Nb_4bit is
  signal c_aux : bit_vector(4 downto 0);
begin

  c_aux(0) <= c_i;

  -- Instancias manuales del sumador de 1 bit
  sum0: entity work.sum_1b
    port map(
      a_i => a_i(0),
      b_i => b_i(0),
      c_i => c_aux(0),
      s_o => s_o(0),
      c_o => c_aux(1)
    );

  sum1: entity work.sum_1b
    port map(
      a_i => a_i(1),
      b_i => b_i(1),
      c_i => c_aux(1),
      s_o => s_o(1),
      c_o => c_aux(2)
    );

  sum2: entity work.sum_1b
    port map(
      a_i => a_i(2),
      b_i => b_i(2),
      c_i => c_aux(2),
      s_o => s_o(2),
      c_o => c_aux(3)
    );

  sum3: entity work.sum_1b
    port map(
      a_i => a_i(3),
      b_i => b_i(3),
      c_i => c_aux(3),
      s_o => s_o(3),
      c_o => c_aux(4)
    );

  -- Carry final
  c_o <= c_aux(4);

end architecture;
