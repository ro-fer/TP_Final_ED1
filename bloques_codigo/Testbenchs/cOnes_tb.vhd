-- Testbench para el contador de unos (cOnes)

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.utils.all;

entity cOnes_tb is
end;

architecture arch of cOnes_tb is
  constant N : natural := 5;
  constant M : natural := 4;

  signal clk_i  : std_logic := '0';
  signal rst_i  : std_logic := '1';
  signal ena_i  : std_logic := '0';
  signal BCD_o  : vectBCD(N-1 downto 0);

begin

  -- Instanciación del módulo a testear
  uut: entity work.cOnes
    generic map (N => N, M => M)
    port map (
      clk_i => clk_i,
      rst_i => rst_i,
      ena_i => ena_i,
      BCD_o => BCD_o
    );

  -- Clock (sí se permite usar un process para esto)
  clk_i <= not clk_i after 5 ns;

  -- Reset y enable aplicados sin process (uso de after directamente)
  rst_i <= '1', '0' after 20 ns;
  ena_i <= '0', '1' after 30 ns;

end architecture;
