-- Registro con 3 registros internos de 4 bits
-- Estudiante: Fernández, Rocío
library IEEE;
use IEEE.bit_1164.all;
use IEEE.numeric_std.all;

entity reg_Nb is
  port (
    clk_reg : in bit; -- Clock
    rst_reg : in bit; -- Reset
    ena_reg : in bit; -- Enable

    -- Entradas
    d1_reg : in bit_vector(3 downto 0);
    d2_reg : in bit_vector(3 downto 0);
    d3_reg : in bit_vector(3 downto 0);

    -- Salidas
    q1_reg : out bit_vector(3 downto 0);
    q2_reg : out bit_vector(3 downto 0);
    q3_reg : out bit_vector(3 downto 0)
  );
end entity;

architecture reg_Nb_arq of reg_Nb is

  component registro is
    port (
      clk_r : in bit;
      rst_r : in bit;
      ena_r : in bit;
      d_r   : in bit_vector(3 downto 0);
      q_r   : out bit_vector(3 downto 0)
    );
  end component;

begin

  reg1 : registro
    port map (
      clk_r => clk_reg,
      rst_r => rst_reg,
      ena_r => ena_reg,
      d_r   => d1_reg,
      q_r   => q1_reg
    );

  reg2 : registro
    port map (
      clk_r => clk_reg,
      rst_r => rst_reg,
      ena_r => ena_reg,
      d_r   => d2_reg,
      q_r   => q2_reg
    );

  reg3 : registro
    port map (
      clk_r => clk_reg,
      rst_r => rst_reg,
      ena_r => ena_reg,
      d_r   => d3_reg,
      q_r   => q3_reg
    );

end architecture;
