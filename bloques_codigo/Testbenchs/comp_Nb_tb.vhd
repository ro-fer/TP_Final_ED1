-- Test comparador de N bits

library IEEE;
use IEEE.std_logic_1164.all;

entity comp_Nb_tb is end;
architecture arch of comp_Nb_tb is
  constant N : natural := 4;
  signal a, b : std_logic_vector(N-1 downto 0);
  signal s : std_logic;
begin
  uut: entity work.comp_Nb
    generic map(N => N)
    port map(a => a, b => b, s => s);

  a <= "1001" after 10 ns, "1111" after 30 ns;
  b <= "1001" after 10 ns, "0111" after 30 ns;
end architecture;
