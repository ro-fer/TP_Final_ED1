-- mux.vhd
-- Estudiante: Fern�ndez, Roc�o

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux is
  port (
    clk_i      : in std_logic;
    rst_i      : in std_logic;
    pix_x_i    : in std_logic_vector(9 downto 0);
    pix_y_i    : in std_logic_vector(9 downto 0);
    video_on_i : in std_logic;
    char0      : in std_logic_vector(6 downto 0);
    char1      : in std_logic_vector(6 downto 0);
    char2      : in std_logic_vector(6 downto 0);
    char3      : in std_logic_vector(6 downto 0);
    char4      : in std_logic_vector(6 downto 0);
    pixel_o    : out std_logic
  );
end entity;

architecture rtl of mux is
  -- Subdivisiones 
  signal char_sel     : std_logic_vector(6 downto 0); -- Caracter seleccionado
  signal char_addr    : std_logic_vector(3 downto 0); -- 5 caracteres ? 0 a 4
  signal sub_fila     : std_logic_vector(2 downto 0); -- Y interna del caracter (bits 6-4)
  signal sub_col      : std_logic_vector(2 downto 0); -- X interna del caracter (bits 2-0)
  signal rom_pixel    : std_logic; -- Salida de la ROM de caracteres
begin

  -- Dividir las coordenadas
  char_addr <= pix_x_i(7 downto 4);
  sub_col   <= pix_x_i(2 downto 0);
  sub_fila  <= pix_y_i(6 downto 4);

  -- Selector de caracter seg�n zona horizontal
  with char_addr select
    char_sel <= char0 when "0000",
                char1 when "0001",
                char2 when "0010",
                char3 when "0011",
                char4 when "0100",
                "0000000" when others;

  -- Instancia de la ROM de caracteres
  rom_inst: entity work.rom
    port map (
      char_address => char_addr,
      sub_fila     => sub_fila,
      sub_col      => sub_col,
      rom_data     => rom_pixel
    );

  -- Salida de color blanco si hay video y el pixel est� activo
  pixel_o <= rom_pixel and video_on_i;

end architecture;
