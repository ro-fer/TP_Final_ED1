-- sincronismo horizontal 
library IEEE;
use IEEE.bit_1164.all;
use IEEE.numeric_std.all;

entity hsync is 
    port (
        ena_hsync   : in bit;
        rst_hsync   : in bit;
        clk_hsync   : in bit;
        h_sync      : out bit;
        h_vidon     : out bit;
        ena_cv      : out bit;
        cont_h      : out bit_vector(9 downto 0)
    );

end; 

architecture hsync_arq of hsync is 

    -- contador binario, necesito que cuente hasta 800 --> 10 bits
    component cont_bin_gen is 
        generic(
            N: natural := 10 
        );
        port (
            clk_bin_gen : in bit;
            ena_bin_gen : in bit;
            rst_bin_gen : in bit;
            salida_gen  : out bit_vector(N-1 downto 0)
        );
    end component;

    component  comp_Nb is
        port ( 
            a       : in bit_vector(9 downto 0);
            b       : in bit_vector(9 downto 0);
            s  : out bit
        );
    end component;

    component ffd is 
        port(
            clk_i   : in bit;
            rst_i   : in bit;
            ena_i   : in bit;
            d_i     : in bit;
            q_o     : out bit
        );
    end component;

    signal cuenta       : bit_vector(9 downto 0) := (9 downto 0 => '0');
    signal reset_aux    : bit := '0';
    signal comp_639     : bit := '0';   -- 1001111111
    signal comp_655     : bit := '0';   -- 1010001111
    signal comp_751     : bit := '0';   -- 1011101111
    signal comp_799     : bit := '0';   -- 1100011111
    signal sal_hsync    : bit := '0';
    signal sal_hvidon   : bit := '0';

begin

    -- contador hasta 800 = 1100100000
    cont800: cont_bin_gen
        port map (
            clk_bin_gen => clk_hsync,
            ena_bin_gen => ena_hsync,
            rst_bin_gen => reset_aux,
            salida_gen  => cuenta           
        );

    -- comparadores 

    comp639: comparador 
        port map(
            a       => cuenta,
            b       => "1001111111",
            s  =>  comp_639
        );

    comp655: comparador 
        port map(
            a       => cuenta,
            b       => "1010001111",
            s  =>  comp_655
        );
        
    comp751: comparador 
        port map(
            a       => cuenta,
            b       => "1011101111",
            s  => comp_751
        );
        
    comp799: comparador 
        port map(
            a       => cuenta,
            b       => "1100011111",
            s  => comp_799
        );
    
    -- necesito 2 ffd para negar las salidas y asi generar los pulsos 

    ffdhsync: ffd
        port map(
            clk_i   => clk_hsync,
            rst_i   => comp_751,
            ena_i   => comp_655,
            d_i     => '1',
            q_o     => sal_hsync
        );

    ffdhvidon: ffd
        port map(
            clk_i   => clk_hsync,
            rst_i   => comp_799,
            ena_i   => comp_639,
            d_i     => '1',
            q_o     => sal_hvidon
        );

    h_sync       <= not sal_hsync;           -- niego la salida del ffd y sale
    h_vidon      <= not sal_hvidon;          -- niego la salida del ffd y sale
    ena_cv      <= comp_799;                -- cuando el contador llega a 799 habilita al contador vertical
    cont_h      <= cuenta;                  -- saco la salida del contador
    -- el contador horiz se resetea por rst del sistema o por fin de cuenta 799 = 1100011111
    reset_aux   <= rst_hsync or comp_799;   
end;