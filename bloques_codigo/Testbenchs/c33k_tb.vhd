-- Testbench para probar contador

library IEEE;
use IEEE.std_logic_1164.all;

entity c33k_tb is
end;

architecture c33k_tb_arq of c33k_tb is

  component c33k is
    generic(
      N: natural := 22
    );
    port(
      clk_i   : in std_logic;
      rst_i   : in std_logic;
      ena_i   : in std_logic;
      Q_BCD   : out std_logic;
      Q_reg   : out std_logic;
      cuenta  : out std_logic_vector(N-1 downto 0)
    );
  end component;

  constant N : natural := 22;

  signal clk_tb     : std_logic := '0';
  signal rst_tb     : std_logic := '1';
  signal ena_tb     : std_logic := '0';
  signal Q_BCD_tb   : std_logic;
  signal Q_reg_tb   : std_logic;
  signal cuenta_tb  : std_logic_vector(N-1 downto 0);

begin

  -- Clock de 10 ns (100 MHz)
  clk_tb <= not clk_tb after 5 ns;

  -- Habilitación y reset
  rst_tb <= '1', '0' after 30 ns;
  ena_tb <= '1' after 10 ns;

  -- Instancia del DUT
  DUT: c33k
    generic map(N => N)
    port map(
      clk_i   => clk_tb,
      rst_i   => rst_tb,
      ena_i   => ena_tb,
      Q_BCD   => Q_BCD_tb,
      Q_reg   => Q_reg_tb,
      cuenta  => cuenta_tb
    );

end architecture;
