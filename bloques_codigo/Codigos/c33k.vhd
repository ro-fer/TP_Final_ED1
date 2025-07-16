-- Contador binario
-- cuenta hasta 33K

library IEEE;
use IEEE.bit_1164.all;
use IEEE.numeric_std.all;

entity c33k is
  port (
    clk_33k   : in bit;
    rst_33k   : in bit;
    ena_33k   : in bit;
    out_1   : out  bit;  --  habilitar el registro
    out_2   : out  bit;   --  resetear el contador de unos 
    cuenta  : out  bit_vector(21 downto 0)
  );
end entity;

architecture c33k_arq of c33k is

  component cont_bin_gen is
    port (
      clk_bin_gen : in  bit;
      ena_bin_gen : in  bit;
      rst_bin_gen : in  bit;
      salida_gen  : out bit_vector(21 downto 0)
    );
  end component;

  signal salida_cont : bit_vector(21 downto 0);
  signal salida_reg  : bit;
  signal salida_q    : bit;

begin

  salida_reg <= (salida(21) and salida(20) and not salida(19) and not salida (18) and salida(17) and not salida(16) and not salida(15) and salida(14) and not salida(13) and salida(12)  and salida(11) and not salida(10) and salida(9) and not salida(8) and salida(7) and not salida(6) and not salida(5) and salida(4) and salida(3) and salida(2) and salida(1) and salida(0));

  cont33k: cont_bin_gen
      port map(
          clk_bin_gen => clk_33k,
          ena_bin_gen => ena_33k,
          rst_bin_gen => rst_cont,
          salida_gen  => salida
      );

  FFD_salida: ffd
      port map(
          clk_i => clk_33k,
          rst_i => '0',
          ena_i => ena_33k,
          d_i   => salida_reg,
          q_o   => salida_cont
      );
  -- reseteo por sistema o por fin de cuenta
  rst_cont<= rst_33k or salida_reg;
  out_1   <= salida_reg;
  out_2   <= salida_cont;
  cuenta  <= salida;

end architecture;
