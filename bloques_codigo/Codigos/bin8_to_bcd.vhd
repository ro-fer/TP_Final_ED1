library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bin8_to_bcd is
  port (
    bin_i   : in  std_logic_vector(7 downto 0);  -- Entrada binaria (0–255)
    cen_o   : out std_logic_vector(3 downto 0);  -- Centenas BCD
    dec_o   : out std_logic_vector(3 downto 0);  -- Decenas BCD
    uni_o   : out std_logic_vector(3 downto 0)   -- Unidades BCD
  );
end entity;

architecture rtl of bin8_to_bcd is
begin
  process(bin_i)
    variable shift_reg : std_logic_vector(19 downto 0); -- 12 bits BCD + 8 bits binario
    variable i         : integer;
  begin
    -- Inicializar el shift register
    shift_reg := (others => '0');
    shift_reg(7 downto 0) := bin_i;  -- Poner el binario en los 8 bits menos significativos

    -- 8 ciclos (uno por cada bit de bin_i)
    for i in 0 to 7 loop
      -- Corregir centenas
      if unsigned(shift_reg(19 downto 16)) >= 5 then
        shift_reg(19 downto 16) := std_logic_vector(unsigned(shift_reg(19 downto 16)) + 3);
      end if;

      -- Corregir decenas
      if unsigned(shift_reg(15 downto 12)) >= 5 then
        shift_reg(15 downto 12) := std_logic_vector(unsigned(shift_reg(15 downto 12)) + 3);
      end if;

      -- Corregir unidades
      if unsigned(shift_reg(11 downto 8)) >= 5 then
        shift_reg(11 downto 8) := std_logic_vector(unsigned(shift_reg(11 downto 8)) + 3);
      end if;

      -- Shift a la izquierda
      shift_reg := shift_reg(18 downto 0) & '0';
    end loop;

    -- Asignar salidas
    cen_o <= shift_reg(19 downto 16);
    dec_o <= shift_reg(15 downto 12);
    uni_o <= shift_reg(11 downto 8);
  end process;
end architecture;
