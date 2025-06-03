-- Contador BCD
-- Estudiante: Fernández, Rocío

library IEEE;
use IEEE.std_logic_1164.all;

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

  -- Señales auxiliares
  signal Qreg_aux: std_logic_vector(N-1 downto 0); -- Salida 
  signal Dinc_aux: std_logic_vector(N-1 downto 0); -- Entrada  (valor +1)
  signal rst_aux: std_logic; -- Reset interno 
  signal comp_aux: std_logic; -- Salida del comparador
  signal andcomp: std_logic; -- AND entre enable y salida del comparador
  constant b_aux: std_logic_vector(N-1 downto 0) := "0001"; -- Constante para sumar 1

begin

  -- Registro de N bits: almacena el valor actual del contador
  reg0: entity work.reg_Nb
    generic map(N => N)
    port map(
      clk_i => clk_i,     -- clock
      rst_i => rst_aux,   -- Reset
      ena_i => ena_i,     -- Enable
      D_reg => Dinc_aux,  -- Valor a almacenar (registro +1)
      Q_reg => Qreg_aux    -- Salida 
    );

  -- Sumador de N bits: incrementa el valor almacenado en 1
  sumNb0: entity work.sum_Nb
    generic map(N => N)
    port map(
      a_i => Qreg_aux,    -- Valor actual del registro
      b_i => b_aux,       -- Valor constante "0001"
      c_i => '0',         -- Carry de entrada
      s_o => Dinc_aux,    -- Resultado de la suma
      c_o => open         -- Carry de salida (no usado)
    );

  -- Comparador de N bits: compara si el valor es igual a 9 ("1001")
  compNb0: entity work.comp_Nb
    generic map(N => N)
    port map(
      a => Qreg_aux,  -- Valor actual del registro
      b => "1001",    -- Comparamos con el número 9
      s => comp_aux   -- Salida del comparador ('1' si son iguales)
    );

  -- Lógica de reset: reinicia cuando se llega a 9 o se activa el reset maestro
  rst_aux <= andcomp or rst_i;    -- Señal de reset interna
  andcomp <= comp_aux and ena_i;  -- Solo reiniciar si el enable está activo

  -- Salidas
  count <= Qreg_aux;              -- Valor actual del contador
  max <= comp_aux;                -- Señal de valor máximo (9)

end architecture;