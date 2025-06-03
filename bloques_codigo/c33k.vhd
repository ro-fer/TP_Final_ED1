-- Contador de 3 300 000 bits
-- Estudiante: Fernández, Rocío


library IEEE;
use IEEE.std_logic_1164.all;

entity c33k is
  generic(
    N: natural := 16 -- Bits del contador
  );
  port(
    clk_i   : in std_logic; -- Clock
    rst_i   : in std_logic; -- Reset 
    ena_i   : in std_logic; -- Enable 
    Q_BCD   : out std_logic; -- reset para el contador de unos
    Q_reg   : out std_logic -- enable para el registro
  );
end;

architecture c33k_arq of c33k is

  -- Señales auxiliares
  signal rst_aux     : std_logic;                      -- Reset aux
  signal Dinc_aux    : std_logic_vector(N-1 downto 0); -- incrementado
  signal Qreg_aux    : std_logic_vector(N-1 downto 0); -- Valor actual
  constant b_aux     : std_logic_vector(N-1 downto 0) := "0000000000000001"; -- Sumar 1
  signal QBCD_aux    : std_logic;                      -- Salida del comparador principal

begin

  -- Registro de N bits: almacena el valor actual del contador
  reg1: entity work.reg_Nb
    generic map(N => N)
    port map(
      clk_i   => clk_i,       -- Clock
      rst_i   => rst_aux,     -- Reset
      ena_i   => ena_i,       -- Enable
      D_reg   => Dinc_aux,    -- Valor a almacenar (registro +1)
      Q_reg   => Qreg_aux     -- Salida del registro
    );

  -- Sumador de N bits: incrementa el valor actual del registro en 1
  sumNb0: entity work.sum_Nb
    generic map(N => N)
    port map(
      a_i => Qreg_aux,      -- Valor actual 
      b_i => b_aux,         --  "1"
      c_i => '0',           -- Carry 
      s_o => Dinc_aux,      -- Suma
      c_o => open           -- Carry de salida
    );

  -- Comparador de N bits: compara si el valor es igual a 3 300 000
  compNb0: entity work.comp_Nb
    generic map(N => N)
    port map(
      a => Qreg_aux,                  -- Valor actual 
      b => "1100100101101010100000",  -- Valor binario de 3 300 000
      s => QBCD_aux                   -- Salida del comparador ('1' si son iguales)
    );

  -- Comparador de N bits: compara si el valor es igual a 3 299 999
  compNb1: entity work.comp_Nb
    generic map(N => N)
    port map(
      a => Qreg_aux,                  -- Valor actual del registro
      b => "1100100101101010011111",  -- Valor binario de 3 299 999
      s => Q_reg                      -- Salida del comparador ('1' si son iguales)
    );

  -- Salida de reset para el contador BCD
  Q_BCD <= QBCD_aux;

  -- El reset del registro se activa cuando:
  -- - Se alcanza el límite (3,300,000) o
  -- - Se activa el reset general
  rst_aux <= QBCD_aux or rst_i;

end architecture; 