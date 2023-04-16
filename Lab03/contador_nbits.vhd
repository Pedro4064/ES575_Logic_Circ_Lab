library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity contador_nbits is
  generic(
	n: natural := 4
  );
  
  port (
    CLK, ENABLE, RST: in STD_LOGIC;
    Q: out STD_LOGIC_vector(n-1 DOWNTO 0)
  );
end contador_nbits;



architecture arch of contador_nbits is

    -- Components used in the architecture
    component FF_T
        port(
            CLK, T, RST: in STD_LOGIC;
            Q: out STD_LOGIC
        );
    end component;
	 
	 signal q_outputs: std_logic_vector(n-1 downto 0);
	 signal t_aux: std_LOGIC_vector(n-1 downto 0);
	 
	 begin
	 
	 SHIFT_FFD_MAPPING : for i in 0 to n-1 generate

            first_generate:
              if (i = 0) generate
                firsrt_mapping: FF_T port map(T => ENABLE, CLK => CLK, RST => RST, Q => q_outputs(0));
					 t_aux(0) <= ENABLE;
					 
              end generate first_generate;

            second_generate:
              if (i = 1) generate
						middle_mapping: FF_T port map(T => q_outputs(0) and ENABLE, CLK => CLK, RST => RST, Q => q_outputs(i));
						t_aux(1) <= q_outputs(i-1) and ENABLE;
						
					end generate second_generate;
					
				others_generate:
					if (i > 1) generate
						t_aux(i)<= t_aux(i-1) and q_outputs(i-1);
						middle_mapping: FF_T port map(T => t_aux(i), CLK => CLK, RST => RST, Q => q_outputs(i));
						
					end generate others_generate;
				
			

    end generate SHIFT_FFD_MAPPING;
	 
	 Q <= q_outputs;
	 
	 end arch;
