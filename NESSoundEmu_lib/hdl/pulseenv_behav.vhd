--
-- VHDL Architecture audiotest_lib.pulseenv.behav
--
-- Created:
--          by - redacted.redacted (pc038)
--          at - 12:53:54 01/15/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
USE IEEE.numeric_std.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ARCHITECTURE behav OF pulseenv IS
  signal steppedenvelope: integer range 0 to 15;
    
    
begin
  envelopestepper : process(clk, res_n) is 
    variable envelope: integer range 0 to 15;
    variable dividercnt: integer range 0 to 15;
    variable started: boolean;
    variable lastqfclk: boolean;
  begin
    if res_n = '0' then
      envelope := 0;
      dividercnt := 15;
      started := false;
      lastqfclk := false;
    else
      if clk'event and clk = '1' then
        if startenv and not started then
          envelope := 15;
          dividercnt := bool_vec2integer(volumeset);
          started := true;
        end if;
        
        if not startenv then
          started := false;
        end if;
        
        
        if qfclk and not lastqfclk then
          if dividercnt /= 0 then
            dividercnt := dividercnt - 1;
          else
            dividercnt := bool_vec2integer(volumeset);
            if envelope /= 0 then
              envelope := envelope - 1;
            elsif loopenvelope then
              envelope := 15;
            end if;
          end if;
        end if;
        
        lastqfclk := qfclk;
      end if;
    end if;
    steppedenvelope <= envelope;
  end process envelopestepper;
  
  
  volume <= volumeset when constvol else integer2bool_vec(steppedenvelope, 4);
END ARCHITECTURE behav;

