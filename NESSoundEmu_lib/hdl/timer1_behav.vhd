--
-- VHDL Architecture audiotest_lib.timer1.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 12:48:04 01/16/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ARCHITECTURE behav OF tritimer IS
BEGIN
    process(clk, res_n) is 
    variable pulsetimer: natural range 0 to 2047;   
  begin
    if res_n = '0' then
      pulsetimer := natural(0);
    else
      if clk'event and clk = '1' then
        -- usually count down and then reload the value
        if cpuclk then
          if pulsetimer /= 0 then
            pulsetimer := pulsetimer - 1;
            tick <= false;
          else
            pulsetimer := bool_vec2integer(period);
            tick <= true;
          end if;
        end if;
        
      end if;
    end if;
  end process;
END ARCHITECTURE behav;

