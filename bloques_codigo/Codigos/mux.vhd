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
    char0      : in std_logic_vector(7 downto 0);
    char1      : in std_logic_vector(7 downto 0);
    char2      : in std_logic_vector(7 downto 0);
    char3      : in std_logic_vector(7 downto 0);
    char4      : in std_logic_vector(7 downto 0);
    pixel_o    : out std_logic;
    char_sel_o : out std_logic_vector(7 downto 0);
    sub_fila_o : out std_logic_vector(2 downto 0); 
    sub_col_o  : out std_logic_vector(2 downto 0)   
  );
end entity;

architecture rtl of mux is
  -- Subdivisiones 
  signal char_sel     : std_logic_vector(7 downto 0); -- Caracter seleccionado
  signal char_addr    : std_logic_vector(3 downto 0); -- Dirección del caracter (4 bits)
  signal sub_fila     : std_logic_vector(2 downto 0); -- Y interna del caracter (bits 6-4)
  signal sub_col      : std_logic_vector(2 downto 0); -- X interna del caracter (bits 2-0)
  signal rom_pixel    : std_logic; -- Salida de la ROM de caracteres
begin

  -- Dividir las coordenadas
  char_addr <= pix_x_i(7 downto 4);
  sub_col   <= pix_x_i(2 downto 0);
  sub_fila  <= pix_y_i(6 downto 4);

  -- Salida para poder ver sub_fila y sub_col en simulación
  sub_fila_o <= sub_fila;
  sub_col_o  <= sub_col;

  -- Selector de caracter según zona horizontal
  with char_addr select
    char_sel <= char0 when "0000",
                char1 when "0001",
                char2 when "0010",
                char3 when "0011",
                char4 when "0100",
                "00000000" when others;

  -- Instancia de la ROM de caracteres
  rom_inst: entity work.rom
    port map (
      char_address => char_addr,  -- Acá va char_addr de 4 bits (no char_sel)
      sub_fila     => sub_fila,
      sub_col      => sub_col,
      rom_data     => rom_pixel
    );

  -- Salida de color blanco si hay video y el pixel está activo
  pixel_o <= rom_pixel and video_on_i;
  char_sel_o <= char_sel;

end architecture;
