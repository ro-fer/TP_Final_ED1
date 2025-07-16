-- CONTADOR BINARIO DE 16 bits


entity cont_bin_gen is
  port (
    clk_bin_gen : in bit;
    ena_bin_gen : in bit;
    rst_bin_gen : in bit;
    salida_gen  : out bit_vector(N-1 downto 0)
  );
end entity;

architecture cont_bin_gen_arq of cont_bin_gen is

  component ffd is
    port (
      clk_i   : in  bit;
      rst_i   : in  bit;
      ena_i   : in  bit;
      d_i     : in  bit;
      q_o     : out bit
    );
  end component;

  signal salida : bit_vector(N-1 downto 0);
  signal ands   : bit_vector(N-1 downto 0);
  signal xors   : bit_vector(N-1 downto 0);

begin

  -- Primera etapa
  ands(0) <= ena_bin_gen;
  xors(0) <= ands(0) xor salida(0);

  ffd0: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(0), salida(0));

  -- Segunda etapa
  ands(1) <= ands(0) and salida(0);
  xors(1) <= ands(1) xor salida(1);
  ffd1: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(1), salida(1));

  -- Tercera etapa
  ands(2) <= ands(1) and salida(1);
  xors(2) <= ands(2) xor salida(2);
  ffd2: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(2), salida(2));

  -- Etapas restantes manualmente hasta 21...
  ands(3) <= ands(2) and salida(2);
  xors(3) <= ands(3) xor salida(3);
  ffd3: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(3), salida(3));

  ands(4) <= ands(3) and salida(3);
  xors(4) <= ands(4) xor salida(4);
  ffd4: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(4), salida(4));

  ands(5) <= ands(4) and salida(4);
  xors(5) <= ands(5) xor salida(5);
  ffd5: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(5), salida(5));

  ands(6) <= ands(5) and salida(5);
  xors(6) <= ands(6) xor salida(6);
  ffd6: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(6), salida(6));

  ands(7) <= ands(6) and salida(6);
  xors(7) <= ands(7) xor salida(7);
  ffd7: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(7), salida(7));

  ands(8) <= ands(7) and salida(7);
  xors(8) <= ands(8) xor salida(8);
  ffd8: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(8), salida(8));

  ands(9) <= ands(8) and salida(8);
  xors(9) <= ands(9) xor salida(9);
  ffd9: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(9), salida(9));

  ands(10) <= ands(9) and salida(9);
  xors(10) <= ands(10) xor salida(10);
  ffd10: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(10), salida(10));

  ands(11) <= ands(10) and salida(10);
  xors(11) <= ands(11) xor salida(11);
  ffd11: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(11), salida(11));

  ands(12) <= ands(11) and salida(11);
  xors(12) <= ands(12) xor salida(12);
  ffd12: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(12), salida(12));

  ands(13) <= ands(12) and salida(12);
  xors(13) <= ands(13) xor salida(13);
  ffd13: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(13), salida(13));

  ands(14) <= ands(13) and salida(13);
  xors(14) <= ands(14) xor salida(14);
  ffd14: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(14), salida(14));

  ands(15) <= ands(14) and salida(14);
  xors(15) <= ands(15) xor salida(15);
  ffd15: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(15), salida(15));
  -- en un momento hice de 22 chequear
  -- ands(16) <= ands(15) and salida(15);
  -- xors(16) <= ands(16) xor salida(16);
  -- ffd16: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(16), salida(16));
-- 
  -- ands(17) <= ands(16) and salida(16);
  -- xors(17) <= ands(17) xor salida(17);
  -- ffd17: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(17), salida(17));
-- 
  -- ands(18) <= ands(17) and salida(17);
  -- xors(18) <= ands(18) xor salida(18);
  -- ffd18: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(18), salida(18));
-- 
  -- ands(19) <= ands(18) and salida(18);
  -- xors(19) <= ands(19) xor salida(19);
  -- ffd19: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(19), salida(19));
-- 
  -- ands(20) <= ands(19) and salida(19);
  -- xors(20) <= ands(20) xor salida(20);
  -- ffd20: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(20), salida(20));
-- 
  -- ands(21) <= ands(20) and salida(20);
  -- xors(21) <= ands(21) xor salida(21);
  -- ffd21: ffd port map(clk_bin_gen, rst_bin_gen, '1', xors(21), salida(21));

  salida_gen <= salida;

end architecture;
