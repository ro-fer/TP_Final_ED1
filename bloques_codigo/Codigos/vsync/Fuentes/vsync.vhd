-- SINCRONISMO VERTICAL
-- Estudiante : Fernandez, Rocio

entity vsync is 
    port (
        ena_vsync   : in bit;
        rst_vsync   : in bit;
        clk_vsync   : in bit;
        v_sync      : out bit;
        v_vidon     : out bit;
        cont_v      : out bit_vector(9 downto 0)
    );
end;

architecture vsync_arq of vsync is 

   -- contador binario, necesito que cuente hasta 525 por ende que sea de 10 bits
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
            A       : in bit_vector(9 downto 0);
            B       : in bit_vector(9 downto 0);
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

    signal cuenta_v     : bit_vector(9 downto 0) := (9 downto 0 => '0');
    signal reset_aux_v  : bit := '0';
    signal comp_479     : bit := '0';   -- 0111011111
    signal comp_489     : bit := '0';   -- 0111101001
    signal comp_491     : bit := '0';   -- 0111101011
    signal comp_524     : bit := '0';   -- 1000001100
    signal ena_479      : bit := '0';   -- '1' si ena general = '1' y cuenta_V = 479
    signal ena_489      : bit := '0';   -- '1' si ena general = '1' y cuenta_V = 489
    signal rst_491      : bit := '0';   -- '1' si ena general = '1' y cuenta_V = 491
    signal sal_vsync    : bit := '0';
    signal sal_vvidon   : bit := '0';

begin

    cont525: cont_bin_gen
        port map(
            clk_bin_gen => clk_vsync,
            ena_bin_gen => ena_vsync,
            rst_bin_gen => reset_aux_v,
            salida_gen  => cuenta_v
        );

    comp479: comp_Nb
        port map(
            A       => cuenta_v,
            B       => "0111011111", 
            s  => comp_479
        );

    comp489: comp_Nb
        port map(
            A       => cuenta_v,
            B       => "0111101001",
            s  => comp_489
        );

    comp491: comp_Nb
        port map(
            A       => cuenta_v,
            B       => "0111101011",
            s  => comp_491
        );

    comp524: comp_Nb
        port map(
            A       => cuenta_v,
            B       => "1000001100", 
            s  => comp_524
        );

    ffdvsync: ffd
        port map(
            clk_i   => clk_vsync,
            rst_i   => rst_491,
            ena_i   => ena_489,
            d_i     => '1',
            q_o     => sal_vsync
        );

    ffdvvidon: ffd
        port map(
            clk_i   => clk_vsync,
            rst_i   => reset_aux_v,
            ena_i   => ena_479,
            d_i     => '1',
            q_o     => sal_vvidon
        );

    v_sync       <= not sal_vsync;
    v_vidon      <= not sal_vvidon;
    cont_v      <= cuenta_v;    
    ena_479     <= comp_479 and ena_vsync;
    ena_489     <= comp_489 and ena_vsync;
    rst_491     <= comp_491 and ena_vsync;
    reset_aux_v <= ena_vsync and (rst_vsync or comp_524);

end;
