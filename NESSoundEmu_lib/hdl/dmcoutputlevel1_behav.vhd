--
-- VHDL Architecture audiotest_lib.dmcoutputlevel.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 15:03:46 01/17/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all;
LIBRARY ieee;
USE IEEE.numeric_std.all;
use ieee.std_logic_1164.all;

ARCHITECTURE behav OF dmcoutputlevel IS
BEGIN
  process(clk, res_n) is 
    variable level_int: natural range 0 to 127;   
  begin
    if res_n = '0' then
      level_int := 63;
    else
      if clk'event and clk = '1' then
        -- usually count down and then reload the value
        if cpuclk then
          if loadvalue then
            level_int := bool_vec2integer(loadval);
          elsif incLevel then
            if level_int < 126 then
              level_int := level_int + 2;
            end if;
          elsif decLevel then
            if level_int > 1 then
              level_int := level_int - 2;
            end if; 
            
          end if;
        end if;
      end if;
    end if;
    level <= integer2bool_vec(level_int, 7);
  end process;
END ARCHITECTURE behav;



