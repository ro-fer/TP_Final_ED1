-- Paso de binario a BCD
-- Estudiante: Fernández, Rocío

library IEEE;
use IEEE.std_logic_1164.all;

entity bin8_to_bcd is
  port (
    bin_i   : in  std_logic_vector(7 downto 0);  -- Entrada binaria (0 a 255)
    cen_o   : out std_logic_vector(3 downto 0);  -- Centenas BCD
    dec_o   : out std_logic_vector(3 downto 0);  -- Decenas BCD
    uni_o   : out std_logic_vector(3 downto 0)   -- Unidades BCD
  );
end entity;

architecture rtl of bin8_to_bcd is

  -- señales para el shift register (12 bits para 8 bits binarios + 3*4 bits BCD)
  signal shift : std_logic_vector(19 downto 0);

  -- Señales intermedias para sumar 3 si >= 5 
  signal adj_cen, adj_dec, adj_uni : std_logic_vector(3 downto 0);
  signal bcd_cen, bcd_dec, bcd_uni : std_logic_vector(3 downto 0);

  -- Señales para los sumadores estructurales
  signal zero4 : std_logic_vector(3 downto 0) := (others => '0');
  signal tres4 : std_logic_vector(3 downto 0) := "0011";

begin

  -- Inicialización del shift register con los bits binarios
  shift(19 downto 12) <= (others => '0');        -- BCD centenas
  shift(11 downto 8)  <= (others => '0');        -- BCD decenas
  shift(7 downto 4)   <= (others => '0');        -- BCD unidades
  shift(3 downto 0)   <= bin_i(7 downto 4);      -- binario alto

  -- Paso 1: Si unidad >= 5, sumar 3
  sum_uni : entity work.sum_Nb
    generic map(N => 4)
    port map(
      a_i => shift(7 downto 4),
      b_i => tres4,
      c_i => '0',
      s_o => adj_uni,
      c_o => open
    );

  -- Paso 2: Si decena >= 5, sumar 3
  sum_dec : entity work.sum_Nb
    generic map(N => 4)
    port map(
      a_i => shift(11 downto 8),
      b_i => tres4,
      c_i => '0',
      s_o => adj_dec,
      c_o => open
    );

  -- Paso 3: Si centena >= 5, sumar 3
  sum_cen : entity work.sum_Nb
    generic map(N => 4)
    port map(
      a_i => shift(19 downto 16),
      b_i => tres4,
      c_i => '0',
      s_o => adj_cen,
      c_o => open
    );

  bcd_uni <= adj_uni when shift(7) = '1' else shift(7 downto 4);
  bcd_dec <= adj_dec when shift(11) = '1' else shift(11 downto 8);
  bcd_cen <= adj_cen when shift(19) = '1' else shift(19 downto 16);

  -- Salida final
  cen_o <= bcd_cen;
  dec_o <= bcd_dec;
  uni_o <= bcd_uni;

end architecture;
