--
-- VHDL Architecture audiotest_lib.apumixer.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 13:21:56 01/23/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ARCHITECTURE behav OF apumixer IS
BEGIN
  process(p1mix, p2mix, trimix, noisemix, dmcmix) is
    variable totalmix: integer range 0 to 2550;
  begin
    -- WE USE A LINEAR APPROXIMATION OF THE NONLINEAR DAC HERE
    totalmix := 19 * (bool_vec2integer(p1mix) + bool_vec2integer(p2mix)) + 22*bool_vec2integer(trimix) + 13 * bool_vec2integer(noisemix) + 9 * bool_vec2integer(dmcmix);
    mix <= std_logic_vector2bool_vec(std_logic_vector(to_unsigned(totalmix/10, 8)));
  end process; 
END ARCHITECTURE behav;

