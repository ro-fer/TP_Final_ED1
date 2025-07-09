-- Testbench para el contador de unos (cOnes)

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.utils.all;

entity tb_cOnes is
end;

architecture tb of tb_cOnes is

  -- Parámetros del contador
  constant N : natural := 5; -- Cantidad de contadores BCD (5 dígitos decimales)
  constant M : natural := 4; -- Cantidad de bits por contador BCD (4 bits para valores 0-9)

  -- Señales del test
  signal clk_i  : std_logic := '0';
  signal rst_i  : std_logic := '1';
  signal ena_i  : std_logic := '0';
  signal BCD_o  : vectBCD(N-1 downto 0); -- Salida: array de BCDs

begin

  -- Instancia del DUT (Device Under Test)
  uut: entity work.cOnes
    generic map (
      N => N,
      M => M
    )
    port map (
      clk_i  => clk_i,
      rst_i  => rst_i,
      ena_i  => ena_i,
      BCD_o  => BCD_o
    );

  -- Generador de reloj (periodo 10 ns)
  clk_process: process
  begin
    clk_i <= '0';
    wait for 5 ns;
    clk_i <= '1';
    wait for 5 ns;
  end process;

  -- Estímulos
  stim_proc: process
  begin
    -- Reset inicial
    rst_i <= '1';
    ena_i <= '0';
    wait for 20 ns;

    rst_i <= '0';
    ena_i <= '1';

    -- Contamos varios unos
    for i in 0 to 120 loop
      wait for 10 ns; -- 1 ciclo de reloj
    end loop;

    -- Deshabilitar enable
    ena_i <= '0';
    wait for 40 ns;

    -- Fin
    wait;
  end process;

end architecture;
