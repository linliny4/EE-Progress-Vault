

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity binary_to_seg_decoder is
Port (  binary_in:          in  std_logic_vector (3 downto 0);
        seven_seg_logic:    out std_logic_vector (6 downto 0));
        
end binary_to_seg_decoder;

architecture Behavioral of binary_to_seg_decoder is

begin

    process(binary_in)
    begin
    
        case(binary_in) is
            when "0000" => seven_seg_logic <= "1000000";
            when "0001" => seven_seg_logic <= "1111001";
            when "0010" => seven_seg_logic <= "0100100";
            when "0011" => seven_seg_logic <= "0110000";
            when "0100" => seven_seg_logic <= "0011001";
            when "0101" => seven_seg_logic <= "0010010";
            when "0110" => seven_seg_logic <= "0000010";
            when "0111" => seven_seg_logic <= "1111000";
            when "1000" => seven_seg_logic <= "0000000";
            when "1001" => seven_seg_logic <= "0011000";
            when others => seven_seg_logic <= "0000000";
            end case;
   end process;
   
end Behavioral;
