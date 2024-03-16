--
-- VHDL Architecture audiotest_lib.noisetimer.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 11:21:18 01/17/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all;
library ieee; use ieee.std_logic_1164.all; 
 use ieee.numeric_std.all;


ARCHITECTURE behav OF noisetimer IS
BEGIN
  process(clk, res_n) is
    variable timerctr: natural range 0 to 3778;
    type periodLUTT is array(natural range 0 to 15) of natural;
    constant periodLUT : periodLUTT := (4, 8, 14, 30, 60, 88, 118, 148, 188, 236, 354, 472, 708, 944, 1890, 3778);
  begin
    if res_n = '0' then
      timerctr := 0;
    else
      if clk'event and clk = '1' then
        if cpuclk then
          if timerctr /= 0 then
            timerctr := timerctr - 1;
            tick <= false;
          else
            timerctr := periodLUT(bool_vec2integer(periodsetting));
            tick <= true;
          end if;
        end if;
      end if;
    end if; 
    
  end process;
END ARCHITECTURE behav;

