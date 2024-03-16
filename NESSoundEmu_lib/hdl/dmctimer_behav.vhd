--
-- VHDL Architecture audiotest_lib.dmctimer.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 15:17:42 01/17/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
use ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ARCHITECTURE behav OF dmctimer IS
BEGIN
  process(clk, res_n) is 
    variable ctr: natural range 0 to 428;   
    type periodLUTT is array(0 to 15) of natural;
    --constant periodLUT: periodLUTT := (398, 354, 316, 298, 276, 236, 210, 198, 176, 148, 132, 118, 98, 78, 66, 50); PAL
    constant periodLUT: periodLUTT := (428, 380, 340, 320, 286, 254, 226, 214, 190, 160, 142, 128, 106, 84, 72, 54); --NTSC
    
  begin
    if res_n = '0' then
      ctr := 0;
    else
      if clk'event and clk = '1' then
        -- usually count down and then reload the value
        if cpuclk then
          if ctr = 0 or updateperiod then
            ctr := periodLUT(bool_vec2integer(periodsetting));
            if not updateperiod then
              tick <= true;
            end if;
          else
            ctr := ctr - 1;
            tick <= false;
          end if;
        end if;
      end if;
    end if;
  end process;
END ARCHITECTURE behav;

