--
-- VHDL Architecture audiotest_lib.dmctestrom.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 15:31:25 01/22/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
use ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ARCHITECTURE behav OF dmctestrom IS
BEGIN
  process(dmcaddr) is
  begin
    case bool_vec2integer(dmcaddr) is
      when 49152 to 65535 => dmcdata <= std_logic_vector2bool_vec(X"55");
      when others => dmcdata <= std_logic_vector2bool_vec(X"00");
    end case;
    --dmcreadack <= true;
  end process;
  
  process(clk, res_n) is 
  begin
    if res_n = '0' then
      dmcreadack <= false;
    else
      if clk'event and clk = '1' then
        dmcreadack <= dmcreadreq;
      end if;
    end if;
  end process;
END ARCHITECTURE behav;

