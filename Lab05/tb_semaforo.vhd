LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;

ENTITY tb_semaforo IS
END tb_semaforo;

ARCHITECTURE arch OF tb_semaforo IS

    -- Component necessary for the test bench
    COMPONENT semaforo IS
        PORT(
            CLK_50: IN STD_LOGIC;
            SW: IN STD_LOGIC_VECTOR(17 DOWNTO 0);
            HEX0, HEX1: out STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;

    -- Create signals for testing
    SIGNAL s_CLK_50, s_SENSOR: STD_LOGIC;
    SIGNAL s_SW: STD_LOGIC_VECTOR(17 DOWNTO 0);
    SIGNAL s_HEX0, s_HEX1: STD_LOGIC_VECTOR(6 DOWNTO 0);


BEGIN

-- PORT MAPPING BETWEEN SIGNALS AND DEVICE TO EMULATE
SEM_1: semaforo PORT MAP(CLK_50 => s_CLK_50, SW => s_SW, HEX0 => s_HEX0, HEX1 => s_HEX1);

-- SET SENSOR HIGH FOR TESTING THE EXIT CONDITION OF STATE 0
s_SENSOR <= '1';

-- COMPOSE AUX SIGNAL FROM HELPPER SIGNALS
s_SW <= (0 => s_SENSOR, others => '0'); -- Set the switch 8 as the car sensor and populate other bits as zero

-- PROCESS TO GENERATE THE DRIVING CLOCK SIGNAL
CLK_PROCESS : PROCESS
            BEGIN
                    
            CLK_GENERATOR : FOR I IN 0 TO 20 LOOP
                                s_CLK_50 <= '1';
                                wait for 1 ns;
                                
                                s_CLK_50 <= '0';
                                wait for 1 ns;
                
                            END LOOP ; -- CLK_GENERATOR

                            wait; -- inf wait to exit simulation

            END PROCESS ; -- CLK_PROCESS


END arch ; -- arch