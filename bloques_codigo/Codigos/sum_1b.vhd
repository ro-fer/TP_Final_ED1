-- Sumador de 1 bit

-- Estudiante: Fernandez, Rocio

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sum_1b is
  port(
    a_i: in std_logic; -- Entrada A
    b_i: in std_logic; -- Entrada B
    c_i: in std_logic; -- Entrada Carry
    s_o: out std_logic; -- Suma de A+B
    c_o: out std_logic -- Salida Carry
  );
end;

architecture sum_1b_arq of sum_1b is
begin
  s_o <= a_i xor b_i xor c_i; -- suma con xor
  c_o <= (a_i and b_i) or (a_i and c_i) or (b_i and c_i); -- salida del Carry
end;