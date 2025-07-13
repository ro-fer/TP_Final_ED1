library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga_controller_tb is
end;

architecture sim of vga_controller_tb is

    -- Componente a testear
    component vga_controller is
        port(
            clk_i     : in  std_logic;
            rst_i     : in  std_logic;
            hsync_o   : out std_logic;
            vsync_o   : out std_logic;
            video_on  : out std_logic;
            pix_x_o   : out std_logic_vector(9 downto 0);
            pix_y_o   : out std_logic_vector(9 downto 0)
        );
    end component;

    -- Señales internas
    signal clk_tb      : std_logic := '0';
    signal rst_tb      : std_logic := '1';
    signal hsync_tb    : std_logic;
    signal vsync_tb    : std_logic;
    signal video_on_tb : std_logic;
    signal pix_x_tb    : std_logic_vector(9 downto 0);
    signal pix_y_tb    : std_logic_vector(9 downto 0);

begin

    -- Instanciar el DUT
    DUT: vga_controller
        port map (
            clk_i     => clk_tb,
            rst_i     => rst_tb,
            hsync_o   => hsync_tb,
            vsync_o   => vsync_tb,
            video_on  => video_on_tb,
            pix_x_o   => pix_x_tb,
            pix_y_o   => pix_y_tb
        );

    -- Clock de 25 MHz (40 ns periodo → 20 ns por nivel)
    clk_process: process
    begin
        while true loop
            clk_tb <= '0';
            wait for 20 ns;
            clk_tb <= '1';
            wait for 20 ns;
        end loop;
    end process;

    -- Estímulos
    stim_proc: process
    begin
        -- Reset inicial
        wait for 100 ns;
        rst_tb <= '0';
        wait for 17 ms;
        -- Ejecutar por algunos microsegundos
        wait for 5 ms;
        wait;
    end process;

end architecture;
