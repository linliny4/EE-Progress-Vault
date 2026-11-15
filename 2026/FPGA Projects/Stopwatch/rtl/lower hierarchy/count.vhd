-- Create Date: 12.11.2026 13:47:42


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;


entity counter is
--  Port ( );
Port (  clk:	in	std_logic;
      	reset: 	in 	std_logic;
      	carry_flg: out std_logic;
        output:	out std_logic_vector(3 downto 0));
        
end counter;
 
architecture Behavioral of counter is
    signal t_cnt : unsigned(3 downto 0);
    signal carry: std_logic;
begin
   
    process(clk, reset)
    begin
    
    carry <= '0';
    if(reset = '1') then
        t_cnt <= (others => '0');
    elsif (rising_edge(clk)) then
        if t_cnt = 9 then
            t_cnt <= (others => '0');
            carry <= '1';
        else
    	   t_cnt <= t_cnt + 1;
    end if;
        
    end if;
    
    
	end process;
	carry_flg <= carry;
	output <= std_logic_vector(t_cnt);
	
end Behavioral;
