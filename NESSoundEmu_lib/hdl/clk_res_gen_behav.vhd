--
-- VHDL Architecture audiotest_lib.clk_res_gen.behav
--
-- Created:
--          by - redacted.redacted (pc038)
--          at - 14:30:22 12/13/23
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
architecture behav of clk_res_gen is
begin
osc: process is
begin
clk <= '0';
wait for 10 ns;
clk <= '1';
wait for 10 ns;
end process osc;
reset: process is
begin
res_n <= '0';
wait for 35 ns;
res_n <= '1';
wait;
end process reset;
end architecture behav;

