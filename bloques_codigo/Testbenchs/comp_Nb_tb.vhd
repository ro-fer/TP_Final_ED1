-- Test comparador de N bits

library IEEE;
use IEEE.bit_1164.all;

entity comp_Nb_tb is end;
architecture arch of comp_Nb_tb is
  constant N : natural := 4;
  signal a, b : bit_vector(N-1 downto 0);
  signal s : bit;
begin
  uut: entity work.comp_Nb
    generic map(N => N)
    port map(a => a, b => b, s => s);

  a <= "1001" after 10 ns, "1111" after 30 ns;
  b <= "1001" after 10 ns, "0111" after 30 ns;
end architecture;
