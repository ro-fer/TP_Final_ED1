-- Repositorio para crear vector de datos

library IEEE;
use IEEE.std_logic_1164.all;

package utils is
    subtype BCD is std_logic_vector(3 downto 0);
    type vectBCD is array (natural range <>) of BCD;
end package;

package body utils is
end package body;
