-- Comparador de N bits
-- Estudiante: Fernandez, Rocio

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity comp_Nb is
	generic(N: natural := 10);
	port(
		a: in std_logic_vector(N-1 downto 0); 	-- Numero A
		b: in std_logic_vector(N-1 downto 0); 	-- Numero B
		s: out std_logic 						-- Si numeros iguales, me devuelve uno
	);
end;

architecture comp_Nb_arq of comp_Nb is
    signal and_aux: std_logic_vector(N downto 0);
    signal xnor_aux: std_logic_vector(N-1 downto 0);
	
begin
	gene: for i in 0 to N-1 generate
		xnor_aux(i) <= a(i) xnor b(i); -- comparo cada bit, obtengo 1 si son =
		and_aux(i+1) <= xnor_aux(i) and and_aux(i); -- si algun bit fue distinto, valdra 0
	end generate;
	and_aux(0) <= '1';
	s <= and_aux(N); -- Guardo 1 solo si todos los bits son iguales
	
end;