-- LOGICA (MUX) 
-- entrada --> utlimas 3 posiciones del contH (elije posicion del monitor)
-- selector --> utlimas 3 posiciones del cont v (elije franja del monitor)

entity mux_selector is 
    port(
        A_selector   : in bit_vector(2 downto 0);
        B_selector   : in bit_vector(2 downto 0);
        sel_selector : in bit;
        sal_selector : out bit_vector(2 downto 0)
    );
end;

architecture mux_selector_arq of mux_selector is

begin

    -- si sel_selector = 0 saca A_selector, si sel_selector = 1 saca B_selector
    sal_selector(0) <= (A_selector(0) and not sel_selector) or (B_selector(0) and sel_selector);
    sal_selector(1) <= (A_selector(1) and not sel_selector) or (B_selector(1) and sel_selector);
    sal_selector(2) <= (A_selector(2) and not sel_selector) or (B_selector(2) and sel_selector);

end; 