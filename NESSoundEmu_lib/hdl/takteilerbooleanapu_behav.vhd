--
-- VHDL Architecture audiotest_lib.takteilerbooleanapu.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 15:39:38 01/16/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
use ieee.std_logic_1164.all;

ARCHITECTURE behav OF takteilerbooleanapu IS
BEGIN
  process(clk, res_n) is
    variable q_int: natural range 1 to MAX;
  begin
    if res_n = '0' then
      q_int := 1;
      apuclk <= false;
    else
      if clk'event and clk = '1' then
        if q_int /= MAX then
          q_int := q_int + 1;
          apuclk <= false;
        else
          q_int := 1;
          apuclk <= true;
        end if;
      end if;
    end if; 
  end process;
END ARCHITECTURE behav;
