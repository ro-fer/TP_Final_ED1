-- Conversor Analógico Digital Sigma-Delta
-- Estudiante: Fernandez, Rocio



entity ADC_SD is
  port(
    clk_i: in   bit;  -- Clock
    rst_i: in   bit;  -- Reset
    ena_i: in   bit;  -- Enable
    D_vi: in    bit;   -- Entrada
    Q_fb: out   bit;  -- Realimentacion
    Q_proc: out bit -- Procesamiento
  );
end;

architecture ADC_SD_arq of ADC_SD is
component ffd -- llamo al codigo de Flip Flop D
  port(
    clk_i: in bit; -- Clock
    rst_i: in bit; -- Reset
    ena_i: in bit; -- Enable
    D_i: in   bit; -- Dato
    Q_o: out  bit -- Salida
  );
end component;

signal Q_aux: bit; -- Auxiliar para Q

begin
  ffd0: ffd
    port map(
      clk_i =>  clk_i,
      rst_i =>  rst_i,
      ena_i =>  ena_i,
      D_i   =>  D_vi,
      Q_o   =>  Q_aux
    );
  Q_fb <= not Q_aux;
  Q_proc <= Q_aux;
end;