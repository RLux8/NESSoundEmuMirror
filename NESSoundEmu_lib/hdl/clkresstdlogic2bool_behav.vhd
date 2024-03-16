--
-- VHDL Architecture audiotest_lib.clkresstdlogic2bool.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 13:15:03 01/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF clkresstdlogic2bool IS
BEGIN
  process(all) is 
  begin
    clk <= clkstdlog = '1';
    res_n <= resnstdlog = '1';
  end process;
END ARCHITECTURE behav;

