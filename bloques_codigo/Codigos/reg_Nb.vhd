-- Registro de N bits --> particularmente 4bits
-- Estudiante: Fernandez, Rocio
library IEEE;
use IEEE.std_logic_1164.all;

entity reg_Nb is
  generic(
    N: natural := 4 -- Bits
  );
  port(
    clk_i: in std_logic; -- Clock
    rst_i: in std_logic; -- Reset
    ena_i: in std_logic; -- Enable
    D_reg: in std_logic_vector(N-1 downto 0); -- vector de entrada
    Q_reg: out std_logic_vector(N-1 downto 0) -- vector de salida
  );
end;

architecture reg_Nb_arq of reg_Nb is
component ffd -- llamo al codigo de Flip Flop D
  port(
      clk_i : in std_logic;
      rst_i : in std_logic;
      ena_i : in std_logic;
      d_i   : in std_logic;
      q_o   : out std_logic

  );
end component;

begin
  ffd_gen: for x in 0 to N-1 generate -- Genero registros de la vant de bits definidos antes
    ffdx: ffd
      port map(
        clk_i => clk_i,
        rst_i => rst_i,
        ena_i => ena_i,
        d_i   => D_reg(x),
        q_o   => Q_reg(x)
      );
  end generate ffd_gen;
end;