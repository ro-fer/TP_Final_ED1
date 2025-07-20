--mux
-- le llegan 3 datos , los otros 3 son "."  " " y "V"
-- sal --> 6 datos
-- Estudiante : Fernandez, Rocio


entity mux is
    port(
        bcd1    : in  bit_vector(3 downto 0);
        punto   : in  bit_vector(3 downto 0); -- '.'
        bcd2    : in  bit_vector(3 downto 0);
        bcd3    : in  bit_vector(3 downto 0);
        voltaje : in  bit_vector(3 downto 0); -- 'V'
        espacio : in  bit_vector(3 downto 0); -- ' ' 
        selector: in  bit_vector(2 downto 0); -- selecciona una de las 6 entradas
        salida  : out bit_vector(3 downto 0)  -- se va a la ROM
    );
end;

architecture mux_arq of mux is 

    signal salida_bcd1      : bit_vector(3 downto 0);
    signal salida_punto     : bit_vector(3 downto 0);
    signal salida_bcd2      : bit_vector(3 downto 0);
    signal salida_bcd3      : bit_vector(3 downto 0);
    signal salida_voltaje   : bit_vector(3 downto 0);
    signal salida_espacio   : bit_vector(3 downto 0);

begin
    --                               "   0                       0                   0 "
    salida_bcd1(0) <= bcd1(0) and (not(selector(2)) and not(selector(1)) and not (selector(0)));
    salida_bcd1(1) <= bcd1(1) and (not(selector(2)) and not(selector(1)) and not (selector(0)));
    salida_bcd1(2) <= bcd1(2) and (not(selector(2)) and not(selector(1)) and not (selector(0)));
    salida_bcd1(3) <= bcd1(3) and (not(selector(2)) and not(selector(1)) and not (selector(0)));

    --                               "   0                       0                   1 "
    salida_punto(0) <= punto(0) and (not(selector(2)) and not(selector(1)) and (selector(0)));
    salida_punto(1) <= punto(1) and (not(selector(2)) and not(selector(1)) and (selector(0)));
    salida_punto(2) <= punto(2) and (not(selector(2)) and not(selector(1)) and (selector(0)));
    salida_punto(3) <= punto(3) and (not(selector(2)) and not(selector(1)) and (selector(0)));

    --                               "   0                       1                   0 "
    salida_bcd2(0) <= bcd2(0) and (not(selector(2)) and (selector(1)) and not (selector(0)));
    salida_bcd2(1) <= bcd2(1) and (not(selector(2)) and (selector(1)) and not (selector(0)));
    salida_bcd2(2) <= bcd2(2) and (not(selector(2)) and (selector(1)) and not (selector(0)));
    salida_bcd2(3) <= bcd2(3) and (not(selector(2)) and (selector(1)) and not (selector(0)));

    --                               "   0                       1                   1 "
    salida_bcd3(0) <= bcd3(0) and (not(selector(2)) and (selector(1)) and (selector(0)));
    salida_bcd3(1) <= bcd3(1) and (not(selector(2)) and (selector(1)) and (selector(0)));
    salida_bcd3(2) <= bcd3(2) and (not(selector(2)) and (selector(1)) and (selector(0)));
    salida_bcd3(3) <= bcd3(3) and (not(selector(2)) and (selector(1)) and (selector(0)));

    --                               "   1                       0                   0 "
    salida_voltaje(0) <= voltaje(0) and ((selector(2)) and not(selector(1)) and not (selector(0)));
    salida_voltaje(1) <= voltaje(1) and ((selector(2)) and not(selector(1)) and not (selector(0)));
    salida_voltaje(2) <= voltaje(2) and ((selector(2)) and not(selector(1)) and not (selector(0)));
    salida_voltaje(3) <= voltaje(3) and ((selector(2)) and not(selector(1)) and not (selector(0)));


    --                               "   1                       0                   1 "            "   1                 1                   1 "       "   1                 1                   0"
    salida_espacio(0) <= espacio(0) and (((selector(2)) and not(selector(1)) and (selector(0))) or (selector(2) and selector(1) and selector(0)) or (selector(2) and selector(1) and not selector(0)));
    salida_espacio(1) <= espacio(1) and (((selector(2)) and not(selector(1)) and (selector(0))) or (selector(2) and selector(1) and selector(0)) or (selector(2) and selector(1) and not selector(0)));
    salida_espacio(2) <= espacio(2) and (((selector(2)) and not(selector(1)) and (selector(0))) or (selector(2) and selector(1) and selector(0)) or (selector(2) and selector(1) and not selector(0)));
    salida_espacio(3) <= espacio(3) and (((selector(2)) and not(selector(1)) and (selector(0))) or (selector(2) and selector(1) and selector(0)) or (selector(2) and selector(1) and not selector(0)));

    --
    salida(0) <= salida_bcd1(0) or salida_punto (0) or salida_bcd2(0) or salida_bcd3(0) or salida_voltaje(0) or salida_espacio(0);
    salida(1) <= salida_bcd1(1) or salida_punto (1) or salida_bcd2(1) or salida_bcd3(1) or salida_voltaje(1) or salida_espacio(1);
    salida(2) <= salida_bcd1(2) or salida_punto (2) or salida_bcd2(2) or salida_bcd3(2) or salida_voltaje(2) or salida_espacio(2);
    salida(3) <= salida_bcd1(3) or salida_punto (3) or salida_bcd2(3) or salida_bcd3(3) or salida_voltaje(3) or salida_espacio(3);

end;