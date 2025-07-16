-- Test del sincronismo vertica

entity vsync_tb is 
end;

architecture vsync_tb_arq of vsync_tb is 

    component vsync is 
        port (
            ena_vsync   : in bit;
            rst_vsync   : in bit;
            clk_vsync   : in bit;
            v_sync      : out bit;
            v_vidon     : out bit;
            cont_v      : out bit_vector(9 downto 0)
        );
    end component;

    signal ena_vsync_tb   : bit := '0';
    signal rst_vsync_tb   : bit := '0';
    signal clk_vsync_tb   : bit := '0';
    signal v_sync_tb      : bit := '0';
    signal v_vidon_tb     : bit := '0';
    signal cont_v_tb      : bit_vector(9 downto 0) := (9 downto 0 => '0');

begin

    ena_vsync_tb <= '1' after 10 ns;
    clk_vsync_tb <= not clk_vsync_tb after 20 ns;
    -- rst_vsync_tb <= '1' after 30 ns, '0' after 40 ns;

    DUT: vsync
        port map(
            ena_vsync   => ena_vsync_tb,
            rst_vsync   => rst_vsync_tb,
            clk_vsync   => clk_vsync_tb,
            v_sync      => v_sync_tb,
            v_vidon     => v_vidon_tb,
            cont_v      => cont_v_tb
        );
end;