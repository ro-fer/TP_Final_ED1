-- Sumador de 1 bit

-- Estudiante: Fernandez, Rocio


entity sum_1b is
  port(
    a_i: in  bit; -- Entrada A
    b_i: in  bit; -- Entrada B
    c_i: in  bit; -- Entrada Carry
    s_o: out bit; -- Suma de A+B
    c_o: out bit -- Salida Carry
  );
end;

architecture sum_1b_arq of sum_1b is
begin
  s_o <= a_i xor b_i xor c_i; -- suma con xor
  c_o <= (a_i and b_i) or (a_i and c_i) or (b_i and c_i); -- salida del Carry
end;