--
-- VHDL Architecture audiotest_lib.NoiseLFSR1.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 11:15:32 01/17/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF NoiseLFSR1 IS
BEGIN
  process(clk, res_n) is
    variable shreg: boolean_vector(14 downto 0);
    variable fb: boolean;
  begin
    if res_n = '0' then
      shreg := (0 => true, others => false);
    else
      if clk'event and clk = '1' then
        if tick and cpuclk then
          if usebit6forfb then
            fb := shreg(0) xor shreg(6);
          else
            fb := shreg(0) xor shreg(1);
          end if;
          shreg := fb & shreg(14 downto 1);
        end if;
      end if;
    end if; 
    
    bit0 <= shreg(0);
  end process;
END ARCHITECTURE behav;

