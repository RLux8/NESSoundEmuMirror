--
-- VHDL Architecture audiotest_lib.trianglelinearctr.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 16:10:55 01/16/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
use ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ARCHITECTURE behav OF trianglelinearctr IS
    
BEGIN
  process(clk, res_n) is
    variable linearctr: natural range 0 to 127;
    variable reloadflag: boolean;
  begin
    if res_n = '0' then
      lineariszero <= false;
      reloadflag := false;
      linearctr := 0;
    else
      if clk'event and clk = '1' then
        if linearreload and not reloadflag then
          reloadflag := true;
        end if;
        
        
        if fclk then
          if reloadflag then
            linearctr := bool_vec2integer(reloadval);
          elsif linearctr /= 0 then
            linearctr := linearctr - 1;
          end if;
          
          if reloadflag and not linearctrl then
            reloadflag := false;
          end if;
        end if;
      end if;
    end if; 
    
    if linearctr = 0 then
      lineariszero <= true;
    else
      lineariszero <= false;
    end if;
  end process;
END ARCHITECTURE behav;

