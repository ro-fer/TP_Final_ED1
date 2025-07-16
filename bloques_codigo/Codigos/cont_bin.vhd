-- contador binario N bits

entity cont_bin is
    generic (
        N : natural := 10
    );
    port (
        clk_bin: in bit;
        rst_bin: in bit;
        ena_bin: in bit;
        salida_bin   : out bit_vector(N-1 downto 0)
    );
end entity;

architecture cont_bin_arq of cont_bin is
    component ffd is 
        port(
            clk_i   : in bit;
            rst_i   : in bit;
            ena_i   : in bit;
            d_i     : in bit;
            q_o     : out bit
        );
    end component;
    begin
    signal sal_And : bit_vector(9 downto 0);  
    signal sal_Xor : bit_vector(9 downto 0); 
    signal salida   : bit_vector(9 downto 0);
    
    begin

     entrada(0) <= salida(0) xor ena_bin10
     ffd0: ffd 
         port map (
             clk_i   => clk_bin,
             rst_i   => rst_bin,
             ena_i   => ena_bin10,
             d_i     => entrada(0),
             q_o     => salida(0)
     );
     ffd1: ffd 
         port map (
             clk_i   => clk_bin,
             rst_i   => rst_bin,
             ena_i   => ena_bin10,
             d_i     => entrada(1),
             q_o     => salida(1)
     );
     ffd2: ffd 
         port map (
             clk_i   => clk_bin,
             rst_i   => rst_bin,
             ena_i   => ena_bin10,
             d_i     => entrada(2),
             q_o     => salida(2)
     );
     ffd3: ffd 
         port map (
             clk_i   => clk_bin,
             rst_i   => rst_bin,
             ena_i   => ena_bin10,
             d_i     => entrada(3),
             q_o     => salida(3)
     );
     ffd4: ffd 
         port map (
             clk_i   => clk_bin,
             rst_i   => rst_bin,
             ena_i   => ena_bin10,
             d_i     => entrada(4),
             q_o     => salida(4)
     );
     ffd5: ffd 
         port map (
             clk_i   => clk_bin,
             rst_i   => rst_bin,
             ena_i   => ena_bin10,
             d_i     => entrada(5),
             q_o     => salida(5)
     );
     ffd6: ffd 
         port map (
             clk_i   => clk_bin,
             rst_i   => rst_bin,
             ena_i   => ena_bin10,
             d_i     => entrada(6),
             q_o     => salida(6)
     );
     ffd7: ffd 
         port map (
             clk_i   => clk_bin,
             rst_i   => rst_bin,
             ena_i   => ena_bin10,
             d_i     => entrada(7),
             q_o     => salida(7)
     );
     ffd8: ffd 
         port map (
             clk_i   => clk_bin,
             rst_i   => rst_bin,
             ena_i   => ena_bin10,
             d_i     => entrada(8),
             q_o     => salida(8)
     );
     ffd9: ffd 
         port map (
             clk_i   => clk_bin,
             rst_i   => rst_bin,
             ena_i   => ena_bin10,
             d_i     => entrada(9),
             q_o     => salida(9)
     );
     entrada(1) <= salida(1) xor (salida(0) and ena_bin10);
     entrada(2) <= salida(2) xor (salida(1) and (salida(0) and ena_bin10));
     entrada(3) <= salida(3) xor (salida(3) and (salida(1) and (salida(0) and ena_bin10)));
     entrada(4) <= salida(4) xor (salida(4) and (salida(3) and (salida(1) and (salida(0) and ena_bin10))));
     entrada(5) <= salida(5) xor (salida(5) and (salida(4) and (salida(3) and (salida(1) and (salida(0) and ena_bin10)))));
     entrada(6) <= salida(6) xor (salida(6) and (salida(5) and (salida(4) and (salida(3) and (salida(1) and (salida(0) and ena_bin10))))));
     entrada(7) <= salida(7) xor (salida(7) and (salida(6) and (salida(5) and (salida(4) and (salida(3) and (salida(1) and (salida(0) and ena_bin10)))))));
     entrada(8) <= salida(8) xor (salida(8) and (salida(7) and (salida(6) and (salida(5) and (salida(4) and (salida(3) and (salida(1) and (salida(0) and ena_bin10))))))));
     entrada(9) <= salida(9) xor (salida (9) and (salida(8) and (salida(7) and (salida(6) and (salida(5) and (salida(4) and (salida(3) and (salida(1) and (salida(0) and ena_bin10)))))))));
    
    salida_10  <= salida;

    -- opcion con if y for
    -- sal_And(0) <= ena_bin;
    -- sal_Xor(0) <= sal_And(0) xor salida(0);

    -- cont_bin10: for i in 0 to 9 generate
    --     etapa_0: if i = 0 generate
    --         ffd0: ffd port map (
    --                     clk_i => clk_bin,
    --                     rst_i => rst_bin,
    --                     ena_i => '1',
    --                     d_i => sal_Xor(0),
    --                     q_o => salida(0)
    --                 );
    --     end generate;
    --     
    --     etapa_1: if i > 0 generate
    --         --conexiones de las N etapas
    --         sal_And(i) <= sal_And(i-1) and salida(i-1);
    --         sal_Xor(i) <= sal_And(i) xor salida(i);

    --         ffdN: ffd port map (
    --                     clk_i => clk_bin,
    --                     rst_i => rst_bin,
    --                     ena_i => '1',
    --                     d_i => sal_Xor(i),
    --                     q_o => salida(i)
    --                 );
    --     end generate;
    -- end generate;

    end;


end architecture;
