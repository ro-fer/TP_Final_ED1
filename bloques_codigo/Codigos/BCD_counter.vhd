-- Contador BCD
-- Estudiante: Fernández, Rocío

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BCD_counter is
  generic(N: natural := 4);
  port(
    clk_bcd  : in  bit;
    rst_bcd  : in  bit;
    ena_bcd  : in  bit;
    q_bcd    : out bit_vector(N-1 downto 0);
    max      : out bit
  );
end entity;

architecture BCD_counter_arq of BCD_counter is
  component ffd is
    port(
      clk_i : in  bit;
      rst_i : in  bit;
      ena_i : in  bit;
      d_i   : in  bit;
      q_o   : out bit
    );
  end component;

  signal q_o : bit_vector(3 downto 0);
  signal d_i : bit_vector(3 downto 0);

begin

  -- Instancias del FFD
  FF0: ffd 
    port map (
      clk_i => clk_bcd,
      rst_i => rst_bcd,
      ena_i => ena_bcd,
      d_i   => d_i(0),
      q_o   => q_o(0) 
    );

  FF1: ffd 
    port map (
      clk_i => clk_bcd,
      rst_i => rst_bcd,
      ena_i => ena_bcd,
      d_i   => d_i(1),
      q_o   => q_o(1) 
    );

  FF2: ffd 
    port map (
      clk_i => clk_bcd,
      rst_i => rst_bcd,
      ena_i => ena_bcd,
      d_i   => d_i(2),
      q_o   => q_o(2) 
    );

  FF3: ffd 
    port map (
      clk_i => clk_bcd,
      rst_i => rst_bcd,
      ena_i => ena_bcd,
      d_i   => d_i(3),
      q_o   => q_o(3) 
    );

  -- Lógica del contador BCD (mod 10)
  d_i(0) <= not q_o(0);
  d_i(1) <= (not q_o(0) and q_o(1)) or (q_o(0) and not q_o(1) and not q_o(3));
  d_i(2) <= (not q_o(1) and q_o(2)) or (q_o(0) and q_o(1) and not q_o(2)) or (not q_o(0) and q_o(1) and q_o(2));
  d_i(3) <= (q_o(0) and q_o(1) and q_o(2)) or (not q_o(0) and not q_o(2) and q_o(3));

  -- Asignaciones de salida
  q_bcd <= q_o;

  -- Señal de máximo (cuando llega a 9 = "1001")
  max <= '1' when q_o = "1001" else '0';

end architecture;
