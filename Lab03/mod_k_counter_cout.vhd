library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;

entity mod_k_counter_cout is
    generic(
        constant n: natural:=4;
        constant port_width : integer := integer(ceil(log2(real(n) + real(1))))
    );


	port(
		clock, reset_n, enable: in STD_LOGIC := '0';
        full_cycle: out STD_LOGIC := '0';
		Q: out STD_LOGIC_VECTOR(port_width downto 0) := (others => '0')
	);
end mod_k_counter_cout;

architecture arch of mod_k_counter_cout is

	begin
		process (clock, reset_n)

            variable value : unsigned(port_width DOWNTO 0) := (others => '0'); 	
            variable reached_full_cycle: boolean := false;
		
		begin
		
			if (reset_n = '0') then
				value :=(others => '0');
                reached_full_cycle := false;

			elsif (rising_edge(clock) and enable = '1') then
                -- First check if there has been a clock cycle since reached full cycle, if yes set bit to zero
                if (reached_full_cycle) then 
                    full_cycle <= '0';
                    reached_full_cycle := false;
                end if;

                -- Now check the conditions to increment counter value
                if (value + 1 > n) then 
                    value := (others => '0');
                    full_cycle <= '1';
                    reached_full_cycle := true;
                else
                    value := value + 1;
                end if;
				
			end if;
		
			Q <= std_LOGIC_VECTOR(unsigned(value));
		end process;
	end arch;
			
