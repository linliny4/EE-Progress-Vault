

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;


entity multiplexer is
Port (clk:  in std_logic;
      multiplex_out:    out std_logic_vector(3 downto 0));
end multiplexer;

architecture Behavioral of multiplexer is
signal i_count : integer range 0 to 99999 := 0;
signal count   : unsigned(5 downto 0);
signal clk_reg : std_logic := '0';
signal output_hold: std_logic_vector (3 downto 0);
begin
    
    process(clk)
    begin


    
    
    
    if rising_edge(clk) then
        if i_count = 49999 then
        i_count <= 0;
        clk_reg <= not clk_reg;
    else
        i_count <= i_count + 1;
    end if;
    end if;
    
 
  
    
    if rising_edge(clk_reg) then
    count <= count + 1;
    end if;

    case count(4 downto 3) is
    when "00" => output_hold <= "1110";
    when "01" => output_hold <= "1101";
    when "10" => output_hold <= "1011";
    when others => output_hold <= "0111";
    end case;
    
    end process;
    multiplex_out <= std_logic_vector(output_hold);

end Behavioral;
