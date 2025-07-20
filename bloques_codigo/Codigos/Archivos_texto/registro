-- REGISTRO 4 BITS
-- Estudiante : Fernandez, Rocio

entity registro is
  port(
    clk_r : in bit;
    rst_r : in bit;
    ena_r : in bit;
    d_r   : in bit_vector(3 downto 0);
    q_r   : out bit_vector(3 downto 0)
  );
end entity;

architecture registro_arq of registro is
  component ffd is
    port(
      clk_i : in  bit;
      rst_i : in  bit;
      ena_i : in  bit;
      d_i   : in  bit;
      q_o   : out bit
    );
  end component;

  signal entrada_ffd : bit_vector(3 downto 0);
  signal salida_ffd  : bit_vector(3 downto 0);
begin
  ffd0: ffd port map(clk_i => clk_r, rst_i => rst_r, ena_i => ena_r, d_i => entrada_ffd(0), q_o => salida_ffd(0));
  ffd1: ffd port map(clk_i => clk_r, rst_i => rst_r, ena_i => ena_r, d_i => entrada_ffd(1), q_o => salida_ffd(1));
  ffd2: ffd port map(clk_i => clk_r, rst_i => rst_r, ena_i => ena_r, d_i => entrada_ffd(2), q_o => salida_ffd(2));
  ffd3: ffd port map(clk_i => clk_r, rst_i => rst_r, ena_i => ena_r, d_i => entrada_ffd(3), q_o => salida_ffd(3));

  entrada_ffd <= d_r;
  q_r <= salida_ffd;
end architecture;
