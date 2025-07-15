library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity c33k is
  port (
    clk_i   : in std_logic;
    rst_i   : in std_logic;
    ena_i   : in std_logic;
    Q_BCD   : out std_logic;
    cuenta  : out std_logic_vector(21 downto 0)
  );
end entity;

architecture c33k_arq of c33k is

  component cont_bin_gen is
    port (
      clk_bin_gen : in std_logic;
      ena_bin_gen : in std_logic;
      rst_bin_gen : in std_logic;
      salida_gen  : out std_logic_vector(21 downto 0)
    );
  end component;

  signal salida_cont : std_logic_vector(21 downto 0);
  signal salida_reg  : std_logic;
  signal salida_q    : std_logic;

begin

  contador: cont_bin_gen
    port map(
      clk_bin_gen => clk_i,
      ena_bin_gen => ena_i,
      rst_bin_gen => rst_i or salida_reg,
      salida_gen  => salida_cont
    );

  salida_reg <= (
    salida_cont(21) and salida_cont(20) and not salida_cont(19) and not salida_cont(18) and
    salida_cont(17) and not salida_cont(16) and not salida_cont(15) and salida_cont(14) and
    not salida_cont(13) and salida_cont(12) and salida_cont(11) and not salida_cont(10) and
    salida_cont(9) and not salida_cont(8) and salida_cont(7) and not salida_cont(6) and
    not salida_cont(5) and salida_cont(4) and salida_cont(3) and salida_cont(2) and
    salida_cont(1) and salida_cont(0)
  );

  Q_BCD  <= salida_reg;
  cuenta <= salida_cont;

end architecture;
