--
-- VHDL Architecture audiotest_lib.nesmixer.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 12:35:43 02/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all;


ARCHITECTURE behav OF nesmixer IS
BEGIN
 
  mixing : process(all) is
  begin
    mix <= integer2bool_vec((bool_vec2integer(apumix)*4 + bool_vec2integer(vrc6mix)*4 + bool_vec2integer(n163mix) * 3), mix'high+1);
  end process mixing; 
  
  
END ARCHITECTURE behav;

