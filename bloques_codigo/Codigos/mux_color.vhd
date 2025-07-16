entity mux_color is 
    port(
        RGB : in bit;
        B   : in bit;
        sel : in bit;
        sal : out bit
    );
end;

architecture mux_color_arq of mux_color is 

begin

    sal <= (RGB and sel) or (B and not sel);
end;