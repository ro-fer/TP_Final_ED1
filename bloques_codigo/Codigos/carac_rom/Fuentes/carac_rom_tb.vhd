-- test  ROM

entity rom_tb is 
end;

architecture rom_tb_arq of rom_tb is 

    component rom is 
        port(
            char_address : bit_vector(3 downto 0); 
            font_col     : bit_vector(2 downto 0); 
            font_row     : bit_vector(2 downto 0);
            rom_out      : out bit
        ); 
    end component;

    signal char_address_tb  : bit_vector(3 downto 0) := "0000";
    signal font_col_tb      : bit_vector(2 downto 0) := "000";
    signal font_row_tb      : bit_vector(2 downto 0) := "000";
    signal rom_out_tb       : bit := '0';

begin

    font_col_tb <=  "000" after 10 ns, --columna 0 (todos ceros)
			        "001" after 100 ns; --columna 1 (varia el valor)

	font_row_tb <= "000" after 10 ns, "001" after 20 ns, "010" after 30 ns, "011" after 40 ns, "100" after 50 ns, "101" after 60 ns, "110" after 70 ns, "111" after 80 ns, --deberian salir todos ceros porque estoy en columna 0
			  "000" after 110 ns, "001" after 120 ns, "010" after 130 ns, "011" after 140 ns, "100" after 150 ns, "101" after 160 ns, "110" after 170 ns, "111" after 180 ns; --varia el valor porque paso a la columna 1

	char_address_tb <= "0000" after 10 ns, "0001" after 20 ns, "0010" after 30 ns, "0011" after 40 ns, "0100" after 50 ns, "0101" after 60 ns, "0110" after 70 ns, "0111" after 80 ns, "1000" after 90 ns, "1001" after 100 ns, --deberian salir todos ceros porque estoy en columna 0
				  "0000" after 110 ns, "0001" after 120 ns, "0010" after 130 ns, "0011" after 140 ns, "0100" after 150 ns, "0101" after 160 ns, "0110" after 170 ns, "0111" after 180 ns, "1000" after 190 ns, "1001" after 200 ns; --varia el valor porque paso a la columna 1

    DUT: rom
        port map(
            char_address => char_address_tb,
            font_col     => font_col_tb,
            font_row     => font_row_tb,
            rom_out      => rom_out_tb
        );
end;