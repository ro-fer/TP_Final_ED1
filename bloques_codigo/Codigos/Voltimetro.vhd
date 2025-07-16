-- Voltímetro VGA Intermedio
-- Estudiante: Fernández, Rocío

entity Voltimetro is
  port (
    clk_volti           : in bit;
    rst_volti           : in bit;
    voltaje_i  : in bit; --tension de entrada
    voltaje_s : out bit; --salida negada del FFD de entrada: retroalimentacion
    hs_o            : out bit;
    vs_o            : out bit;
    r_o           : out bit;
    g_o           : out bit;
    b_o           : out bit
  );
end entity;

architecture volti_arq of volti is 

    component ffd is 
        port (
            clk_i   : in bit;
            rst_i   : in bit;
            ena_i   : in bit;
            d_i     : in bit;
            q_o     : out bit
        );
    end component;

    component cont_bin_gen is   -- para el clk de 25 MHz
        generic(
            N: natural := 2 
        );
    
        port (
            clk_bin_gen : in bit;
            ena_bin_gen : in bit;
            rst_bin_gen : in bit;
            salida_gen  : out bit_vector(N-1 downto 0)
        );
    end component;

    component cont_33k is 
        port (
            clk_33k : in bit;
            rst_33k : in bit;   
            ena_33k : in bit;   
            out_1   : out bit;  -- se va a habilitar el registro
            out_2   : out bit;   -- se va a resetear el contador de unos 
            cuenta  : out bit_vector(21 downto 0)
        );
    end component;

    component cont_unos is 
        port (
            clk_unos:   in bit;
            rst_unos:   in bit;
            ena_unos:   in bit;
            q_bcd1:     out bit_vector(3 downto 0);
            q_bcd2:     out bit_vector(3 downto 0);
            q_bcd3:     out bit_vector(3 downto 0);
            q_bcd4:     out bit_vector(3 downto 0);
            q_bcd5:     out bit_vector(3 downto 0);
            q_bcd6:     out bit_vector(3 downto 0);
            q_bcd7:     out bit_vector(3 downto 0)
        );
    end component;

    component reg is 
        port (
            clk_reg : in bit;
            rst_reg : in bit;
            ena_reg : in bit;
            d1_reg  : in bit_vector(3 downto 0);
            d2_reg  : in bit_vector(3 downto 0);
            d3_reg  : in bit_vector(3 downto 0);
            q1_reg  : out bit_vector(3 downto 0);
            q2_reg  : out bit_vector(3 downto 0);
            q3_reg  : out bit_vector(3 downto 0)
        );
    end component;

    component mux is
        port(
            bcd1    : in bit_vector(3 downto 0);
            punto   : in bit_vector(3 downto 0); -- '.'
            bcd2    : in bit_vector(3 downto 0);
            bcd3    : in bit_vector(3 downto 0);
            voltaje : in bit_vector(3 downto 0); -- 'V'
            espacio : in bit_vector(3 downto 0); -- ' ' 
            selector: in bit_vector(2 downto 0); -- selecciona una de las 6 entradas
            salida  : out bit_vector(3 downto 0)  -- se va a la ROM
        );
    end component;

    component rom is 
        port(
            char_address : bit_vector(3 downto 0); 
            font_col     : bit_vector(2 downto 0); 
            font_row     : bit_vector(2 downto 0);
            rom_out      : out bit
        ); 
    end component;

    component vga is 
        port( 
            ena_vga      : in bit;
            rst_vga      : in bit;
            clk_vga      : in bit;
            r_i_vga      : in bit;
            g_i_vga      : in bit; 
            b_i_vga      : in bit; 
            hsync_vga    : out bit;
            vsync_vga    : out bit;
            vidon_vga    : out bit;
            vvidon_vga   : out bit;
            r_o_vga      : out bit;
            g_o_vga      : out bit;
            b_o_vga      : out bit;
            selector_vga : out bit_vector(2 downto 0);
            pixelx_vga   : out bit_vector(2 downto 0);
            pixely_vga   : out bit_vector(2 downto 0)
        );
    end component;

    signal clk_2b               : bit_vector(1 downto 0) := "00";   -- clk del contador de 2 bits de entradas
    
    signal clk                  : bit := '0';                       -- clk general  
    signal sal_ffd_entrada      : bit := '0';                       -- salida del ffd de entrada 
    signal cont_a_registro      : bit := '0';                       -- habilitador del registro 
    signal cont_a_cont_unos     : bit := '0';                       -- rst del contador de unos 

    signal sal_bcd_7            : bit_vector(3 downto 0) := "0000"; -- salida del BCD1 del contador de unos 
    signal sal_bcd_6            : bit_vector(3 downto 0) := "0000"; -- salida del BCD2 del contador de unos 
    signal sal_bcd_5            : bit_vector(3 downto 0) := "0000"; -- salida del BCD3 del contador de unos 
    
    signal sal_reg_1            : bit_vector(3 downto 0) := "0000"; -- salida del reg1 del registro
    signal sal_reg_2            : bit_vector(3 downto 0) := "0000"; -- salida del reg2 del registro
    signal sal_reg_3            : bit_vector(3 downto 0) := "0000"; -- salida del reg3 del registro
    
    signal sal_mux              : bit_vector(3 downto 0) := "0000"; -- salida del mux a la rom
    
    signal sal_rom              : bit := '0';                       -- salida de la rom a la vga
    
    signal sal_vidon            : bit := '0';                       -- salida del vidon de la vga
    signal sal_v_vidon          : bit := '0';

    signal selector_mux         : bit_vector(2 downto 0) := "000";  -- selector del mux
    signal pixelx               : bit_vector(2 downto 0) := "000";  -- sale de vga a font_col de la rom
    signal pixely               : bit_vector(2 downto 0) := "000";  -- sale de vga a font_row de la rom

    --entrada al registro
	signal ena_reg_s : bit := '0';	--habilito cuando el contador 330 llega a 0 AND vidon = '1'

    ---- SEÑALES QUE MUEREN
    signal salida_cuenta        : bit_vector(21 downto 0) := (21 downto 0 => '0');  -- salida de la cuenta del cont_33k
    signal sal_bcd_1            : bit_vector(3 downto 0) := "0000";
    signal sal_bcd_2            : bit_vector(3 downto 0) := "0000";
    signal sal_bcd_3            : bit_vector(3 downto 0) := "0000";
    signal sal_bcd_4            : bit_vector(3 downto 0) := "0000";



