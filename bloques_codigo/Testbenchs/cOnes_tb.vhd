library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cOnes_tb is
end;

architecture arch of cOnes_tb is

  signal clk_unos  : std_logic := '0';
  signal rst_unos  : std_logic := '1';
  signal ena_unos  : std_logic := '0';

  signal q_bcd1, q_bcd2, q_bcd3, q_bcd4 : std_logic_vector(3 downto 0);
  signal q_bcd5, q_bcd6, q_bcd7        : std_logic_vector(3 downto 0);

begin

  -- Instancia del DUT (Device Under Test)
  uut: entity work.cOnes
    port map (
      clk_unos => clk_unos,
      rst_unos => rst_unos,
      ena_unos => ena_unos,
      q_bcd1   => q_bcd1,
      q_bcd2   => q_bcd2,
      q_bcd3   => q_bcd3,
      q_bcd4   => q_bcd4,
      q_bcd5   => q_bcd5,
      q_bcd6   => q_bcd6,
      q_bcd7   => q_bcd7
    );

  -- Clock de 10ns
  clk_unos <= not clk_unos after 5 ns;

  -- Reset y Enable
  rst_unos <= '1', '0' after 20 ns;
  ena_unos <= '0', '1' after 30 ns;

end architecture;
