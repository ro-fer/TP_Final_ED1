library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_tb is
end entity;

architecture sim of mux_tb is

  component mux is
    port (
      clk_i    : in std_logic;
      rst_i    : in std_logic;
      pix_x_i  : in std_logic_vector(9 downto 0);
      pix_y_i  : in std_logic_vector(9 downto 0);
      rom_pixel: out std_logic
    );
  end component;

  signal clk_tb    : std_logic := '0';
  signal rst_tb    : std_logic := '1';
  signal pix_x_tb  : std_logic_vector(9 downto 0) := (others => '0');
  signal pix_y_tb  : std_logic_vector(9 downto 0) := (others => '0');
  signal rom_pixel_tb : std_logic;

begin

  DUT: mux
    port map (
      clk_i    => clk_tb,
      rst_i    => rst_tb,
      pix_x_i  => pix_x_tb,
      pix_y_i  => pix_y_tb,
      rom_pixel=> rom_pixel_tb
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

  stim_proc: process
  begin
    wait for 40 ns;
    rst_tb <= '0'; -- quitar reset

    -- Barrido horizontal de pix_x para una fila fija de pix_y
    for x in 0 to 127 loop
      pix_x_tb <= std_logic_vector(to_unsigned(x, 10));
      pix_y_tb <= (others => '0');  -- fila 0
      wait for 20 ns;
    end loop;

    -- Barrido vertical de pix_y para un pix_x fijo
    for y in 0 to 31 loop
      pix_x_tb <= (others => '0');  -- columna 0
      pix_y_tb <= std_logic_vector(to_unsigned(y, 10));
      wait for 20 ns;
    end loop;

    -- Barrido combinado aleatorio de pix_x y pix_y (ejemplo)
    for i in 0 to 50 loop
      pix_x_tb <= std_logic_vector(to_unsigned(i*2, 10));
      pix_y_tb <= std_logic_vector(to_unsigned(i, 10));
      wait for 20 ns;
    end loop;

    wait;
  end process;

end architecture;
