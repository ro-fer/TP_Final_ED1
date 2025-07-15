-- Testbench para reg_Nb

library IEEE;
use IEEE.std_logic_1164.all;

entity reg_Nb_tb is
end reg_Nb_tb;

architecture tb of reg_Nb_tb is
  signal clk     : std_logic := '0';
  signal rst     : std_logic := '0';
  signal ena     : std_logic := '0';

  signal d1      : std_logic_vector(3 downto 0);
  signal d2      : std_logic_vector(3 downto 0);
  signal d3      : std_logic_vector(3 downto 0);

  signal q1      : std_logic_vector(3 downto 0);
  signal q2      : std_logic_vector(3 downto 0);
  signal q3      : std_logic_vector(3 downto 0);
begin

  -- Instancia del registro
  uut: entity work.reg_Nb
    port map (
      clk_reg => clk,
      rst_reg => rst,
      ena_reg => ena,
      d1_reg => d1,
      d2_reg => d2,
      d3_reg => d3,
      q1_reg => q1,
      q2_reg => q2,
      q3_reg => q3
    );

  -- Generación de reloj
  clk <= not clk after 5 ns;

  -- Estímulos
  process
  begin
    -- Reset activo
    rst <= '1';
    ena <= '0';
    d1 <= "0000"; d2 <= "0000"; d3 <= "0000";
    wait for 20 ns;

    -- Fin de reset
    rst <= '0';
    d1 <= "0001"; d2 <= "0010"; d3 <= "0011";
    wait for 10 ns;

    -- Enable activo
    ena <= '1';
    wait for 10 ns;

    -- Cambian los datos
    d1 <= "1001"; d2 <= "1010"; d3 <= "1011";
    wait for 10 ns;

    d1 <= "1100"; d2 <= "1101"; d3 <= "1110";
    wait for 10 ns;

    -- Desactivar enable
    ena <= '0';
    d1 <= "0000"; d2 <= "0000"; d3 <= "0000";
    wait;

  end process;
end architecture;
