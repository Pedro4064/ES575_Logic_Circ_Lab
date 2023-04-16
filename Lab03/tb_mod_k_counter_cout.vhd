library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.math_real.all;

entity tb_mod_k_counter_cout is
end tb_mod_k_counter_cout;

architecture arch of  tb_mod_k_counter_cout is

    -- Components used in the architecture
    component mod_k_counter_cout
        generic(
            constant n: natural:=4;
            constant port_width :integer := integer(ceil(log2(real(n) + real(1))))
        );


        port(
            clock, reset_n, enable: in STD_LOGIC;
            full_cycle: out STD_LOGIC;
            Q: out STD_LOGIC_VECTOR(port_width downto 0)
            );
    end component;
	 
    -- SIGNAL s_counter_total: STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL s_counter_total:STD_LOGIC_VECTOR(integer(ceil(log2(real(59) + real(1)))) downto 0);
    SIGNAL s_clock, s_reset_n, s_full_cycle:  STD_LOGIC;

    begin

	 CONT: mod_k_counter_cout generic map(59)PORT MAP(clock=>s_clock, enable=>'1', reset_n=>s_reset_n, full_cycle => s_full_cycle, Q=> s_counter_total);

     TEST_BENCH : process
     begin
        s_reset_n <= '1';

        for i in 0 to 60*2 loop

                s_clock <= '1';
                wait for 10 ns;

                s_clock <= '0';
                wait for 10 ns;

        end loop;

        wait;
        
     end process ; -- TEST_BENCH

	 
	 
	 
	 end arch;