library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cont_bin is
    generic (
        N : natural := 2
    );
    port (
        clk_i : in bit;
        rst_i : in bit;
        ena_i : in bit;
        q_o   : out bit_vector(N-1 downto 0)
    );
end entity;

architecture rtl of cont_bin is
    signal count : unsigned(N-1 downto 0) := (others => '0');
begin

    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' then
                count <= (others => '0');
            elsif ena_i = '1' then
                count <= count + 1;
            end if;
        end if;
    end process;

    q_o <= bit_vector(count);

end architecture;
