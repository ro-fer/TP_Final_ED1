library IEEE;
use IEEE.std_logic_1164.all;

entity c33k_tb is
end;

architecture c33k_tb_arq of c33k_tb is

  component c33k is
    port (
      clk_i   : in std_logic;
      rst_i   : in std_logic;
      ena_i   : in std_logic;
      Q_BCD   : out std_logic;
      Q_reg   : out std_logic;
      cuenta  : out std_logic_vector(21 downto 0)
    );
  end component;

  signal clk_tb     : std_logic := '0';
  signal rst_tb     : std_logic := '1';
  signal ena_tb     : std_logic := '0';
  signal Q_BCD_tb   : std_logic;
  signal Q_reg_tb   : std_logic;
  signal cuenta_tb  : std_logic_vector(21 downto 0);

begin

  clk_tb <= not clk_tb after 5 ns;
  rst_tb <= '1', '0' after 30 ns;
  ena_tb <= '1' after 10 ns;

  DUT: c33k
    port map(
      clk_i   => clk_tb,
      rst_i   => rst_tb,
      ena_i   => ena_tb,
      Q_BCD   => Q_BCD_tb,
      Q_reg   => Q_reg_tb,
      cuenta  => cuenta_tb
    );

end architecture;
