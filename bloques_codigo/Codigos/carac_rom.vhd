--ROM de caracteres
-- Estudiante: Fernández, Rocío


entity rom is 
    port(
        char_address : bit_vector(3 downto 0); -- 4 digitos del medio del contH
        font_col     : bit_vector(2 downto 0); -- 3 digitos , viene dado por los 3 bits menos sig del contH
        font_row     : bit_vector(2 downto 0);
        rom_out      : out bit
    ); 
end;

architecture rom_arq of rom is 
    -- defino vector de vectores
    -- tengo 13 caracteres (0,1,2,3,4,5,6,7,8,9,'.','V',' ') con 8 filas cada uno (13*8=104)   
    type matriz is array (0 to 103) of bit_vector(0 to 7);

    signal concate : bit_vector(6 downto 0); -- concateno direccion con la fila, 3+4=7

    -- necesito una funcion para convertir vector a entero
    function conversion_entero( word: bit_vector) return integer is 
        variable resultado: integer := 0; -- inicializo en 0
    begin 
        for i in word'range loop
            if(word(i) = '1') then 
                resultado := resultado + 2**i;
            end if;
        end loop ;
        return resultado;
    end conversion_entero;

    constant ROM_m: matriz := (

        "00000000",
		"00111100",
		"01000010",
		"01000010", --0
		"01000010",
		"01000010",
		"00111100",
		"00000000", 
		
		"00000000",
		"00001000",
		"00011000",
		"00101000", --1
		"00001000", 
		"00001000",
		"00111100",
		"00000000",
		
		"00000000",
		"00111100",
		"01000010",
		"00000100", --2
		"00001000",
		"00110000",
		"01111110",
		"00000000",

		"00000000",
		"01111100",
		"00000010",
		"00111110", --3
		"00000010",
		"00000010",
		"01111100",
		"00000000",

		"00000000",
		"00001100",
		"00010100",
		"00100100", --4
		"01111110",
		"00000100",
		"00000100",
		"00000000",

		"00000000",
		"01111100",
		"01000000",
		"01111100", --5
		"00000010",
		"00000010",
		"01111100",
		"00000000",

		"00000000",
		"00111100",
		"01000000",
		"01111100", --6
		"01000010",
		"01000010",
		"00111100",
		"00000000",

		"00000000",
		"01111110",
		"00000100",
		"00001000", --7
		"00010000",
		"00100000",
		"00100000",
		"00000000",

		"00000000",
		"00111100",
		"01000010",
		"01111110", --8
		"01000010",
		"01000010",
		"00111100",
		"00000000",

		"00000000",
		"00111100",
		"01000010",
		"01000010", --9
		"00111110",
		"00000010",
		"00111100",
		"00000000",

		"00000000",
		"00000000",
		"00000000",
		"00000000", --punto
		"00000000",
		"00011000",
		"00011000",
		"00000000",

		"00000000",
		"01000010",
		"01000010",
		"01000010", --V 
		"00100100",
		"00100100",
		"00011000",
		"00000000",

		"00000000",
		"00000000",
		"00000000",
		"00000000", --blanco
		"00000000",
		"00000000",
		"00000000",
		"00000000"
		);

begin

    concate <= char_address & font_row; -- concateno direccion con fila 
    rom_out <= ROM_m(conversion_entero(concate))(conversion_entero(font_col));
end;