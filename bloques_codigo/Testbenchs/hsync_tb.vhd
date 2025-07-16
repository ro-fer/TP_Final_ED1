-- Test sincronismo horizontal

library IEEE;
use IEEE.bit_1164.all;
use IEEE.numeric_std.all;

entity hsync_tb is 
end;

architecture hsync_tb_arq of hsync_tb is 

    component hsync is 
        port (
            ena_hsync   : in bit;
            rst_hsync   : in bit;
            clk_hsync   : in bit;
            h_sync      : out bit;
            h_vidon     : out bit;
            ena_cv      : out bit;
            cont_h      : out bit_vector(9 downto 0)
        );
    
    end component;

    
    signal ena_hsync_tb   : bit := '0';
    signal rst_hsync_tb   : bit := '0';
    signal clk_hsync_tb   : bit := '0';
    signal h_sync_tb      : bit := '0';
    signal h_vidon_tb     : bit := '0';
    signal ena_cv_tb      : bit := '0';
    signal cont_h_tb      : bit_vector(9 downto 0) := (9 downto 0 => '0');

begin

    ena_hsync_tb <= '1' after 10 ns;
    clk_hsync_tb <= not clk_hsync_tb after 20 ns;
    -- rst_hsync_tb <= '1' after 30 ns, '0' after 40 ns;

    DUT: hsync
        port map(
            ena_hsync   => ena_hsync_tb,
            rst_hsync   => rst_hsync_tb,
            clk_hsync   => clk_hsync_tb,
            h_sync      => h_sync_tb,
            h_vidon     => h_vidon_tb,
            ena_cv      => ena_cv_tb,
            cont_h      => cont_h_tb
        );
end;
    