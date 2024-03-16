--
-- VHDL Architecture audiotest_lib.triangleseq.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 15:51:47 01/16/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
use ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ARCHITECTURE behav OF triangleseq IS
BEGIN
  process(clk, res_n) is
    variable sequenceStep: natural range 1 to 32;
    variable lasttick: boolean;
    
    subtype sequenceValueT is natural range 0 to 15;
    type sequenceArrayT is array(1 to 32) of sequenceValueT;
    constant sequenceArray: sequenceArrayT := (15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
    
  begin
    if res_n ='0' then
      sequenceStep := 1;
      lasttick := false;
    else
      if clk'event and clk = '1' then
        if tick and not (tickdisableA or tickdisableB or lasttick) then
          if sequencestep /= 32 then
            sequenceStep := sequenceStep + 1;
          else
            sequenceStep := 1;
          end if;
        end if;
        
        lasttick := tick;
      end if;
    end if;
    
    q <= std_logic_vector2bool_vec(std_logic_vector(to_unsigned(sequenceArray(sequenceStep), 4)));
  end process;
END ARCHITECTURE behav;

