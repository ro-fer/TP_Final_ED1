-- Flip - Flop D con enable y reset
-- Estudiante: Fernandez, Rocio

library IEEE;
use IEEE.std_logic_1164.all;

entity ffd is
	port (
		clk_i : in std_logic; -- Clock
		rst_i : in std_logic; -- Reset
		ena_i : in std_logic; -- Enable
		d_i   : in std_logic; -- Dato
		q_o   : out std_logic -- Salida
	);
end ffd;

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
end ffd_arc;
