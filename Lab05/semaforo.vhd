LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;

ENTITY semaforo IS
	PORT(
		CLK_50: IN STD_LOGIC;
		SW: IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		HEX0, HEX1: out STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END semaforo;

ARCHITECTURE arch OF semaforo IS

	-- Components
	COMPONENT sincronizador IS
		PORT(
			D, CLK, RST:IN STD_LOGIC;
			Q: OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT sevenseg IS
		port (
			num: in STD_LOGIC_VECTOR(3 DOWNTO 0);
			HEX: out STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT mod_k_counter_cout IS
		generic(
       constant n: natural:=4
    );
		port(
			clock, reset_n, enable: in STD_LOGIC := '0';
			full_cycle: out STD_LOGIC := '0'
		);
	END COMPONENT;

	-- State Definitions
	TYPE STATE IS (E0, E1, E2, E3);
	SIGNAL c_state, n_state: STATE := E0;
	
	-- Aux signals
	SIGNAL s_TminStart, s_TamStart, s_TmaxStart, s_Tmin, s_Tam, s_Tmax, s_Sensor: STD_LOGIC;
	SIGNAL s_FarolVd, s_FarolVm, s_FarolAm: STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN

	s_FarolVd <= NOT("1011100");
	s_FarolVm <= NOT("1100011");
	s_FarolAm <= NOT("1000000");
	
	SINC1: sincronizador PORT MAP(D => SW(0), CLK => CLK_50, RST => '1', Q => s_Sensor);
	TIMER1: mod_k_counter_cout generic map(1)PORT MAP(clock=>CLK_50, enable=>s_TamStart, reset_n=>'1', full_cycle => s_Tam);
	TIMER2: mod_k_counter_cout generic map(3)PORT MAP(clock=>CLK_50, enable=>s_TminStart, reset_n=>'1', full_cycle => s_Tmin);
	TIMER3: mod_k_counter_cout generic map(5)PORT MAP(clock=>CLK_50, enable=>s_TmaxStart, reset_n=>'1', full_cycle => s_Tmax);

	
	-- Processes definitions
	SYNC_PROCESS: PROCESS(CLK_50) 
	BEGIN
		IF RISING_EDGE(CLK_50) THEN
			c_state <= n_state;
		END IF;
	END PROCESS;
	
	LOGIC_PROCESS: PROCESS(s_Sensor, c_state, s_Tam, s_Tmax, s_Tmin)
	BEGIN
		CASE c_state IS
			WHEN E0 => -- Vd/Vm
				HEX0 <= s_FarolVd;
				HEX1 <= s_FarolVm;
				s_TminStart <= '1';
				s_TamStart <= '0';
				s_TmaxStart <= '0';
				
				IF s_Sensor = '0' or s_Tmin = '0' THEN
					n_state <= E0;
				ELSE
					n_state <= E1;
				END IF;
			
			
			WHEN E1 => -- Am/Vm
				HEX0 <= s_FarolAm;
				HEX1 <= s_FarolVm;
				s_TminStart <= '0';
				s_TamStart  <= '1';
				s_TmaxStart <= '0';
				
				IF s_Tam = '0' THEN
					n_state <= E1;
				ELSE
					n_state <= E2;
				END IF;
				
				
			WHEN E2 => -- Vm/Vd
				HEX0 <= s_FarolVm;
				HEX1 <= s_FarolVd;
				
				s_TminStart <= '0';
				s_TamStart  <= '0';
				s_TmaxStart <= '1';
				
				IF s_sensor = '1' and s_Tmax = '0' THEN
					n_state <= E2;
				ELSE
					n_state <= E3;
				END IF;
				
				
			WHEN E3 => -- Vm/Am
				HEX0 <= s_FarolVm;
				HEX1 <= s_FarolAm;
				s_TminStart <= '0';
				s_TamStart  <= '1';
				s_TmaxStart <= '0';
				
				IF s_Tam = '0' THEN
					n_state <= E3;
				ELSE
					n_state <= E0;
				END IF;
				
			
			
			
		END CASE;
	END PROCESS;
END arch;