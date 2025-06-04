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

    char_address : in std_logic_vector ( A-1 downto 0 ) ; -- direccion del caract
    sub_fila : in std_logic_vector ( F-1 downto 0 ) ; -- fila dentro del caract
    sub_col : in std_logic_vector ( C-1 downto 0 ) ; -- col dentro de la fila
    rom_data : out std_logic  -- salida : '1' pixel activo o '0' pixel inactivo

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

  signal char_addr_aux : unsigned (6 downto 0) ; -- direc concatenada

  begin
  -- calcula la direc en la ROM
    char_addr_aux <= unsigned(char_address) & unsigned(sub_fila) ;
    -- Obtiene el bit específico de la fila y columna:
    rom_data <= ROM(to_integer(char_addr_aux))(to_integer(unsigned(sub_col))) ;

end;