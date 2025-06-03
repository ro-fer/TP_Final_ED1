-- Contador BCD
-- Estudiante: Fernandez, Rocio

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- BCD_counter.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BCD_counter is
port (
    clk_i     : in std_logic; --Clock
    rst_i     : in std_logic; -- Reset
    enable_i  : in std_logic; -- Enable
    count_o   : out std_logic_vector(3 downto 0); -- Salida BCD (0-9)
    carry_o   : out std_logic -- Señal de acarreo para el próximo dígito
);
end entity;

architecture Structural of BCD_counter is
    component flip_flop_d
    port (
        clk_i : in std_logic;
        d_i   : in std_logic;
        q_o   : out std_logic
    );
    end component;

    signal count : std_logic_vector(3 downto 0) := "0000";
    signal next_count : std_logic_vector(3 downto 0);

begin

    -- Incrementador BCD sin usar '+'
    next_count(0) <= count(0) xor (enable_i);
    next_count(1) <= count(1) xor (next_count(0) and enable_i);
    next_count(2) <= count(2) xor ((next_count(1) and next_count(0)) and enable_i);
    next_count(3) <= count(3) xor (((next_count(2) and next_count(1)) or (next_count(2) and next_count(0)) or (next_count(1) and next_count(0))) and enable_i;

    -- Registros para cada bit del contador
    registers : for i in 0 to 3 generate
        reg_bit: flip_flop_d
        port map (
            clk_i => clk_i,
            d_i   => next_count(i),
            q_o   => count(i)
        );
    end generate;

    -- Salidas
    count_o <= count;
    carry_o <= '1' when count = "1001" and enable_i = '1' else '0';

end architecture;