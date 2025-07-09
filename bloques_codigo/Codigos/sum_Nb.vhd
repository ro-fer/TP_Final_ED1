-- Sumador de N bit

-- Estudiante: Fernandez, Rocio

library IEEE;
use IEEE.std_logic_1164.all;

entity sum_Nb is
	generic(
		N: natural := 4 -- defino valor default 4bits
	);
	port(
		a_i: in std_logic_vector(N-1 downto 0); -- Vector de entrada a
		b_i: in std_logic_vector(N-1 downto 0); -- Vector de entrada b
		c_i: in std_logic; -- Carry de entrada
		s_o: out std_logic_vector(N-1 downto 0); -- Suma de los vectores
		c_o: out std_logic -- Carry de salida
	);
end;

architecture sum_Nb_arq of sum_Nb is
	signal c_aux: std_logic_vector(N downto 0);
begin
	sum_Nb_gen: for i in 0 to N-1 generate
		sum1b_inst: entity work.sum_1b
			port map(
				a_i	=> a_i(i),
				b_i	=> b_i(i),
				c_i	=> c_aux(i),
				s_o	=> s_o(i),
				c_o 	=> c_aux(i+1)
			);
	end generate;
	-- Conexiones
	
	c_o <= c_aux(N);
end;