-- REGISTRO 4 BITS

entity registro is
    
    port(
        clk_r   : in std_logic;
        rst_r   : in std_logic := '0';
        ena_r   : in std_logic;
        d_r     : in std_logic_vector(3 downto 0);
        q_r     : out std_logic_vector(3 downto 0)
    );
end;

architecture registro_arq of registro is 
    component ffd is 
        port(
            clk_i   : in std_logic;
            rst_i   : in std_logic;
            ena_i   : in std_logic;
            d_i     : in std_logic;
            q_o     : out std_logic
        );
    end component;

    signal entrada_ffd  : std_logic_vector(3 downto 0) := (3 downto 0 => '0');
    signal salida_ffd   : std_logic_vector(3 downto 0) := (3 downto 0 => '0');

begin

    ffd0: ffd
        port map(
            clk_i   => clk_r,
            rst_i   => rst_r,
            ena_i   => ena_r, 
            d_i     => entrada_ffd(0),
            q_o     => salida_ffd(0)
        );

    ffd1: ffd
        port map(
            clk_i   => clk_r,
            rst_i   => rst_r,
            ena_i   => ena_r, 
            d_i     => entrada_ffd(1),
            q_o     => salida_ffd(1)
        );

    ffd2: ffd
        port map(
            clk_i   => clk_r,
            rst_i   => rst_r,
            ena_i   => ena_r, 
            d_i     => entrada_ffd(2),
            q_o     => salida_ffd(2)
        );

    ffd3: ffd
        port map(
            clk_i   => clk_r,
            rst_i   => rst_r,
            ena_i   => ena_r, 
            d_i     => entrada_ffd(3),
            q_o     => salida_ffd(3)
        );

    entrada_ffd <= d_r ;
    q_r <= salida_ffd;
        
    end;