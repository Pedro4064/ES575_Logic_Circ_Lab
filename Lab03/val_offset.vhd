LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.MATH_REAL.ALL;

ENTITY val_offset IS
    GENERIC(
        CONSTANT setup_input_width: NATURAL := 4;                                           -- The number of bits used to set the offset
        CONSTANT max_io_value:  NATURAL := 4;                                               -- Max numerical input and output expected
        CONSTANT port_width : NATURAL := NATURAL(CEIL(LOG2(REAL(max_io_value) + REAL(1))))  -- Calculation from max numerical value to number of bits necessay to represent them
    );


	PORT(
        input_value: IN STD_LOGIC_VECTOR(port_width DOWNTO 0);                 -- Value to be Added
        input_target_value: IN STD_LOGIC_VECTOR(setup_input_width DOWNTO 0);   -- Value of the offset to be Added
        CLK, RST, OFFSET_SET: IN STD_LOGIC;                                    -- External and Independent inputs, CKL = Clock and RST = Async Reset, OFFSET_SET signal that controls when to update value
        output_value: OUT STD_LOGIC_VECTOR(port_width DOWNTO 0)                -- Output Value
	);

END val_offset;

ARCHITECTURE arch OF val_offset IS

            TYPE STATE IS (S0, S1);                                             -- The possible states this FSM will have
            SIGNAL   next_state, current_state: STATE;                          -- The signals that represent the next and current states


	BEGIN

        -- ASYNC RESET AND STATE CHANGE FUNCTIONALITY
		FSM_PROC: PROCESS (CLK, RST)
		BEGIN
		
			IF (RST = '0') THEN
                current_state <= S0;
            
            ELSIF (RISING_EDGE(CLK)) THEN 
                current_state <= next_state;
            
            END IF;
        END PROCESS; -- FSM_PROC

        -- LOGIC BASED ON CURRENT STATE
        LOGIC_PROC: PROCESS(current_state, input_value, input_target_value, OFFSET_SET)
            VARIABLE input_value_variable, output_value_variable,   input_target_value_variable : UNSIGNED(port_width DOWNTO 0) := (others => '0'); 	-- Variable to hold the value from input_target_value as a number to do calculations with and the offset value to do calculations with
            VARIABLE delta_value: SIGNED(port_width DOWNTO 0) := (others => '0');                                                                                                      -- Variable holding the delta between the target and the at_time value
        BEGIN

                input_value_variable  := UNSIGNED(input_value);
                input_target_value_variable  := UNSIGNED(input_target_value);

            CASE current_state IS 

                WHEN S0 => 
                    
                    IF SIGNED(input_value_variable) + delta_value < 0 THEN 
                        output_value_variable := UNSIGNED(SIGNED(TO_UNSIGNED(max_io_value, port_width)) + (SIGNED(input_value_variable) + delta_value)); --! PERHAPS port_width PLUS OR MINUS 1
                    ELSE 
                        output_value_variable := UNSIGNED(SIGNED(input_value_variable) + delta_value);
                    END IF;

                    -- NEXT STATE LOGIC
                    IF OFFSET_SET = '1' THEN 
                        next_state <= S1;
                    ELSE 
                        next_state <= S0;
                    END IF;
                    

                WHEN S1 => 
                    delta_value :=  SIGNED(input_target_value_variable) - SIGNED(input_value_variable);

                    -- NEXT STATE LOGIC
                    next_state <= S0;

            END CASE;

		END PROCESS;
	end arch;
			
