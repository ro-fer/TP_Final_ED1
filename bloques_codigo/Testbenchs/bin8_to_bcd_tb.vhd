-- Testbench para bin8_to_bcd

library IEEE;
use IEEE.std_logic_1164.all;

entity bin8_to_bcd_tb is
end;

architecture tb of bin8_to_bcd_tb is

  -- Componente a testear
  component bin8_to_bcd is
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
  end component;

  -- Señales de prueba
  signal clk_tb      : std_logic := '0';
  signal rst_tb      : std_logic := '0';
  signal pix_x_tb    : std_logic_vector(9 downto 0) := (others => '0');
  signal pix_y_tb    : std_logic_vector(9 downto 0) := (others => '0');
  signal video_on_tb : std_logic := '0';
  signal char0_tb    : std_logic_vector(7 downto 0) := x"30";  -- '0'
  signal char1_tb    : std_logic_vector(7 downto 0) := x"31";  -- '1'
  signal char2_tb    : std_logic_vector(7 downto 0) := x"32";  -- '2'
  signal char3_tb    : std_logic_vector(7 downto 0) := x"33";  -- '3'
  signal char4_tb    : std_logic_vector(7 downto 0) := x"34";  -- '4'
  signal pixel_tb    : std_logic_vector(2 downto 0);

begin

  -- Instancia del DUT
  DUT: bin8_to_bcd
    port map(
      clk_i      => clk_tb,
      rst_i      => rst_tb,
      pix_x_i    => pix_x_tb,
      pix_y_i    => pix_y_tb,
      video_on_i => video_on_tb,
      char0      => char0_tb,
      char1      => char1_tb,
      char2      => char2_tb,
      char3      => char3_tb,
      char4      => char4_tb,
      pixel_o    => pixel_tb
    );

  -- Reloj
  clk_process: process
  begin
    clk_tb <= '0';
    wait for 10 ns;
    clk_tb <= '1';
    wait for 10 ns;
  end process;

  -- Estímulos
  stim_proc: process
  begin
    rst_tb <= '1';
    wait for 20 ns;
    rst_tb <= '0';

    video_on_tb <= '1';

    -- Cambiar coordenadas para simular diferentes píxeles
    pix_x_tb <= "0000000100"; -- 4
    pix_y_tb <= "0000000101"; -- 5
    wait for 40 ns;

    pix_x_tb <= "0000001000"; -- 8
    pix_y_tb <= "0000001010"; -- 10
    wait for 40 ns;

    -- Fin de simulación
    wait;
  end process;

end architecture;
