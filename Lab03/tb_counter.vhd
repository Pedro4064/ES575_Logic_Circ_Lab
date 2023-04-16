library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_counter is
  port (
	 KEY: in STD_LOGIC_VECTOR(3 DOWNTO 0);
    HEX0,HEX1,HEX2,HEX3: out STD_LOGIC_VECTOR(6 DOWNTO 0)
  );
  
end tb_counter;

architecture arch of tb_counter is

    -- Components used in the architecture
    component counter
	   generic(
			n: natural := 4
		);
	   port (
			clock: in STD_LOGIC;
			reset_n : in STD_LOGIC;
			Q: out STD_LOGIC_VECTOR(n-1 downto 0)
		);
    end component;
	 
	 component sevenseg
		port (
			num: in STD_LOGIC_VECTOR(3 DOWNTO 0);
			HEX: out STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
		end component;
	 
		SIGNAL counter_total: STD_LOGIC_VECTOR(15 DOWNTO 0);
	 begin

	 CONT: counter generic map( 16 )PORT MAP(clock=>KEY(0), reset_n=>'1', Q=> counter_total);
	 HEX_Z:  sevenseg PORT MAP(num => counter_total(3 DOWNTO 0), HEX => HEX0);
	 HEX_F:  sevenseg PORT MAP(num => counter_total(7 DOWNTO 4), HEX => HEX1);
	 HEX_S:  sevenseg PORT MAP(num => counter_total(11 DOWNTO 8), HEX => HEX2);
	 HEX_T:  sevenseg PORT MAP(num => counter_total(15 DOWNTO 12), HEX => HEX3);

	 
	 
	 
	 end arch;