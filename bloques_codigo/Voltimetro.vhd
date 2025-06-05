-- VOLTIMETRO
-- Estudiante: Fernández, Rocío

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Voltimetro is
  port (
    clk_i           : in bit;
    rst_i           : in bit;
    data_volt_in_i  : in bit;
    data_volt_out_o : out bit;
    hs_o            : out bit;
    vs_o            : out bit;
    red_o           : out bit;
    grn_o           : out bit;
    blu_o           : out bit
  );
end entity;

architecture rtl of Voltimetro is

  ------------------------------------------------------------------------------
  -- Señales internas
  ------------------------------------------------------------------------------
  signal clk      : std_logic := '0';
  signal rst      : std_logic := '0';
  signal adc_i    : std_logic := '0';
  signal adc_out  : std_logic := '0';

  signal ones     : std_logic_vector(7 downto 0);
  signal rst_ones : std_logic;
  signal ena_ones : std_logic;

  signal cen_bcd, dec_bcd, uni_bcd : std_logic_vector(3 downto 0);
  signal char0, char1, char2, char3, char4 : std_logic_vector(6 downto 0);

  signal ascii_48 : std_logic_vector(3 downto 0) := "00110000";

  signal ascii_cen, ascii_dec, ascii_uni : std_logic_vector(6 downto 0);

  signal pix_x, pix_y : std_logic_vector(9 downto 0);
  signal video_on     : std_logic;
  signal pixel_color  : std_logic;

begin

  ------------------------------------------------------------------------------
  -- Conversión de tipos (bit -> std_logic)
  ------------------------------------------------------------------------------
  clk   <= std_logic(clk_i);
  rst   <= std_logic(rst_i);
  adc_i <= std_logic(data_volt_in_i);

  ------------------------------------------------------------------------------
  -- ADC_SD → salida directa (buffer opcional)
  ------------------------------------------------------------------------------
  adc_out <= adc_i;
  data_volt_out_o <= bit(adc_out);

  ------------------------------------------------------------------------------
  -- cOnes: cuenta los '1' del ADC en ventana
  ------------------------------------------------------------------------------
  contador_1s : entity work.cOnes
    generic map(N => 8)
    port map(
      clk_i  => clk,
      rst_i  => rst_ones,
      ena_i  => ena_ones,
      adc_i  => adc_out,
      ones_o => ones
    );

  ------------------------------------------------------------------------------
  -- c33k: genera ventana de muestreo
  ------------------------------------------------------------------------------
  ventana : entity work.c33k
    port map(
      clk_i  => clk,
      rst_i  => rst,
      ena_o  => ena_ones,
      rst_o  => rst_ones
    );

  ------------------------------------------------------------------------------
  -- binario → BCD
  ------------------------------------------------------------------------------
  bin_to_bcd : entity work.bin8_to_bcd
    port map(
      bin_i => ones,
      cen_o => cen_bcd,
      dec_o => dec_bcd,
      uni_o => uni_bcd
    );

  ------------------------------------------------------------------------------
  -- BCD → ASCII ('0' + cifra BCD) usando sum_Nb estructurales
  ------------------------------------------------------------------------------
  ascii_cen : entity work.sum_Nb
    generic map(N => 4)
    port map(
      a_i => cen_bcd,
      b_i => ascii_48,
      c_i => '0',
      s_o => char0,
      c_o => open
    );

  ascii_dec : entity work.sum_Nb
    generic map(N => 4)
    port map(
      a_i => dec_bcd,
      b_i => ascii_48,
      c_i => '0',
      s_o => char2,
      c_o => open
    );

  ascii_uni : entity work.sum_Nb
    generic map(N => 4)
    port map(
      a_i => uni_bcd,
      b_i => ascii_48,
      c_i => '0',
      s_o => char3,
      c_o => open
    );

  -- '.' y 'V'
  char1 <= "0101110"; -- '.'
  char4 <= "1010110"; -- 'V'

  ------------------------------------------------------------------------------
  -- VGA Controller
  ------------------------------------------------------------------------------
  vga_ctrl : entity work.vga_controller
    port map(
      clk_i     => clk,
      rst_i     => rst,
      hsync_o   => hs_o,
      vsync_o   => vs_o,
      video_on  => video_on,
      pix_x_o   => pix_x,
      pix_y_o   => pix_y
    );

  ------------------------------------------------------------------------------
  -- Display de los 5 caracteres ("X.XXV")
  ------------------------------------------------------------------------------
  disp : entity work.display
    port map(
      clk_i      => clk,
      rst_i      => rst,
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

  ------------------------------------------------------------------------------
  -- Salida VGA monocromática (solo rojo activo si pixel = 1)
  ------------------------------------------------------------------------------
  red_o <= bit(pixel_color);
  grn_o <= '0';
  blu_o <= '0';

end architecture;
