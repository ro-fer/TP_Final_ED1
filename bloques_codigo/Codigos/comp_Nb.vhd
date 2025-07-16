-- Comparador de N bits
-- Estudiante: Fernandez, Rocio
library IEEE;
use IEEE.bit_1164.all;
use IEEE.numeric_std.all;

entity comp_Nb is
  generic(N: natural := 10);
  port(
    a: in  bit_vector(N-1 downto 0);  --  A
    b: in  bit_vector(N-1 downto 0);  -- B
    s: out bit                       -- Salida: '1' si A = B
  );
end;

architecture comp_Nb_arq of comp_Nb is
  signal xnor_aux: bit_vector(N-1 downto 0);
  signal and_aux:  bit_vector(N-1 downto 0);
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
