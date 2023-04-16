library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity tb_module_k_counter is
end tb_module_k_counter;

architecture arch of  tb_module_k_counter is

    -- Components used in the architecture
    component module_k_counter
    generic(
        n: natural:=4
    );

	port(
		clock, reset_n: in STD_LOGIC;
        SW: in STD_LOGIC_VECTOR(n-1 downto 0);
		Q: out STD_LOGIC_VECTOR(n-1 downto 0)
	);

    end component;
	 
	 
    SIGNAL s_counter_total, s_SW: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL s_clock, s_reset_n:  STD_LOGIC;

    begin

	 CONT: module_k_counter generic map(8)PORT MAP(clock=>s_clock, reset_n=>s_reset_n, SW=>s_SW, Q=> s_counter_total);

     TEST_BENCH : process
     begin
        s_reset_n <= '1';

        for i in 0 to 7 loop
            s_SW <= STD_LOGIC_VECTOR(to_unsigned(i, s_SW'length));

            for j in 0 to i-1 loop 
                s_clock <= '1';
                wait for 10 ns;

                s_clock <= '0';
                wait for 10 ns;

            end loop;

        end loop;

        wait;
        
     end process ; -- TEST_BENCH

	 
	 
	 
	 end arch;