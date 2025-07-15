-- Contador BCD
-- Estudiante: Fernández, Rocío

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity BCD_counter is
  generic(
    N: natural := 4 -- Nro bits
    );
  port(
    clk_i: in std_logic; -- clock 
    rst_i: in std_logic; -- Reset 
    ena_i: in std_logic; -- Enable 
    q_bcd: out std_logic_vector(N-1 downto 0); -- Valor actual del contador

  );
end;
architecture BCD_counter_arq of BCD_counter is
  component ffd is 
    port(
        clk_i   : in std_logic;
        rst_i   : in std_logic;
        ena_i   : in std_logic;
        d_i     : in std_logic;
        q_o     : out std_logic
    );
    end component;
  -- ent y sal de ffd
  signal d_i  : bit_vector(3 downto 0) := "0000";
  signal q_o  : bit_vector(3 downto 0) := "0000";

begin
  FF0: ffd 
      port map (
      clk_i   => clk_bcd,
      rst_i   => rst_bcd,
      ena_i   => ena_bcd,
      d_i     => d_i(0),
      q_o     => q_o(0) 
  );

  FF1: ffd 
      port map (
      clk_i   => clk_bcd,
      rst_i   => rst_bcd,
      ena_i   => ena_bcd,
      d_i     => d_i(1),
      q_o     => q_o(1) 
  );

  FF2: ffd 
      port map (
      clk_i   => clk_bcd,
      rst_i   => rst_bcd,
      ena_i   => ena_bcd,
      d_i     => d_i(2),
      q_o     => q_o(2) 
  );

  FF3: ffd 
      port map (
      clk_i   => clk_bcd,
      rst_i   => rst_bcd,
      ena_i   => ena_bcd,
      d_i     => d_i(3),
      q_o     => q_o(3) 
  );

  d_i(0) <= not q_o(0);
  d_i(1) <= (not q_o(0) and q_o(1)) or (q_o(0) and not q_o(1) and not q_o(3));
  d_i(2) <= (not q_o(1) and q_o(2)) or (q_o(0) and q_o(1) and not q_o(2)) or (not q_o(0) and q_o(1) and q_o(2));
  d_i(3) <= (q_o(0) and q_o(1) and q_o(2)) or (not q_o(0) and not q_o(2) and q_o(3));

  q_bcd <= q_o;
  

end architecture;
