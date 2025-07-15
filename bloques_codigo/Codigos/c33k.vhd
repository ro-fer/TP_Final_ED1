-- Contador de 3 300 000 bits
-- Estudiante: Fernández, Rocío 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity c33k is
  generic(
    N: natural := 22 -- Bits del contador
  );
  port(
    clk_i   : in std_logic;
    rst_i   : in std_logic;
    ena_i   : in std_logic;
    Q_BCD   : out std_logic;
    Q_reg   : out std_logic;
    cuenta  : out std_logic_vector(N-1 downto 0) -- salida para ver el contador
  );
end entity;

architecture c33k_arq of c33k is

  signal rst_aux     : std_logic;
  signal Dinc_aux    : std_logic_vector(N-1 downto 0);
  signal Qreg_aux    : std_logic_vector(N-1 downto 0);
  signal QBCD_aux    : std_logic;

  constant VAL_33000  : std_logic_vector(N-1 downto 0) := std_logic_vector(to_unsigned(33000, N));
  constant VAL_32999  : std_logic_vector(N-1 downto 0) := std_logic_vector(to_unsigned(32999, N));

begin

  -- Registro
  reg1: entity work.reg_Nb
    generic map(N => N)
    port map(
      clk_i => clk_i,
      rst_i => rst_aux,
      ena_i => ena_i,
      D_reg => Dinc_aux,
      Q_reg => Qreg_aux
    );

  -- Sumador
  sumNb0: entity work.sum_Nb
    generic map(N => N)
    port map(
      a_i => Qreg_aux,
      b_i => std_logic_vector(to_unsigned(1, N)),
      c_i => '0',
      s_o => Dinc_aux,
      c_o => open
    );

  -- Comparador para 33000
  compNb0: entity work.comp_Nb
    generic map(N => N)
    port map(
      a => Qreg_aux,
      b => VAL_33000,
      s => QBCD_aux
    );

  -- Comparador para 32999
  compNb1: entity work.comp_Nb
    generic map(N => N)
    port map(
      a => Qreg_aux,
      b => VAL_32999,
      s => Q_reg
    );

  -- Reset del contador
  rst_aux <= rst_i or QBCD_aux;

  -- Salidas
  Q_BCD   <= QBCD_aux;
  cuenta  <= Qreg_aux;

end architecture;
