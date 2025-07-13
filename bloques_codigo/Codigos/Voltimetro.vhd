-- Voltímetro VGA Intermedio
-- Estudiante: Fernández, Rocío

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.utils.all;

entity Voltimetro is
  port (
    clk_i           : in std_logic;
    rst_i           : in std_logic;
    data_volt_in_i  : in std_logic;
    data_volt_out_o : out std_logic;
    hs_o            : out std_logic;
    vs_o            : out std_logic;
    red_o           : out std_logic;
    grn_o           : out std_logic;
    blu_o           : out std_logic
  );
end entity;

architecture rtl of Voltimetro is

  -- Señales internas
  signal adc_out  : std_logic;
  signal rst_ones : std_logic;
  signal ena_ones : std_logic;

  signal ones     : vectBCD(2 downto 0);  -- Centena, Decena, Unidad
  signal cen_bcd  : std_logic_vector(3 downto 0);
  signal dec_bcd  : std_logic_vector(3 downto 0);
  signal uni_bcd  : std_logic_vector(3 downto 0);

  signal char0, char1, char2, char3, char4 : std_logic_vector(6 downto 0);
  constant ascii_48 : std_logic_vector(3 downto 0) := "0011"; -- valor binario de 48 decimal → '0'

  signal pix_x, pix_y : std_logic_vector(9 downto 0);
  signal video_on     : std_logic;
  signal pixel_color  : std_logic;

begin

  --------------------------------------------------------------------------
  -- ADC_SD → paso directo (puede tener un registro si querés suavizado)
  --------------------------------------------------------------------------
  adc_out <= data_volt_in_i;
  data_volt_out_o <= adc_out;

  --------------------------------------------------------------------------
  -- Contador de unos en la ventana de muestreo (ventana de ~33k ciclos)
  --------------------------------------------------------------------------
  contador_1s : entity work.cOnes
    generic map(N => 3)  -- 3 dígitos: centenas, decenas, unidades
    port map(
      clk_i => clk_i,
      rst_i => rst_ones,
      ena_i => adc_out,
      BCD_o => ones
    );

  ventana : entity work.c33k
  port map(
    clk_i   => clk_i,
    rst_i   => rst_i,
    ena_i   => '1',
    Q_BCD   => rst_ones,
    Q_reg   => ena_ones,
    cuenta  => open
  );

  --------------------------------------------------------------------------
  -- Desempaquetado del vector BCD para pasarlo a ASCII
  --------------------------------------------------------------------------
  cen_bcd <= ones(2);
  dec_bcd <= ones(1);
  uni_bcd <= ones(0);

  --------------------------------------------------------------------------
  -- BCD → ASCII ('0' + valor)
  --------------------------------------------------------------------------
  ascii_cen_sum : entity work.sum_Nb
    generic map(N => 4)
    port map(
      a_i => cen_bcd,
      b_i => ascii_48,
      c_i => '0',
      s_o => char0,
      c_o => open
    );

  ascii_dec_sum : entity work.sum_Nb
    generic map(N => 4)
    port map(
      a_i => dec_bcd,
      b_i => ascii_48,
      c_i => '0',
      s_o => char2,
      c_o => open
    );

  ascii_uni_sum : entity work.sum_Nb
    generic map(N => 4)
    port map(
      a_i => uni_bcd,
      b_i => ascii_48,
      c_i => '0',
      s_o => char3,
      c_o => open
    );

  -- Puntos fijos
  char1 <= "0101110"; -- '.' (punto decimal)
  char4 <= "1010110"; -- 'V'

  --------------------------------------------------------------------------
  -- VGA Controller
  --------------------------------------------------------------------------
  vga_ctrl : entity work.vga_controller
    port map(
      clk_i     => clk_i,
      rst_i     => rst_i,
      hsync_o   => hs_o,
      vsync_o   => vs_o,
      video_on  => video_on,
      pix_x_o   => pix_x,
      pix_y_o   => pix_y
    );

  --------------------------------------------------------------------------
  -- Display de los caracteres en pantalla
  --------------------------------------------------------------------------
  disp : entity work.bin8_to_bcd
    port map(
      clk_i      => clk_i,
      rst_i      => rst_i,
      pix_x_i    => pix_x,
      pix_y_i    => pix_y,
      video_on_i => video_on,
      char0      => char0,
      char1      => char1,
      char2      => char2,
      char3      => char3,
      char4      => char4,
      pixel_o    => pixel_color
    );

  --------------------------------------------------------------------------
  -- Salida VGA monocromática (solo rojo)
  --------------------------------------------------------------------------
  red_o <= pixel_color;
  grn_o <= '0';
  blu_o <= '0';

end architecture;
