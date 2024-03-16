--
-- VHDL Architecture audiotest_lib.ttboolean.behav
--
-- Created:
--          by - redacted.redacted (pc038)
--          at - 15:51:02 01/10/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
use ieee.std_logic_1164.all;


ARCHITECTURE behav OF ttboolean IS
BEGIN
   process(clk, res_n) is
    variable q_int: natural range 1 to MAX;
  begin
    if res_n = '0' then
      q_int := 1;
      tick <= false;
    else
      if clk'event and clk = '1' then
        if q_int /= MAX then
          q_int := q_int + 1;
          tick <= false;
        else
          q_int := 1;
          tick <= true;
        end if;
      end if;
    end if; 
  end process;
END ARCHITECTURE behav;

