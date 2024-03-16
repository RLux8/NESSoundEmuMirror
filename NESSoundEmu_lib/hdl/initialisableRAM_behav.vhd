--
-- VHDL Architecture audiotest_lib.initialisableRAM.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 11:14:57 01/29/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all;


ARCHITECTURE behav OF initialisableRAM IS
  type memT is array(0 to (2**addrw)-1) of boolean_vector(dataw-1 downto 0);
  signal memory : memT;
begin
  process(clk, res_n) begin
    if res_n = '0' then
      memory <= (integer2bool_vec(16#00#, 8), integer2bool_vec(16#00#, 8), integer2bool_vec(16#00#, 8), integer2bool_vec(16#00#, 8), integer2bool_vec(16#00#, 8), integer2bool_vec(16#20#, 8), integer2bool_vec(16#00#, 8), integer2bool_vec(16#00#, 8));
    else
      if clk'event and clk = '1' then
        if wr then
          memory(bool_vec2integer(addr)) <= d;
        end if;
      end if;
    end if;
  end process;
  q <= memory(bool_vec2integer(addr));
END ARCHITECTURE behav;

