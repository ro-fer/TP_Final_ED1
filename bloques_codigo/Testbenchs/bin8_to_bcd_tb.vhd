library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bin8_to_bcd_tb is
end entity;

architecture sim of bin8_to_bcd_tb is

    component bin8_to_bcd is
        port (
            bin_i   : in  std_logic_vector(7 downto 0);
            cen_o   : out std_logic_vector(3 downto 0);
            dec_o   : out std_logic_vector(3 downto 0);
            uni_o   : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Señales internas
    signal bin_i_tb  : std_logic_vector(7 downto 0);
    signal cen_o_tb  : std_logic_vector(3 downto 0);
    signal dec_o_tb  : std_logic_vector(3 downto 0);
    signal uni_o_tb  : std_logic_vector(3 downto 0);

begin

    -- Instanciación del DUT
    DUT: bin8_to_bcd
        port map (
            bin_i  => bin_i_tb,
            cen_o  => cen_o_tb,
            dec_o  => dec_o_tb,
            uni_o  => uni_o_tb
        );

    -- Proceso de estímulos
    stim_proc: process
    begin
        -- Test 0
        bin_i_tb <= "00000000";  -- 0
        wait for 20 ns;

        -- Test 1
        bin_i_tb <= "00000001";  -- 1
        wait for 20 ns;

        -- Test 9
        bin_i_tb <= "00001001";  -- 9
        wait for 20 ns;

        -- Test 10
        bin_i_tb <= "00001010";  -- 10
        wait for 20 ns;

        -- Test 99
        bin_i_tb <= "01100011";  -- 99
        wait for 20 ns;

        -- Test 255
        bin_i_tb <= "11111111";  -- 255
        wait for 20 ns;

        wait; -- finalizar simulación
    end process;

end architecture;
