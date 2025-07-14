library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity display_ascii is
  port (
    clk_i      : in std_logic;
    rst_i      : in std_logic;
    pix_x_i    : in std_logic_vector(9 downto 0);
    pix_y_i    : in std_logic_vector(9 downto 0);
    video_on_i : in std_logic;
    char0      : in std_logic_vector(7 downto 0);
    char1      : in std_logic_vector(7 downto 0);
    char2      : in std_logic_vector(7 downto 0);
    char3      : in std_logic_vector(7 downto 0);
    char4      : in std_logic_vector(7 downto 0);
    pixel_o    : out std_logic_vector(2 downto 0)
  );
end;

architecture rtl of display_ascii is
  -- Este bloque necesita usar una ROM de caracteres ASCII (como font_rom.vhd)
  -- Aquí solo se asigna un color fijo cuando hay video_on y zona de caracteres
begin
  process(clk_i)
  begin
    if rising_edge(clk_i) then
      if video_on_i = '1' then
        pixel_o <= "111"; -- Blanco (ejemplo RGB 3 bits)
      else
        pixel_o <= "000"; -- Negro
      end if;
    end if;
  end process;
end architecture;