-- Test MUX

entity mux_tb is
end;

architecture mux_tb_arq of mux_tb is 
    
    component mux is
        port(
            bcd1    : in bit_vector(3 downto 0);
            punto   : in bit_vector(3 downto 0); -- '.'
            bcd2    : in bit_vector(3 downto 0);
            bcd3    : in bit_vector(3 downto 0);
            voltaje : in bit_vector(3 downto 0); -- 'V'
            espacio : in bit_vector(3 downto 0); -- ' ' 
            selector: in bit_vector(2 downto 0); -- selecciona una de las 6 entradas
            salida  : out bit_vector(3 downto 0)  -- se va a la ROM
        );
    end component;

    signal bcd1_tb      : bit_vector(3 downto 0) := (3 downto 0 => '0');
    signal punto_tb     : bit_vector(3 downto 0) := (3 downto 0 => '0');
    signal bcd2_tb      : bit_vector(3 downto 0) := (3 downto 0 => '0');
    signal bcd3_tb      : bit_vector(3 downto 0) := (3 downto 0 => '0');
    signal voltaje_tb   : bit_vector(3 downto 0) := (3 downto 0 => '0');
    signal espacio_tb   : bit_vector(3 downto 0) := (3 downto 0 => '0');
    signal selector_tb  : bit_vector(2 downto 0) := (2 downto 0 => '0');
    signal salida_tb    : bit_vector(3 downto 0) := (3 downto 0 => '0');

begin   

    bcd1_tb     <= "0001" after 10 ns; --1
    bcd2_tb     <= "0010" after 10 ns; --2 
    bcd3_tb     <= "0011" after 10 ns; --3
    punto_tb    <= "0100" after 10 ns; --4
    voltaje_tb  <= "0101" after 10 ns; --5 
    espacio_tb  <= "0111" after 10 ns; --7

    selector_tb <= "000" after 20 ns, "001" after 30 ns, "010" after 40 ns, "011" after 50 ns, "100" after 60 ns, "101" after 70 ns, "000" after 80 ns;

    DUT: mux
        port map(
            bcd1    => bcd1_tb,
            punto   => punto_tb,
            bcd2    => bcd2_tb,
            bcd3    => bcd3_tb,
            voltaje => voltaje_tb,
            espacio => espacio_tb,
            selector => selector_tb,
            salida  => salida_tb
        );
end;