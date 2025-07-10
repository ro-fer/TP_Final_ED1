library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BCD_counter_tb is
  generic(N: natural := 4);
end;

architecture BCD_counter_tb_arq of BCD_counter_tb is

  component BCD_counter
    generic(N: natural := 4);
    port(
      clk_i  : in std_logic;
      rst_i  : in std_logic;
      ena_i  : in std_logic;
      count  : out std_logic_vector(N-1 downto 0);
      max    : out std_logic
    );
  end component;

  signal clk_tb   : std_logic := '0';
  signal rst_tb   : std_logic := '1';
  signal ena_tb   : std_logic := '1';
  signal count_tb : std_logic_vector(N-1 downto 0);
  signal max_tb   : std_logic;

begin

  -- Clock: 40 ns periodo
  clk_tb <= not clk_tb after 20 ns;

  -- Reset: activo 80 ns
  rst_process: process
  begin
    rst_tb <= '1';
    wait for 80 ns;
    rst_tb <= '0';
    wait;
  end process;

  -- Instancia del contador
  DUT: BCD_counter
    port map(
      clk_i  => clk_tb,
      rst_i  => rst_tb,
      ena_i  => ena_tb,
      count  => count_tb,
      max    => max_tb
    );

end architecture;
 
