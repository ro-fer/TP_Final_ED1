library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_tb is
end entity;

architecture sim of mux_tb is

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
      pixel_o    : out std_logic;
      char_sel_o : out std_logic_vector(7 downto 0);
      sub_fila_o : out std_logic_vector(2 downto 0); 
      sub_col_o  : out std_logic_vector(2 downto 0)  
    );
  end component;

  -- Señales internas
  signal clk_tb       : std_logic := '0';
  signal rst_tb       : std_logic := '1';
  signal pix_x_tb     : std_logic_vector(9 downto 0) := (others => '0');
  signal pix_y_tb     : std_logic_vector(9 downto 0) := (others => '0');
  signal video_on_tb  : std_logic := '0';
  signal char0_tb     : std_logic_vector(7 downto 0) := (others => '0');
  signal char1_tb     : std_logic_vector(7 downto 0) := (others => '0');
  signal char2_tb     : std_logic_vector(7 downto 0) := "00110010"; -- '2'
  signal char3_tb     : std_logic_vector(7 downto 0) := (others => '0');
  signal char4_tb     : std_logic_vector(7 downto 0) := (others => '0');
  signal pixel_o_tb   : std_logic;
  signal char_sel_tb  : std_logic_vector(7 downto 0);
  signal sub_fila_tb  : std_logic_vector(2 downto 0);
  signal sub_col_tb   : std_logic_vector(2 downto 0);

begin

  -- Instancia del DUT
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
      pixel_o    => pixel_o_tb,
      char_sel_o => char_sel_tb,
      sub_fila_o => sub_fila_tb, 
      sub_col_o  => sub_col_tb   
    );

  -- Clock 50 MHz
  clk_process: process
  begin
    while true loop
      clk_tb <= '0';
      wait for 10 ns;
      clk_tb <= '1';
      wait for 10 ns;
    end loop;
  end process;

  -- Estímulo: recorrer las 8 filas x 8 columnas del caracter 2
  stim_proc: process
  begin
    wait for 40 ns;
    rst_tb <= '0';
    video_on_tb <= '1';

    for fila in 0 to 7 loop
      pix_y_tb <= std_logic_vector(to_unsigned(fila * 16, 10));  -- subfila en bits 6-4
      for col in 0 to 7 loop
        pix_x_tb <= std_logic_vector(to_unsigned(32 + col, 10)); -- char2 en posición horizontal 2
        wait for 20 ns;
      end loop;
    end loop;

    wait;
  end process;

end architecture;
