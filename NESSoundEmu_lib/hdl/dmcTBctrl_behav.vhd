--
-- VHDL Architecture audiotest_lib.dmcTBctrl.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 15:39:24 01/22/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
use ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ARCHITECTURE behav OF dmcTBctrl IS
  type stateT is (INIT, WRITE1, WRITE2, WRITE3, WRITE4, WRITE5, DONE);
  signal state: stateT;
BEGIN
  fsm_transitions : process(clk, res_n) is
    variable state_int: stateT;
  begin
    if res_n = '0' then
      state_int := INIT;
    else
      if clk'event and clk = '1' then
        if cpuclk then
          case state_int is
          when INIT => state_int := WRITE1;
          when WRITE1 => state_int := WRITE2;
          when WRITE2 => state_int := WRITE3;
          when WRITE3 => state_int := WRITE4;
          when WRITE4 => state_int := WRITE5; 
          when WRITE5 => state_int := DONE;
          when DONE => null;
          end case;
        end if;
      end if;
    end if;
    
    state <= state_int;
  end process fsm_transitions;
  
  fsm_outputs: process(state) is
  begin
    case state is
      when INIT => 
        addr <= (false, false);
        data <=  (others => false);
        wr <= false;
        enabled <= false;
      when WRITE1 =>
        addr <= (false, true);
        data <=  (false, true, true, false, false, false, true, true);
        wr <= true;
      when WRITE2 =>
        addr <= (true, false);
        data <= std_logic_vector2bool_vec(X"00");
        wr <= true;
        
      when WRITE3 =>
        addr <= (true, true);
        data <= std_logic_vector2bool_vec(X"01");
        wr <= true;
    
      when WRITE4 =>
        addr <= (false, false);
        data <= std_logic_vector2bool_vec(B"01001111"); --no looping std_logic_vector2bool_vec(B"01001111"); --with looping 
        wr <= true;
       
      when WRITE5 => enabled <= true;
      
      when DONE => wr <= false;
    end case;
  end process fsm_outputs;
END ARCHITECTURE behav;

