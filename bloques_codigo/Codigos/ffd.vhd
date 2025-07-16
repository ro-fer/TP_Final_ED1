-- Flip - Flop D con enable y reset
-- Estudiante: Fernandez, Rocio
library IEEE;
use IEEE.bit_1164.all;
use IEEE.numeric_std.all;

entity ffd is
	port (
		clk_i : in bit; -- Clock
		rst_i : in bit; -- Reset
		ena_i : in bit; -- Enable
		d_i   : in bit; -- Dato
		q_o   : out bit -- Salida
	);
end entity;

architecture ffd_arc of ffd is
begin
	process(clk_i)
	begin
		if rising_edge(clk_i) then 
			if rst_i = '1' then         -- Reset activo
				q_o <= '0';
			elsif ena_i = '1' then      -- Enable activo
				q_o <= d_i;
			end if;
		end if;
	end process;
end architecture;