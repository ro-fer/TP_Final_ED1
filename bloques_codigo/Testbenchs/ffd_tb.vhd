--Test de ffd
library IEEE;
use IEEE.std_logic_1164.all;

entity ffd_tb is
end;

architecture ffd_tb_arq of ffd_tb is 

    component ffd is 
        port(
            clk_i   : in std_logic;
            rst_i   : in std_logic;
            ena_i   : in std_logic;
            d_i     : in std_logic;
            q_o     : out std_logic
        );
    end component;

    -- seniales del testbench (USAR std_logic, no bit)
    signal clk_i_tb   : std_logic := '0';
    signal rst_i_tb   : std_logic := '0';
    signal ena_i_tb   : std_logic := '0';
    signal d_i_tb     : std_logic := '0';
    signal q_o_tb     : std_logic;

begin 
    -- estimulos
    ena_i_tb    <= '1' after 10 ns, '0' after 70 ns; 
    d_i_tb      <= '1' after 20 ns, '0' after 30 ns, '1' after 40 ns, '0' after 80 ns; 
    rst_i_tb    <= '1' after 50 ns, '0' after 60 ns; 
    clk_process : process
    begin
        while true loop
            clk_i_tb <= '0';
            wait for 5 ns;
            clk_i_tb <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- DUT
    DUT: ffd
        port map(
            clk_i => clk_i_tb,
            rst_i => rst_i_tb,
            ena_i => ena_i_tb,
            d_i   => d_i_tb,
            q_o   => q_o_tb
        );
end architecture;