-- Testbench para reg_Nb
entity reg_tb is
end;

architecture reg_tb_arq of reg_tb is 

    component reg is 
        port (
            clk_reg : in bit;
            rst_reg : in bit;
            ena_reg : in bit;
            -- entradas de los bcd
            d1_reg  : in bit_vector(3 downto 0);
            d2_reg  : in bit_vector(3 downto 0);
            d3_reg  : in bit_vector(3 downto 0);
            -- salidas al mux
            q1_reg  : out bit_vector(3 downto 0);
            q2_reg  : out bit_vector(3 downto 0);
            q3_reg  : out bit_vector(3 downto 0)
        );
    end component;

    signal clk_reg_tb   : bit := '0';
    signal rst_reg_tb   : bit := '0';
    signal ena_reg_tb   : bit := '0';
    signal d1_reg_tb    : bit_vector(3 downto 0):= (3 downto 0 => '0');
    signal d2_reg_tb    : bit_vector(3 downto 0):= (3 downto 0 => '0');
    signal d3_reg_tb    : bit_vector(3 downto 0):= (3 downto 0 => '0');
    signal q1_reg_tb    : bit_vector(3 downto 0):= (3 downto 0 => '0');
    signal q2_reg_tb    : bit_vector(3 downto 0):= (3 downto 0 => '0');
    signal q3_reg_tb    : bit_vector(3 downto 0):= (3 downto 0 => '0');

begin   
    ena_reg_tb <= '1' after 10 ns;
    clk_reg_tb <= not clk_reg_tb  after 5 ns;
    --rst_reg_tb <= '1' after 30 ns, '0' after 40 ns;
    d1_reg_tb <= "0001" after 20 ns, "0010" after 30 ns, "0011" after 40 ns, "0100" after 50 ns, "0101" after 60 ns, "0110" after 70 ns, "0111" after 80 ns;
	d2_reg_tb <= "0001" after 20 ns, "0010" after 30 ns, "0011" after 40 ns, "0100" after 50 ns, "0101" after 60 ns, "0110" after 70 ns, "0111" after 80 ns;
	d3_reg_tb <= "0001" after 20 ns, "0010" after 30 ns, "0011" after 40 ns, "0100" after 50 ns, "0101" after 60 ns, "0110" after 70 ns, "0111" after 80 ns;

    DUT: reg
        port map(
            clk_reg => clk_reg_tb,
            rst_reg => rst_reg_tb,
            ena_reg => ena_reg_tb,
            d1_reg  => d1_reg_tb,
            d2_reg  => d2_reg_tb,
            d3_reg  => d3_reg_tb,
            q1_reg  => q1_reg_tb,
            q2_reg  => q2_reg_tb,
            q3_reg  => q3_reg_tb
            );
end;
