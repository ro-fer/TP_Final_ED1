--ROM de caracteres
-- Estudiante: Fernández, Rocío

library IEEE ;
use IEEE.std_logic_1164.all ;
use IEEE.numeric_std.all;


entity rom is

  generic(

    A : integer := 4 ; -- bits para direccion
    F : integer := 3 ; --  bits para fila
    C : integer := 3   --  bits para columna

  ) ;

  port (

    char_address : in bit_vector ( A-1 downto 0 ) ; -- direccion del caract
    font_row : in     bit_vector ( F-1 downto 0 ) ; -- fila dentro del caract
    font_col : in     bit_vector ( C-1 downto 0 ) ; -- col dentro de la fila
    rom_out : out     bit  -- salida : '1' pixel activo o '0' pixel inactivo
  );

end ;

architecture rom_arq of rom is

  -- Def de tipos para la ROM
  subtype subfila is std_logic_vector ( 0 to 7 ) ; -- Una fila de 8 píxeles (0=blanco, 1=negro)
  type memoria is array ( 0 to 127 ) of subfila ; -- Memoria: 13 caracteres x 8 filas + padding

  signal ROM : memoria := (
  -- cero
          "01111110",
          "01000010",
          "01000010",
          "01000010",
          "01000010",
          "01000010",
          "01111110",
          "00000000",
  -- uno
          "00000010",
          "00000010",
          "00000010",
          "00000010",
          "00000010",
          "00000010",
          "00000010",
          "00000000",
  -- dos
          "01111110",
          "00000010",
          "00000010",
          "01111110",
          "01000000",
          "01000000",
          "01111110",
          "00000000",
  -- tres
          "01111110",
          "00000010",
          "00000010",
          "00111110",
          "00000010",
          "00000010",
          "01111110",
          "00000000",
  -- cuatro
          "01000010",
          "01000010",
          "01000010",
          "01000010",
          "01111110",
          "00000010",
          "00000010",
          "00000000",
  -- cinco
          "01111110",
          "01000000",
          "01000000",
          "01111110",
          "00000010",
          "00000010",
          "01111110",
          "00000000",
  -- seis
          "01111110",
          "01000000",
          "01000000",
          "01111110",
          "01000010",
          "01000010",
          "01111110",
          "00000000",
  -- siete
          "01111110",
          "00000010",
          "00000010",
          "00000010",
          "00000010",
          "00000010",
          "00000010",
          "00000000",
  -- ocho
          "00111100",
          "01000010",
          "01000010",
          "01111110",
          "01000010",
          "01000010",
          "00111100",
          "00000000",
  -- nueve
          "01111110",
          "01000010",
          "01000010",
          "01111110",
          "00000010",
          "00000010",
          "01111110",
          "00000000",
  -- punto
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00011000",
          "00011000",
          "00000000",
  -- volt
          "01000010",
          "01000010",
          "01000010",
          "00100100",
          "00100100",
          "00011000",
          "00011000",
          "00000000",
  -- Espacio en blanco (resto de posiciones)
        others => "00000000"

          );

  signal concate : unsigned (6 downto 0) ; -- direc concatenada

  begin
  concate <= char_address & font_row; -- concateno direccion con fila 
  rom_out <= ROM_m(conversion_entero(concate))(conversion_entero(font_col));

end;