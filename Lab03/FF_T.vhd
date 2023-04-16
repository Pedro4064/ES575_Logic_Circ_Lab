library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FF_T is
  port (
    CLK, T, RST: in STD_LOGIC;
    Q: out STD_LOGIC
  );
end FF_T;

architecture arch of FF_T is

	TYPE state IS (S0, S1);
	SIGNAL c_state, n_state : state;
	
begin

    RISING_CLK : process(CLK, RST)
    begin

        if (RST = '0')then
				c_state <= S0;
				
		  elsif (RISING_EDGE(CLK)) then
				c_state <= n_state;
        end if;
            
    end process; -- RISING_CLK
	 
	 
	 STATES: process (T, c_state)
	 begin
			case c_state is
				when S0 => 
					-- OUTPUT SET
					Q <= '0';
					
					-- NEXT STATE SET
					if T = '0' then
						n_state <= S0;
					
					else 
						n_state <= S1;
					end if;
					
				when S1  =>
					-- OUTPUT SET
					Q <= '1';
					
					-- NEXT STATE SET
					if T = '0' then 
						n_state <= S1;
					
					else 
						n_state <= S0;
					end if;
			end case;
					
	 end process; -- STATE CHANGES

end arch ; -- arch