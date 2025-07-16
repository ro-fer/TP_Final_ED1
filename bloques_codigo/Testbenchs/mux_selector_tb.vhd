-- Test selector mux (LOGICA)
library IEEE;
use IEEE.bit_1164.all;
use IEEE.numeric_std.all;

entity mux_selector_tb is 
end;

architecture mux_selector_tb_arq of mux_selector_tb is 

    component mux_selector is 
        port(
            A_selector   : in bit_vector(2 downto 0);
            B_selector   : in bit_vector(2 downto 0);
            sel_selector : in bit;
            sal_selector : out bit_vector(2 downto 0)
        );
    end component;

    signal A_selector_tb    : bit_vector(2 downto 0) := (2 downto 0 => '0');
    signal B_selector_tb    : bit_vector(2 downto 0) := (2 downto 0 => '0');
    signal sel_selector_tb  : bit := '0';
    signal sal_selector_tb  : bit_vector(2 downto 0) := (2 downto 0 => '0');

begin

    A_selector_tb   <= "111" after 10 ns;
    B_selector_tb   <= "110" after 10 ns;
    sel_selector_tb <= '1' after 10 ns, '0' after 20 ns, '1' after 30 ns;

    DUT: mux_selector
        port map(
            A_selector   => A_selector_tb,
            B_selector   => B_selector_tb,
            sel_selector => sel_selector_tb,
            sal_selector => sal_selector_tb
        );
end;