begin


    FFD_ENTRADA: ffd
        port map(
            clk_i   => clk,
            rst_i   => rst_volti,
            ena_i   => '1',
            d_i     => voltaje_i,
            q_o     => sal_ffd_entrada
        );

    CONT_2B: cont_bin_gen 
        port map (
            clk_bin_gen => clk_volti,
            ena_bin_gen => '1',
            rst_bin_gen => rst_volti,
            salida_gen  => clk_2b
        );

    CONT_BINARIO: cont_33k  
        port map(
            clk_33k => clk,
            rst_33k => rst_volti,  
            ena_33k => '1',   
            out_1   => cont_a_registro,         -- se va a habilitar el registro
            out_2   => cont_a_cont_unos,        -- se va a resetear el contador de unos, un ciclo de reloj despues del out_1
            cuenta  => salida_cuenta            -- no va a ningun lado
        );

    CONT_1S: cont_unos 
        port map(
            clk_unos    => clk,
            rst_unos    => cont_a_cont_unos,    -- le llega una de las salidas del contador binario
            ena_unos    => sal_ffd_entrada,     -- le llega la salida del ffd de entrada
            q_bcd1      => sal_bcd_1,           -- muere
            q_bcd2      => sal_bcd_2,           -- muere
            q_bcd3      => sal_bcd_3,           -- muere
            q_bcd4      => sal_bcd_4,           -- muere
            q_bcd5      => sal_bcd_5,            -- se va al reg 1
            q_bcd6      => sal_bcd_6,           -- se va al reg 2
            q_bcd7      => sal_bcd_7            -- se va al reg 3
        );

    REGISTRO: reg  
        port map(
            clk_reg => clk,
            rst_reg => rst_volti,
            ena_reg => ena_reg_s,               -- viene de un and del vidon en 1 y cont 33000
            d1_reg  => sal_bcd_7,               -- viene del las centenas del contador de unos (3er bit + significativo)
            d2_reg  => sal_bcd_6,               -- viene del las decenas del contador de unos (2do bit + significativo)
            d3_reg  => sal_bcd_5,               -- viene del las unidades del contador de unos (bit + significativo)
            q1_reg  => sal_reg_1,               -- se va a entrada 1 del mux
            q2_reg  => sal_reg_2,               -- se va a entrada 2 del mux
            q3_reg  => sal_reg_3                -- se va a entrada 3 del mux
        );

    MX: mux 
        port map(
            bcd1        => sal_reg_1,           -- viene del primer registro
            punto       => "1010",              -- codigo '.'
            bcd2        => sal_reg_2,           -- viene del segundo registro
            bcd3        => sal_reg_3,           -- viene del tercer registro
            voltaje     => "1011",              -- codigo 'V'
            espacio     => "1100",              -- codigo ' '
            selector    => selector_mux,        -- viene de la vga
            salida      => sal_mux              -- salida del mux, se va a char_address de la rom
        );

    ROM_MEMORIA: rom  
        port map(
            char_address => sal_mux,            -- viene del mux, trae el dato 
            font_col     => pixelx,             -- datos 654 del contH             
            font_row     => pixely,             -- datos 654 del contV
            rom_out      => sal_rom             -- saca el dato
        );

    VGA_vga: vga
    port map( 
        ena_vga      => '1',              
        rst_vga      => rst_volti,
        clk_vga      => clk,
        r_i_vga      => sal_rom,                -- viene de la rom, cuando es '1' todos los colores en 1 hacen blanco
        g_i_vga      => sal_rom,                -- viene de la rom, cuando es '1' todos los colores en 1 hacen blanco b_i_vga      => '1',                    -- siempre es 1, hace que el fondo sea azul
        hsync_vga    => hs_o,                   -- sale el sincronismo horizontal
        vsync_vga    => vs_o,                   -- sale el sincronismo vertical
        vidon_vga    => sal_vidon,
        vvidon_vga   => sal_v_vidon,
        r_o_vga      => r_o,                    -- sale el color rojo
        g_o_vga      => g_o,                    -- sale el color verde
        b_o_vga      => b_o,                    -- sale el color azul
        selector_vga => selector_mux,           -- saca el valor del selector que ingresa al mux 
        pixelx_vga   => pixelx,                 -- salen los bits 654 del contador horizontal
        pixely_vga   => pixely                  -- salen los bits 654 del contador 
    );
    
    ena_reg_s <= cont_a_registro and sal_v_vidon;	--habilito el registro cuando el contador 330 llega a 0 AND vidon = '1'
    clk         <= clk_2b(1);                   -- cuarto del reloj
    voltaje_s   <= not sal_ffd_entrada;         -- retroalimentacion

end;