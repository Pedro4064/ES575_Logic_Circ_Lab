library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity counter is
	generic(
		n: natural:=4
	);
	
	port(
		clock: in STD_LOGIC;
		reset_n : in STD_LOGIC;
		Q: out STD_LOGIC_VECTOR(n-1 downto 0)
	);
end counter;

architecture arch of counter 	is
	begin
		process (clock, reset_n)
		variable value : unsigned(n-1 DOWNTO 0); 	
		
		begin
		
			if (reset_n = '0') then
				value :=(others => '0')	;
				
			elsif (rising_edge(clock)) then
				value := value + 1;
				
			end if;
		
			Q <= std_LOGIC_VECTOR(value);
		end process;
	end arch;
			
