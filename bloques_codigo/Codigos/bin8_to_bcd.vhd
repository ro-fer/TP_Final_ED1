-- Convierte un número binario de 8 bits a 3 cifras BCD (centenas, decenas, unidades)
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bin8_to_bcd is
  port (
    bin_i : in  std_logic_vector(7 downto 0);
    cen_o : out std_logic_vector(3 downto 0);
    dec_o : out std_logic_vector(3 downto 0);
    uni_o : out std_logic_vector(3 downto 0)
  );
end entity;

architecture rtl of bin8_to_bcd is
begin
  process(bin_i)
    variable shift_reg : std_logic_vector(19 downto 0);
    variable i         : integer;
  begin
    shift_reg := (others => '0');
    shift_reg(7 downto 0) := bin_i;

    for i in 0 to 7 loop
      if unsigned(shift_reg(19 downto 16)) >= 5 then
        shift_reg(19 downto 16) := std_logic_vector(unsigned(shift_reg(19 downto 16)) + 3);
      end if;
      if unsigned(shift_reg(15 downto 12)) >= 5 then
        shift_reg(15 downto 12) := std_logic_vector(unsigned(shift_reg(15 downto 12)) + 3);
      end if;
      if unsigned(shift_reg(11 downto 8)) >= 5 then
        shift_reg(11 downto 8) := std_logic_vector(unsigned(shift_reg(11 downto 8)) + 3);
      end if;
      shift_reg := shift_reg(18 downto 0) & '0';
    end loop;

    cen_o <= shift_reg(19 downto 16);
    dec_o <= shift_reg(15 downto 12);
    uni_o <= shift_reg(11 downto 8);
  end process;
end architecture;
