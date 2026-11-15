-- Create Date: 12.11.2026

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Stopwatch is
Port (set_main: in std_logic;
      reset_main: in std_logic;
      clock_main: in std_logic;
      time_output: out std_logic_vector (7 downto 0); -- The output should be 4 seven segment displays showing the time of the stopwatch. 7 x 4 = 28
      display_number: out std_logic_vector (3 downto 0)); 
     
end Stopwatch;

architecture Behavioral of Stopwatch is
-------------- In here we declare the lower level entities for the counter, they are components ---------------
    component clk_divider_1khz is
        Port (clk_in:  in std_logic;
              reset:   in std_logic;
              set_clk_div:     in std_logic;
              clk_out: out std_logic);
    end component;
    
    component counter is
        Port (  clk:	in	std_logic;
      	        reset: 	in 	std_logic;
      	        carry_flg: out std_logic;
                output:	out std_logic_vector(3 downto 0));
    end component;
    
    component binary_to_seg_decoder is
        Port (  binary_in:          in  std_logic_vector (3 downto 0);
                seven_seg_logic:    out std_logic_vector (6 downto 0));
    end component;
    
    component multiplexer is
    Port (clk:  in std_logic;
      multiplex_out:    out std_logic_vector(3 downto 0));
    end component;
    
    
    signal clk_1K: std_logic;
    signal seven_seg_input: std_logic_vector (15 downto 0):= x"0000";
    signal track_time: std_logic_vector(27 downto 0);
    signal clk_2: std_logic;
    signal clk_3: std_logic;
    signal clk_4: std_logic;
    
    signal display: std_logic_vector (3 downto 0);
    signal display_reg: std_logic_vector (7 downto 0);
    signal carry1, carry2, carry3, carry4: std_logic ;
    
begin
    div: clk_divider_1khz port map ( clk_in  =>  clock_main,
                                reset   => reset_main,
                                set_clk_div     => set_main,
                                clk_out =>  clk_1K);   
                                
    count1:  counter port map  ( clk =>  clk_1K,
                                reset => reset_main,
                                carry_flg => carry1,
                                output => seven_seg_input(3 downto 0));    
    clk_2 <= carry1;
    
    count2:  counter port map  ( clk => clk_2,
                                reset => reset_main,
                                carry_flg => carry2,
                                output => seven_seg_input(7 downto 4));
    clk_3 <= carry2;           
                     
    count3:  counter port map  ( clk =>  clk_3,
                                reset => reset_main,
                                carry_flg => carry3,
                                output => seven_seg_input(11 downto 8));
                                
    clk_4 <= carry3;  
                             
    count4:  counter port map  ( clk =>  clk_4,
                                reset => reset_main,
                                carry_flg => carry4,
                                output => seven_seg_input(15 downto 12)); 
    
    seg_decoder_1: binary_to_seg_decoder port map ( binary_in  => seven_seg_input(3 downto 0),
                                                     seven_seg_logic => track_time(6 downto 0));
  
    
    seg_decoder_2: binary_to_seg_decoder port map ( binary_in  => seven_seg_input(7 downto 4),
                                                     seven_seg_logic => track_time(13 downto 7));
                                                     
    
    seg_decoder_3: binary_to_seg_decoder port map ( binary_in  => seven_seg_input(11 downto 8),
                                                     seven_seg_logic => track_time(20 downto 14));  
                                                     
    seg_decoder_4: binary_to_seg_decoder port map ( binary_in  => seven_seg_input(15 downto 12),
                                                     seven_seg_logic => track_time(27 downto 21));                                                
                                                     
    
    multiplex:  multiplexer port map (clk => clock_main,
                                      multiplex_out => display);
    
                     
    process(display)
    begin
        
    case (display) is
    
    when "1110" => display_reg <= '1' & track_time(6 downto 0);
    when "1101" => display_reg <= '1' & track_time(13 downto 7);
    when "1011" => display_reg <= '1' & track_time(20 downto 14);
    when "0111" => display_reg <= '0' & track_time(27 downto 21);   
    when others => display_reg <= "11111111";
        
    end case;
    time_output <= std_logic_vector(display_reg);
    display_number <= std_logic_vector(display);
    end process;    
    
    
    
    
end Behavioral;
