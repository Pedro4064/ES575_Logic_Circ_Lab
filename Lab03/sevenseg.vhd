library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sevenseg is
  port (
    num: in STD_LOGIC_VECTOR(3 DOWNTO 0);
    HEX: out STD_LOGIC_VECTOR(6 DOWNTO 0)
  );
  
end sevenseg;

architecture arch of sevenseg is 
	signal inter_signal: STD_logic_vector(6 DOWNTO 0);
begin	

	inter_signal <= "0111111" WHEN num = "0000" ELSE
					    "0000110" WHEN num = "0001" ELSE
					    "1011011" WHEN num = "0010" ELSE
					    "1001111" WHEN num = "0011" ELSE 
					    "1100110" WHEN num = "0100" ELSE
					    "1101101" WHEN num = "0101" ELSE
					    "1111101" WHEN num = "0110" ELSE
					    "0000111" WHEN num = "0111" ELSE
					    "1111111" WHEN num = "1000" ELSE
					    "1100111" WHEN num = "1001" ELSE
						 "1110111" WHEN num = "1010" ELSE
						 "1111100" WHEN num = "1011" ELSE
						 "0111001" WHEN num = "1100" ELSE
						 "1011110" WHEN num = "1101" ELSE
						 "1111001" WHEN num = "1110" ELSE
						 "1110001" WHEN num = "1111";
						
						 
	HEX <= NOT inter_signal;
	
end arch;

