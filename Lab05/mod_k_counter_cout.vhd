library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;

entity mod_k_counter_cout is
    generic(
        constant n: natural:=4
    );


	port(
			clock, reset_n, enable: in STD_LOGIC := '0';
			full_cycle: out STD_LOGIC := '0'
	);
	
end mod_k_counter_cout;

architecture arch of mod_k_counter_cout is
	constant clk_cycle: integer := integer(50*(n)*1000000);
	signal value : integer := 0;
	
	begin
		process (clock, reset_n)
		begin
		
			if (reset_n = '0' or enable = '0') then
				value <= 0;
				full_cycle <= '0';

			elsif (rising_edge(clock) and enable = '1') then
                -- Now check the conditions to increment counter value
                if (value + 1 > clk_cycle) then 
                    full_cycle <= '1';
                else
                    value <= value + 1;
                end if;
				
			end if;
		
		end process;
	end arch;