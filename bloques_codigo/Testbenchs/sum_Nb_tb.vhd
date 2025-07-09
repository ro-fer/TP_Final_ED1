library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumNb_tb is
end;

architecture sumNb_tb_arq of sumNb_tb is
	constant N_tb : natural := 5;

	signal a_tb  : std_logic_vector(N_tb-1 downto 0);
	signal b_tb  : std_logic_vector(N_tb-1 downto 0);
	signal ci_tb : std_logic;
	signal s_tb  : std_logic_vector(N_tb-1 downto 0);
	signal co_tb : std_logic;

begin

	-- Instancia del DUT (Design Under Test)
	DUT: entity work.sum_Nb
		generic map (N => N_tb)
		port map (
			a_i => a_tb,
			b_i => b_tb,
			c_i => ci_tb,
			s_o => s_tb,
			c_o => co_tb
		);

	-- Proceso de estímulo
	process
	begin
		-- Caso 1
		a_tb  <= "00001";  -- 1
		b_tb  <= "00001";  -- 1
		ci_tb <= '0';
		wait for 100 ns;

		-- Caso 2
		a_tb  <= "00111";  -- 7
		b_tb  <= "00010";  -- 2
		ci_tb <= '1';
		wait for 100 ns;

		-- Caso 3
		a_tb  <= "11111";  -- 31
		b_tb  <= "00001";  -- 1
		ci_tb <= '0';
		wait for 100 ns;

		-- Fin
		wait;
	end process;

end;
