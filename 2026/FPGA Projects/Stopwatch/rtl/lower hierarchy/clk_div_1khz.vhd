
-- Create Date: 12.11.2026 13:47:42

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;



entity clk_divider_1khz is
Port (clk_in:  in std_logic;
      reset:   in std_logic;
      set_clk_div:     in std_logic;
      clk_out: out std_logic);
      
constant board_clk: integer := 100000000;
  
end clk_divider_1khz;

architecture Behavioral of clk_divider_1khz is
signal i_count : integer range 0 to 99999 := 0;
signal clk_reg : std_logic := '0';
begin
    
    process(clk_in, reset)
    begin


    if reset = '1' then
    i_count <= 0;
    clk_reg <= '0';
    elsif rising_edge(clk_in) and set_clk_div = '1' then
    if i_count = 49999 then
        i_count <= 0;
        clk_reg <= not clk_reg;
    else
        i_count <= i_count + 1;
    end if;
    end if;
    
 
    end process;
    clk_out <= clk_reg;

        
end Behavioral;
