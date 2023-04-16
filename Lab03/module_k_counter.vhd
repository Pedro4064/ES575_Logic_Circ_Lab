library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity module_k_counter is
    generic(
        n: natural:=4
    );

	port(
		clock, reset_n: in STD_LOGIC;
        SW: in STD_LOGIC_VECTOR(n-1 downto 0);
		Q: out STD_LOGIC_VECTOR(n-1 downto 0)
	);
end module_k_counter;

architecture arch of module_k_counter is

	begin
		process (clock, reset_n)

            variable value : unsigned(n-1 DOWNTO 0) := (others => '0'); 	
		
		begin
		
			if (reset_n = '0') then
				value :=(others => '0')	;

			elsif (rising_edge(clock)) then
                if (value + 1 >= unsigned(SW)) then 
                    value := (others => '0');
                else
                    value := value + 1;
                end if;
				
			end if;
		
			Q <= std_LOGIC_VECTOR(value);
		end process;
	end arch;
			
