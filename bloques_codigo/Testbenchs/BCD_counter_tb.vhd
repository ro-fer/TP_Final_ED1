library IEEE;
use IEEE.std_logic_1164.all;

entity BCD_counter_tb is
end;

architecture sim of BCD_counter_tb is

  component BCD_counter
    generic(N: natural := 4);
    port(
      clk_bcd  : in std_logic;
      rst_bcd  : in std_logic;
      ena_bcd  : in std_logic;
      q_bcd  : out std_logic_vector(N-1 downto 0)
    );
  end component;

  signal clk_tb   : std_logic := '0';
  signal rst_tb   : std_logic := '1';
  signal ena_tb   : std_logic := '1';
  signal count_tb : std_logic_vector(3 downto 0);

begin

  -- Generación del reloj (periodo: 40 ns)
  clk_tb <= not clk_tb after 20 ns;

  -- Reset inicial por 80 ns
  process
  begin
    rst_tb <= '1';
    wait for 80 ns;
    rst_tb <= '0';
    wait;
  end process;

  -- Instancia del contador
  DUT: BCD_counter
    generic map(N => 4)
    port map(
      clk_bcd  => clk_tb,
      rst_bcd  => rst_tb,
      ena_bcd  => ena_tb,
      q_bcd  => count_tb
    );

end architecture;
