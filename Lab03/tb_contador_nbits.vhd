library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_contador_nbits is
  port (
    KEY: in STD_LOGIC_VECTOR(3 DOWNTO 0);
	 SW: in STD_LOGIC_VECTOR(1 DOWNTO 0);
    HEX0: out STD_LOGIC_VECTOR(6 DOWNTO 0)
  );
  
end tb_contador_nbits;

architecture arch of tb_contador_nbits is

    -- Components used in the architecture
    component contador_nbits
	   generic(
			n: natural := 4
		);
	   port (
			CLK, ENABLE, RST: in STD_LOGIC;
			Q: out STD_LOGIC_VECTOR(n-1 DOWNTO 0)
		);
    end component;
	 
	 component sevenseg
		port (
			num: in STD_LOGIC_VECTOR(3 DOWNTO 0);
			HEX: out STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
		end component;
	 
		SIGNAL counter_total: STD_LOGIC_VECTOR(3 DOWNTO 0);
	 begin

	 CONT: contador_nbits generic map( 4 )PORT MAP(CLK=>KEY(0), ENABLE=>SW(0), RST=>SW(1), Q=> counter_total);
	 HEX:  sevenseg PORT MAP(num => counter_total, HEX => HEX0);
	 
	 
	 
	 
	 end arch;