-- Comparador de N bits
-- Estudiante: Fernandez, Rocio

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity comp_Nb is
  generic(N: natural := 10);
  port(
    a: in std_logic_vector(N-1 downto 0);  -- Número A
    b: in std_logic_vector(N-1 downto 0);  -- Número B
    s: out std_logic                       -- Salida: '1' si A = B
  );
end;

architecture comp_Nb_arq of comp_Nb is
  signal xnor_aux: std_logic_vector(N-1 downto 0);
  signal and_aux: std_logic_vector(N-1 downto 0);
begin

  -- Compara bit a bit usando XNOR
  gen_xnor: for i in 0 to N-1 generate
    xnor_aux(i) <= a(i) xnor b(i);
  end generate;

  -- And de todos los bits (en cascada)
  and_aux(0) <= xnor_aux(0);
  gen_and: for i in 1 to N-1 generate
    and_aux(i) <= and_aux(i-1) and xnor_aux(i);
  end generate;

  -- Salida: '1' si todos los bits coinciden
  s <= and_aux(N-1);

end architecture;
