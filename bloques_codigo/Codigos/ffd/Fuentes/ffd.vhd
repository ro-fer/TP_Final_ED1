-- Flip - Flop D con enable y reset
-- Estudiante: Fernandez, Rocio

library IEEE;
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
        if (clk_i'event and clk_i = '1') then 
            if rst_i = '1' then         -- si el reset esta prendido pone salida en cero
                q_o <= '0';
            elsif ena_i = '1' then      -- si el habilitador esta prendido pone en la salida el valor del dato de entrada 
                q_o <= d_i;
            end if;
        end if;
    end process;
end;