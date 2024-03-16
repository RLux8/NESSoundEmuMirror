--
-- VHDL Architecture audiotest_lib.toplevelcontrol.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 10:39:50 02/05/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--

library audiotest_lib; use audiotest_lib.booleanvectors.all;
library ieee; use ieee.numeric_std.all; use ieee.std_logic_1164.all;


ARCHITECTURE behav OF toplevelcontrol IS
  signal allzeros: std_logic_vector(l_data_tx'high - mix'high - 2 downto 0);
  subtype dacvolumeT is natural range 0 to 127; 
  constant bothvolumes: dacvolumeT := 127;

BEGIN
  process(cpuclkx8, res_n) is
    type stateT is (INIT, RUNNING);
    variable state: stateT;
    
    constant N: natural := 16;
  begin
    if res_n = '0' then
      state := INIT;
      update <= '0';
      resetCPU <= false;
      runCPU <= false;
    else
      if cpuclkx8'event and cpuclkx8 = '1' then
        if state = INIT then
          if ready = '1' then
            state := RUNNING;
            
          end if;
          resetCPU <= true;
          runCPU <= false;
        elsif state = RUNNING then
          runCPU <= true;
          resetCPU <= false;
        end if;
      end if;
    end if;
    
    
  end process;
  
  leftdacvol <= std_logic_vector(to_unsigned(bothvolumes, 7));
  rightdacvol <= std_logic_vector(to_unsigned(bothvolumes, 7));
    
    
  allzeros <= (others => '0');
  l_data_tx <= std_logic_vector('0' & bool_vec2std_logic_vector(mix) & allzeros); --make sure value to the dac never wraps aroung to negative values
  r_data_tx <= std_logic_vector('0' & bool_vec2std_logic_vector(mix) & allzeros) when not monoaudio else (others => '0');
    
END ARCHITECTURE behav;

