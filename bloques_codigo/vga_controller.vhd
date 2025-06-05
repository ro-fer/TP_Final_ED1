-- Mostrar en VGA 
-- Estudiante: Fernández, Rocío


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga_controller is
  port(
    clk_i     : in  std_logic;                  -- Clock
    rst_i     : in  std_logic;                  -- Reset
    hsync_o   : out std_logic;                  
    vsync_o   : out std_logic;                
    video_on  : out std_logic;                  -- '1' si estamos en la zona visible
    pix_x_o   : out std_logic_vector(9 downto 0); -- Coordenada X del píxel (0 a 639)
    pix_y_o   : out std_logic_vector(9 downto 0)  -- Coordenada Y del píxel (0 a 479)
  );
end entity;

architecture rtl of vga_controller is

  -- Parámetros para resolución 640x480 @60Hz con clock de 25 MHz
  constant H_DISPLAY   : integer := 640;
  constant H_FRONT     : integer := 16;
  constant H_SYNC      : integer := 96;
  constant H_BACK      : integer := 48;
  constant H_MAX       : integer := H_DISPLAY + H_FRONT + H_SYNC + H_BACK;

  constant V_DISPLAY   : integer := 480;
  constant V_FRONT     : integer := 10;
  constant V_SYNC      : integer := 2;
  constant V_BACK      : integer := 33;
  constant V_MAX       : integer := V_DISPLAY + V_FRONT + V_SYNC + V_BACK;

  signal h_count : unsigned(9 downto 0) := (others => '0');
  signal v_count : unsigned(9 downto 0) := (others => '0');

begin

  -- Contador horizontal
  process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_i = '1' then
        h_count <= (others => '0');
      elsif h_count = H_MAX - 1 then
        h_count <= (others => '0');
      else
        h_count <= h_count + 1;
      end if;
    end if;
  end process;

  -- Contador vertical
  process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_i = '1' then
        v_count <= (others => '0');
      elsif h_count = H_MAX - 1 then
        if v_count = V_MAX - 1 then
          v_count <= (others => '0');
        else
          v_count <= v_count + 1;
        end if;
      end if;
    end if;
  end process;

  -- Señales de sincronismo
  hsync_o <= '0' when (h_count >= (H_DISPLAY + H_FRONT) and h_count < (H_DISPLAY + H_FRONT + H_SYNC)) else '1';
  vsync_o <= '0' when (v_count >= (V_DISPLAY + V_FRONT) and v_count < (V_DISPLAY + V_FRONT + V_SYNC)) else '1';

  -- Zona visible
  video_on <= '1' when (h_count < H_DISPLAY and v_count < V_DISPLAY) else '0';

  -- Coordenadas actuales del píxel
  pix_x_o <= std_logic_vector(h_count);
  pix_y_o <= std_logic_vector(v_count);

end architecture;
