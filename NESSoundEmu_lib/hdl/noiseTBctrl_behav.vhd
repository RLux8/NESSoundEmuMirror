--
-- VHDL Architecture audiotest_lib.noiseTBctrl.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 14:43:28 01/17/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
use ieee.std_logic_1164.all;


ARCHITECTURE behav OF noiseTBctrl IS
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
        if apuclk then
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
        addr <= 0;
        data <=  (others => false);
        wr <= false;
      when WRITE1 =>
        addr <= (false, false);
        data <=  (false, false, false, true, true, true, true, true);
        wr <= true;
      when WRITE2 => null;
      
      when WRITE3 =>
        addr <= (true, false);
        data <= (true, false, false, false, false, true, true, true);
        wr <= true;
    
      when WRITE4 =>
        addr <= (true, true);
        data <= (false, false, false, true, true, true, true, true); --B"01011000";
        wr <= true;
       
      when WRITE5 => null;
      
      when DONE => wr <= false;
    end case;
    mode <= false;
    genint <= false;
    resctr <= false;
  end process fsm_outputs;
END ARCHITECTURE behav;

