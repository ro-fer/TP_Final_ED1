-- Contador de Unos 
-- Estudiante: Fernández, Rocío

library IEEE;
use IEEE.std_logic_1164.all;
use work.utils.all;

entity cOnes is
  port(
    clk_unos :   in std_logic;
    rst_unos :   in std_logic;
    ena_unos :   in std_logic;
    q_bcd1   :   out std_logic_vector(3 downto 0);
    q_bcd2   :   out std_logic_vector(3 downto 0);
    q_bcd3   :   out std_logic_vector(3 downto 0);
    q_bcd4   :   out std_logic_vector(3 downto 0);
    q_bcd5   :   out std_logic_vector(3 downto 0);
    q_bcd6   :   out std_logic_vector(3 downto 0);
    q_bcd7   :   out std_logic_vector(3 downto 0)
  );
end;

architecture cOnes_arq of cOnes is
  -- BCD
  component BCD_counter is
      port(
          clk_bcd : in std_logic;
          ena_bcd : in std_logic;
          rst_bcd : in std_logic;
          q_bcd   : out std_logic_vector(3 downto 0);
          max     : out std_logic
      );
    end component;

    signal reset        : std_logic;
    signal salida_bcd1  : std_logic_vector(3 downto 0) := (3 downto 0 => '0');
    signal salida_bcd2  : std_logic_vector(3 downto 0) := (3 downto 0 => '0');
    signal salida_bcd3  : std_logic_vector(3 downto 0) := (3 downto 0 => '0');
    signal salida_bcd4  : std_logic_vector(3 downto 0) := (3 downto 0 => '0');
    signal salida_bcd5  : std_logic_vector(3 downto 0) := (3 downto 0 => '0');
    signal salida_bcd6  : std_logic_vector(3 downto 0) := (3 downto 0 => '0');
    signal salida_bcd7  : std_logic_vector(3 downto 0) := (3 downto 0 => '0');
    signal salida_And   : std_logic_vector(5 downto 0) := (5 downto 0 => '0'); -- saida de los and para habilitar bcd q sigue
    signal max1, max2, max3, max4, max5, max6, max7 : std_logic;

begin


    -- salida_And(0) habilita el segundo bcd cuando el primero llega a 9 y el enable esta activo
    salida_And(0) <= ((salida_bcd1(3) and not (salida_bcd1(2)) and not (salida_bcd1(1)) and salida_bcd1(0)) and ena_unos);
    -- salida_And(1) habilita el 3er bcd cuando los dos primeros llegaron a 9 y el enable activo (esto lo implica la salida_And(0) prendida)
    salida_And(1) <= ((salida_bcd2(3) and not (salida_bcd2(2)) and not (salida_bcd2(1)) and salida_bcd2(0)) and salida_And(0));
    -- salida_And(2) habilita el 4to bcd cuando los tres primeros llegaron a 9 y el enable activo
    salida_And(2) <= ((salida_bcd3(3) and not (salida_bcd3(2)) and not (salida_bcd3(1)) and salida_bcd3(0)) and salida_And(1));
    -- salida_And(1) habilita el 5to bcd cuando los cuatro primeros llegaron a 9 y el enable activo
    salida_And(3) <= ((salida_bcd4(3) and not (salida_bcd4(2)) and not (salida_bcd4(1)) and salida_bcd4(0)) and salida_And(2));
    salida_And(4) <= ((salida_bcd5(3) and not (salida_bcd5(2)) and not (salida_bcd5(1)) and salida_bcd5(0)) and salida_And(3));
    salida_And(5) <= ((salida_bcd6(3) and not (salida_bcd6(2)) and not (salida_bcd6(1)) and salida_bcd6(0)) and salida_And(4));

    bcd1: BCD_counter
        port map (
            clk_bcd => clk_unos,
            ena_bcd => ena_unos,
            rst_bcd => reset,
            q_bcd   => salida_bcd1,
            max => max1
        );

    bcd2: BCD_counter
        port map (
            clk_bcd => clk_unos,
            ena_bcd => salida_And(0),
            rst_bcd => reset,
            q_bcd   => salida_bcd2,
            max => max2

        );

    bcd3: BCD_counter
        port map (
            clk_bcd => clk_unos,
            ena_bcd => salida_And(1),
            rst_bcd => reset,
            q_bcd   => salida_bcd3,
            max => max3

        );

    bcd4: BCD_counter
        port map (
            clk_bcd => clk_unos,
            ena_bcd => salida_And(2),
            rst_bcd => reset,
            q_bcd   => salida_bcd4,
            max => max4
        );

    bcd5: BCD_counter      
        port map (
            clk_bcd => clk_unos,
            ena_bcd => salida_And(3),
            rst_bcd => reset,
            q_bcd   => salida_bcd5,
            max => max5
        );

        bcd6: BCD_counter      
        port map (
            clk_bcd => clk_unos,
            ena_bcd => salida_And(4),
            rst_bcd => reset,
            q_bcd   => salida_bcd6,
            max => max6
        );
                                -- para el reset
        bcd7: BCD_counter      
        port map (
            clk_bcd => clk_unos,
            ena_bcd => salida_And(5),
            rst_bcd => reset,
            q_bcd   => salida_bcd7
        );

    q_bcd7 <= salida_bcd7; 
    q_bcd6 <= salida_bcd6;
    q_bcd5 <= salida_bcd5;
    q_bcd4 <= salida_bcd4;
    q_bcd3 <= salida_bcd3;
    q_bcd2 <= salida_bcd2;
    q_bcd1 <= salida_bcd1;
    
    reset <= rst_unos or ((salida_bcd7(3) and not (salida_bcd7(2)) and not (salida_bcd7(1)) and salida_bcd7(0) and salida_And(5)));


end architecture;