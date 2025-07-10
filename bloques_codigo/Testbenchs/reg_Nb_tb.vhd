-- Test de Registro de N bits --> particularmente 4bits

library IEEE;
use IEEE.std_logic_1164.all;

entity reg_Nb_tb is
end reg_Nb_tb;

architecture arch of reg_Nb_tb is
  constant N : natural := 4;
  signal clk, rst, ena : std_logic := '0';
  signal D_reg : std_logic_vector(N-1 downto 0) := "0000";
  signal Q_reg : std_logic_vector(N-1 downto 0);
begin
  uut: entity work.reg_Nb
    generic map(N => N)
    port map (
      clk_i => clk,
      rst_i => rst,
      ena_i => ena,
      D_reg => D_reg,
      Q_reg => Q_reg
    );

  clk <= not clk after 5 ns;
  rst <= '1', '0' after 20 ns;
  ena <= '0', '1' after 30 ns;
  D_reg <= "1010" after 30 ns, "0101" after 70 ns;
end arch;
