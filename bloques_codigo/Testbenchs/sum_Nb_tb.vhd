-- Test de Sumador de N bit

library IEEE;
use IEEE.std_logic_1164.all;

entity sum_Nb_tb is end;
architecture arch of sum_Nb_tb is
  constant N : natural := 4;
  signal a_i, b_i : std_logic_vector(N-1 downto 0);
  signal c_i : std_logic := '0';
  signal s_o : std_logic_vector(N-1 downto 0);
  signal c_o : std_logic;
begin
  uut: entity work.sum_Nb
    generic map(N => N)
    port map(a_i => a_i, b_i => b_i, c_i => c_i, s_o => s_o, c_o => c_o);

  a_i <= "0011" after 10 ns, "1111" after 40 ns;
  b_i <= "0001" after 10 ns, "0001" after 40 ns;
end;
