-- Test VGA

entity vga_controller_tb is 
end;

architecture vga_tb_arq of vga_controller_tb is 

    component vga_controller is 
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
    end component;

    signal ena_vga_tb       : bit := '0';
    signal rst_vga_tb       : bit := '0';
    signal clk_vga_tb       : bit := '0';
    signal r_i_vga_tb       : bit := '0';
    signal g_i_vga_tb       : bit := '0';
    signal b_i_vga_tb       : bit := '0';
    signal hsync_vga_tb     : bit := '0';
    signal vsync_vga_tb     : bit := '0';
    signal vidon_vga_tb     : bit := '0';
    signal r_o_vga_tb       : bit := '0';
    signal g_o_vga_tb       : bit := '0';
    signal b_o_vga_tb       : bit := '0';
    signal selector_vga_tb  : bit_vector(2 downto 0) := (2 downto 0 => '0');
    signal pixelx_vga_tb    : bit_vector(2 downto 0) := (2 downto 0 => '0');
    signal pixely_vga_tb    : bit_vector(2 downto 0) := (2 downto 0 => '0');

begin

    ena_vga_tb <= '1' after 10 ns;
    clk_vga_tb <= not clk_vga_tb after 20 ns;

    r_i_vga_tb <= not r_i_vga_tb after 20 ns;
    g_i_vga_tb <= not g_i_vga_tb after 20 ns;
    b_i_vga_tb <= not b_i_vga_tb after 20 ns;

    DUT: vga_controller
        port map(
            ena_vga      => ena_vga_tb,
            rst_vga      => rst_vga_tb,
            clk_vga      => clk_vga_tb,
            r_i_vga      => r_i_vga_tb,
            g_i_vga      => g_i_vga_tb,
            b_i_vga      => b_i_vga_tb, 
            hsync_vga    => hsync_vga_tb,
            vsync_vga    => vsync_vga_tb,
            vidon_vga    => vidon_vga_tb,
            r_o_vga      => r_o_vga_tb, 
            g_o_vga      => g_o_vga_tb,
            b_o_vga      => b_o_vga_tb,
            selector_vga => selector_vga_tb,
            pixelx_vga   => pixelx_vga_tb,
            pixely_vga   => pixely_vga_tb
        );
end;
    