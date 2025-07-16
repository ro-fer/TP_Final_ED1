-- Test de contador de  33k



entity c33k_tb is
end;

architecture c33k_tb_arq of c33k_tb is

component c33k is 

        port (
            clk_33k : in bit;
            rst_33k : in bit;   
            ena_33k : in bit;   
            out_1   : out bit;  -- se va a habilitar el registro
            out_2   : out bit;   -- se va a resetear el contador de unos 
            cuenta  : out bit_vector(15 downto 0)
        );
    end component;

    signal clk_33k_tb   : bit := '0';
    signal rst_33k_tb   : bit := '0';
    signal ena_33k_tb   : bit := '0';
    signal out_1_tb     : bit := '0';
    signal out_2_tb     : bit := '0';
    signal salida_tb    : bit_vector(15 downto 0) := (15 downto 0 => '0');

begin 
    ena_33k_tb <= '1' after 10 ns;
    clk_33k_tb <= not clk_33k_tb after 5 ns;
    rst_33k_tb <= '1' after 20 ns, '0' after 50 ns;

    DUT: c33k
        port map(
            clk_33k => clk_33k_tb,
            rst_33k => rst_33k_tb,
            ena_33k => ena_33k_tb,
            out_1   => out_1_tb,
            out_2   => out_2_tb,
            cuenta  => salida_tb
        );
end;
