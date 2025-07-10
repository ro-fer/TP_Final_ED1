-- Contador BCD
-- Estudiante: Fernández, Rocío

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity BCD_counter is
  generic(
    N: natural := 4 -- Nro bits
    );
  port(
    clk_i: in std_logic; -- clock 
    rst_i: in std_logic; -- Reset 
    ena_i: in std_logic; -- Enable 
    count: out std_logic_vector(N-1 downto 0); -- Valor actual del contador
    max: out std_logic -- Indica si se alcanzó el valor máximo (9)
  );
end;
architecture BCD_counter_arq of BCD_counter is

  signal Qreg_aux: std_logic_vector(N-1 downto 0);
  signal Dinc_aux: std_logic_vector(N-1 downto 0);
  signal next_count: std_logic_vector(N-1 downto 0);
  constant b_aux: std_logic_vector(N-1 downto 0) := "0001";
  constant VAL9: std_logic_vector(N-1 downto 0) := std_logic_vector(to_unsigned(9, N));
  signal comp_aux: std_logic;

begin

  sumNb0: entity work.sum_Nb
    generic map(N => N)
    port map(
      a_i => Qreg_aux,
      b_i => b_aux,
      c_i => '0',
      s_o => Dinc_aux,
      c_o => open
    );

  compNb0: entity work.comp_Nb
    generic map(N => N)
    port map(
      a => Qreg_aux,
      b => VAL9,
      s => comp_aux
    );

  next_count <= (others => '0') when comp_aux = '1' else Dinc_aux;

  reg0: entity work.reg_Nb
    generic map(N => N)
    port map(
      clk_i => clk_i,
      rst_i => rst_i,
      ena_i => ena_i,
      D_reg => next_count,
      Q_reg => Qreg_aux
    );

  count <= Qreg_aux;
  max <= comp_aux;

end architecture;
