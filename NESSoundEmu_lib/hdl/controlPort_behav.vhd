--
-- VHDL Architecture audiotest_lib.controlPort.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 12:43:41 02/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all;


ARCHITECTURE behav OF controlPort IS
BEGIN
  process(resetCPU, res_n, cpuclk, runCPU) is
  begin
    tickCPU <=  cpuclk and runCPU;
    if res_n = '0' or resetCPU = true then
      cpuRES <= '1';
    else
      cpuRES <= '0';
    end if;
  end process;
  
  
  statusregisterwr : process(clk, res_n) is
  begin
    if res_n = '0' then
      status <= (others => false);
    else
      if clk'event and clk = '1' then
        if controlportwr then
          status <= std_logic_vector2bool_vec(data);
        end if;
      end if;
    end if;
    
  end process statusregisterwr;  
  
  data <= bool_vec2std_logic_vector(selectedSong) when controlportrd else "ZZZZZZZZ";
END ARCHITECTURE behav;

