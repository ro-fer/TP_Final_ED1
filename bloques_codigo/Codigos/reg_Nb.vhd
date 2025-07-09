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
    clk_i: in std_logic; -- Clock
    rst_i: in std_logic; -- Reset
    ena_i: in std_logic; -- Enable
    D_i: in std_logic; -- Dato
    Q_o: out std_logic -- Salida
  );
end component;

begin
  ffd_gen: for x in 0 to N-1 generate -- Genero registros de la vant de bits definidos antes
    ffdx: ffd
      port map(
        clk_i =>  clk_i,    -- Clock
        rst_i =>  rst_i,    -- Reset
        ena_i =>  ena_i,    -- Enable
        D_i   =>  D_reg(x), -- Entrada
        Q_o   =>  Q_reg(x)  -- Salida
      );
  end generate ffd_gen;
end;