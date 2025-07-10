library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity carac_rom_tb is
end;

architecture test of carac_rom_tb is

    -- Declaración del componente
    component rom
        generic (
            A : integer := 4;
            F : integer := 3;
            C : integer := 3
        );
        port (
            char_address : in std_logic_vector (A-1 downto 0);
            sub_fila     : in std_logic_vector (F-1 downto 0);
            sub_col      : in std_logic_vector (C-1 downto 0);
            rom_data     : out std_logic
        );
    end component;

    -- Señales del testbench
    signal char_address_tb : std_logic_vector(3 downto 0);
    signal sub_fila_tb     : std_logic_vector(2 downto 0);
    signal sub_col_tb      : std_logic_vector(2 downto 0);
    signal rom_data_tb     : std_logic;

begin

    -- Instancia del DUT
    DUT: rom
        port map (
            char_address => char_address_tb,
            sub_fila     => sub_fila_tb,
            sub_col      => sub_col_tb,
            rom_data     => rom_data_tb
        );

    -- Proceso de estímulos
    stim_proc : process
    begin
        -- Caracter '0' → address = 0
        char_address_tb <= "0000";

        for fila in 0 to 7 loop
            sub_fila_tb <= std_logic_vector(to_unsigned(fila, 3));

            for col in 0 to 7 loop
                sub_col_tb <= std_logic_vector(to_unsigned(col, 3));
                wait for 10 ns;
            end loop;
        end loop;

        -- Probar el punto '.' → address = 10
        char_address_tb <= "1010";

        for fila in 0 to 7 loop
            sub_fila_tb <= std_logic_vector(to_unsigned(fila, 3));

            for col in 0 to 7 loop
                sub_col_tb <= std_logic_vector(to_unsigned(col, 3));
                wait for 10 ns;
            end loop;
        end loop;

        wait;
    end process;

end architecture;
