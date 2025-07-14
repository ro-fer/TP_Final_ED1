library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_tb is
end entity;

architecture sim of mux_tb is

  -- Declaración del componente MUX
  component mux is
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
      pixel_o    : out std_logic
    );
  end component;

  -- Señales para la simulación
  signal clk_tb      : std_logic := '0';
  signal rst_tb      : std_logic := '1';
  signal pix_x_tb    : std_logic_vector(9 downto 0) := (others => '0');
  signal pix_y_tb    : std_logic_vector(9 downto 0) := (others => '0');
  signal video_on_tb : std_logic := '0';
  signal char0_tb    : std_logic_vector(7 downto 0) := "00000000";
  signal char1_tb    : std_logic_vector(7 downto 0) := "00000001";
  signal char2_tb    : std_logic_vector(7 downto 0) := "00000010";
  signal char3_tb    : std_logic_vector(7 downto 0) := "00000011";
  signal char4_tb    : std_logic_vector(7 downto 0) := "00000100";
  signal pixel_o_tb  : std_logic;

begin

  -- Instanciación del DUT
  DUT: mux
    port map (
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
      pixel_o    => pixel_o_tb
    );

  -- Clock generation: 50 MHz (20 ns period)
  clk_process: process
  begin
    while true loop
      clk_tb <= '0';
      wait for 10 ns;
      clk_tb <= '1';
      wait for 10 ns;
    end loop;
  end process;

  -- Estímulos de prueba
  stim_proc: process
  begin
    wait for 40 ns;
    rst_tb <= '0'; -- salir del reset
    video_on_tb <= '1'; -- habilitar video

    -- Barrido horizontal
    for x in 0 to 127 loop
      pix_x_tb <= std_logic_vector(to_unsigned(x, 10));
      pix_y_tb <= (others => '0');
      wait for 20 ns;
    end loop;

    -- Barrido vertical
    for y in 0 to 31 loop
      pix_x_tb <= (others => '0');
      pix_y_tb <= std_logic_vector(to_unsigned(y, 10));
      wait for 20 ns;
    end loop;

    -- Combinación aleatoria
    for i in 0 to 50 loop
      pix_x_tb <= std_logic_vector(to_unsigned(i*2, 10));
      pix_y_tb <= std_logic_vector(to_unsigned(i, 10));
      wait for 20 ns;
    end loop;

    wait;
  end process;

end architecture;
