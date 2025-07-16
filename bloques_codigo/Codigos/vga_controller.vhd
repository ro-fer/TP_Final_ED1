-- Mostrar en VGA 
-- Estudiante: Fernández, Rocío




entity vga_controller is

  port(
    clk_vga     : in  bit; -- Clock
    rst_vga     : in  bit; -- Reset
    ena_vga      : in bit;
    r_i_vga      : in bit;
    g_i_vga      : in bit; 
    b_i_vga      : in bit; 
    -- salidas
    hsync_vga   : out  bit;                  
    vsync_vga   : out  bit;                
    vidon_vga  : out   bit;       -- '1' si estamos en la zona visible
    vvidon_vga   : out bit;
    r_o_vga      : out bit;
    g_o_vga      : out bit;
    b_o_vga      : out bit;
    selector_vga : out bit_vector(2 downto 0);
    pixelx_vga   : out bit_vector(2 downto 0);
    pixely_vga   : out bit_vector(2 downto 0)
  );
end entity;

architecture rtl of vga_controller is

  component hsync is 
        port (
            ena_hsync   : in  bit;
            rst_hsync   : in  bit;
            clk_hsync   : in  bit;
            h_sync      : out bit;
            h_vidon     : out bit;
            ena_cv      : out bit;
            cont_h      : out bit_vector(9 downto 0)
        );
    
    end component;

    component vsync is 
        port (
            ena_vsync   : in  bit;
            rst_vsync   : in  bit;
            clk_vsync   : in  bit;
            v_sync      : out bit;
            v_vidon     : out bit;
            cont_v      : out bit_vector(9 downto 0)
        );
    end component;

    component mux_color is 
        port(
            RGB : in  bit;
            B   : in  bit;
            sel : in  bit;
            sal : out bit
        );
    end component;

    component mux_selector is 
        port(
            A_selector   : in  bit_vector(2 downto 0);
            B_selector   : in  bit_vector(2 downto 0);
            sel_selector : in  bit;
            sal_selector : out bit_vector(2 downto 0)
        );
    end component;

    signal cont_h_vga   : bit_vector(9 downto 0) := (9 downto 0 => '0'); -- salida cont horiz
    signal cont_v_vga   : bit_vector(9 downto 0) := (9 downto 0 => '0'); -- salida cont vert
    signal ena_cv_vga   : bit := '0';                                    -- fin de cuenta CH q habilita el CV   
    signal h_vidon_vga  : bit := '0';                                    -- salida vidon del CH   
    signal v_vidon_vga  : bit := '0';                                    -- salida vidon del CV
    signal vidon_s_vga  : bit := '0';                                    -- indicador zona de video, va al selector de los mux_color
    signal B_selec_vga  : bit_vector(2 downto 0) := (2 downto 0 => '0'); -- dato de entrada de mux_delector
    signal selec_cv_vga : bit := '0';                                    -- '1' si esta en la franja del monitor q quiero ver, llega de los ultimos digitos del contador vert


begin

  sincronismo_horizontal: hsync
        port map(
            ena_hsync   => ena_vga, 
            rst_hsync   => rst_vga, 
            clk_hsync   => clk_vga, 
            h_sync      => hsync_vga, 
            h_vidon     => h_vidon_vga, 
            ena_cv      => ena_cv_vga, 
            cont_h      => cont_h_vga 
        );
    
    sincronismo_vertical: vsync
        port map(
            ena_vsync   => ena_cv_vga,
            rst_vsync   => rst_vga,
            clk_vsync   => clk_vga,
            v_sync      => vsync_vga,
            v_vidon     => v_vidon_vga,
            cont_v      => cont_v_vga
        );

    -- vidon es la interseccion entre el vidon_h y el vidon_v
    -- vidon_s_vga es el selector de los mux_color
    vidon_s_vga     <= v_vidon_vga and h_vidon_vga;

    -- necesito 3 mux_color, uno para cada color. le paso un color, si el selector es 1 me saca el color (RGB), si el selector es 0 saca B
    mux_r: mux_color
        port map(
            RGB => r_i_vga,
            B   => '0',
            sel => vidon_s_vga,
            sal => r_o_vga
        );

    mux_g: mux_color
        port map(
            RGB => g_i_vga,
            B   => '0',
            sel => vidon_s_vga,
            sal => g_o_vga
        );

    mux_b: mux_color
        port map(
            RGB => b_i_vga,
            B   => '0',
            sel => vidon_s_vga,
            sal => b_o_vga
        );

    B_selec_vga     <= cont_h_vga(9 downto 7); -- 3 + significativos
    selec_cv_vga    <= (not(cont_v_vga(9)) and not(cont_v_vga(8)) and (cont_v_vga(7))); -- aca elijo la franja que quiero mostrar (000,001,010,011) --> elijo la 2da (001)

    -- este selector cuando esta en 0, saca '111' (blanco o espacio). cuando está en 1 saca los 3 bits mas significativos del contador H
    -- es decir, si estoy en la SEGUNDA FRANJA (contV = "001xxxxxxx") me va a mostrar los datos del contH
    mux_selec: mux_selector 
        port map(
            A_selector   => "111",
            B_selector   => B_selec_vga, -- ultimos 3 digitos del CH
            sel_selector => selec_cv_vga,
            sal_selector => selector_vga
        );

    
    vidon_vga       <= not vidon_s_vga; 
    vvidon_vga <= v_vidon_vga;

    pixelx_vga      <= cont_h_vga(6 downto 4); -- saca la posicion de pixel x, indica en que COLUMNA esta, va a la ROM directo
    pixely_vga      <= cont_v_vga(6 downto 4); -- saca la posicion de pixel y, indica en que FILA esta, va a la ROM directo

end architecture;
