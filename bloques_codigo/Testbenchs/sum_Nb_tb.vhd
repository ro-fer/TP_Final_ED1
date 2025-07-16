-- Test de Sumador de N bit
library IEEE;
use IEEE.bit_1164.all;
use IEEE.numeric_std.all;

entity sum_Nb_tb is
end sum_Nb_tb;

architecture arch of sum_Nb_tb is
  constant N : natural := 4;
  signal a_i, b_i : bit_vector(N-1 downto 0);
  signal c_i : bit := '0';
  signal s_o : bit_vector(N-1 downto 0);
  signal c_o : bit;
begin
  -- Instancia del mdulo
  uut: entity work.sum_Nb_4bit
    
    port map(
      a_i => a_i,
      b_i => b_i, 
      c_i => c_i,
      s_o => s_o,
      c_o => c_o
    );

  -- Est�mulos de entrada
  a_i <= "0011" after 10 ns, "1111" after 40 ns; -- 3 y luego 15
  b_i <= "0001" after 10 ns, "0001" after 40 ns; -- 1 y luego 1
end arch;

