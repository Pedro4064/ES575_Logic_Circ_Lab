LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;

ENTITY sincronizador IS
	PORT(
		D, CLK, RST:IN STD_LOGIC;
		Q: OUT STD_LOGIC
	);
	END sincronizador;

ARCHITECTURE arch OF sincronizador IS

	COMPONENT FFD IS
		PORT(
			D, CLK, RST:IN STD_LOGIC;
			Q: OUT STD_LOGIC
		);
	END COMPONENT;
	
		SIGNAL s_Qout: STD_LOGIC_VECTOR(2 DOWNTO 0);

	
	BEGIN
	FDD1: FFD port map(D => D, CLK => CLK, RST => RST, Q => s_Qout(0));
	FDD2: FFD port map(D => s_Qout(0), CLK => CLK, RST => RST, Q => s_Qout(1));
	FDD3: FFD port map(D => s_Qout(1), CLK => CLK, RST => RST, Q => s_Qout(2));
	FDD4: FFD port map(D => s_Qout(2), CLK => CLK, RST => RST, Q => Q);
	
	END arch;