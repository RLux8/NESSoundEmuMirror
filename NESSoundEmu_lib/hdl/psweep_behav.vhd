--
-- VHDL Architecture audiotest_lib.psweep.behav
--
-- Created:
--          by - redacted.redacted (pc038)
--          at - 13:01:45 01/15/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
use ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;


ARCHITECTURE behav OF psweep IS
  constant periodssize: natural := 2**11;
  signal unitenabled: boolean;
  signal periodshifted_arch_int: integer range 0 to periodssize - 1;
  signal updateperiod: boolean;
  signal muting: boolean;
  signal cperiod_arch: boolean_vector(10 downto 0);
   
BEGIN

  periodclk : process(clk, res_n) is 
    variable hfclkctr: integer range 0 to 7; 
    variable updateperiod_int: boolean;
    variable lastreload: boolean;
    variable lasthfclk: boolean;
  begin
    if res_n = '0' then
      hfclkctr := 0;
      lasthfclk := false;
    else
      if clk'event and clk = '1' then
        if updateperiod_int then
          updateperiod_int := false;
        end if;
        
        if hfclk and not lasthfclk then
          if hfclkctr = 0 and sweepen and not muting then
            updateperiod_int := true;
          end if;
          
          if hfclkctr = 0 or (sweepreload and not lastreload) then
            hfclkctr := bool_vec2integer(sweeptickperiod);
          else   
            hfclkctr := hfclkctr - 1;
          end if;
          
          
          
          lastreload := sweepreload;
        end if;
        
        lasthfclk := hfclk;
      end if;
      
    end if;
    updateperiod <= updateperiod_int;
  end process periodclk;
  
  periodshifter : process(cperiod_arch, sweepshcnt, sweepnegate, sweepen) is 
    variable newperiod_int: integer range 0 to periodssize - 1;
    variable periodshifted: integer range 0 to periodssize - 1;
    variable newperiodtoolarge: boolean;
  begin
      
    periodshifted := bool_vec2integer(cperiod_arch srl bool_vec2integer(sweepshcnt));
    if sweepnegate then
      if bool_vec2integer(cperiod_arch) > periodshifted + SUBOFFSET then
        newperiod_int := bool_vec2integer(cperiod_arch) - periodshifted - SUBOFFSET;
      else 
        newperiod_int := 0;
      end if;
      
    else
      if bool_vec2integer(cperiod_arch) + periodshifted > periodssize then
        newperiod_int := (bool_vec2integer(cperiod_arch) + periodshifted) mod periodssize;
        newperiodtoolarge := true;
      else
        newperiod_int := bool_vec2integer(cperiod_arch) + periodshifted;
        newperiodtoolarge := false;
      end if;
    end if;
    
    
    unitenabled <= sweepen and (bool_vec2integer(sweepshcnt) /= 0);
    muting <= (unsigned(bool_vec2std_logic_vector(cperiod_arch)) < 8 or newperiodtoolarge);
    periodshifted_arch_int <= newperiod_int;
  end process periodshifter;
  
  mutingMix <= muting;
  periodmem : process(clk, res_n) is
    variable period_int: integer range 0 to periodssize-1;
  begin
    if res_n = '0' then
      period_int := 0;
    else
      if clk'event and clk = '1' then
        if loadperiod then
          period_int := bool_vec2integer(period);
        elsif updateperiod and unitenabled then
          period_int := periodshifted_arch_int;
        end if;
      end if;
    end if;
    cperiod_arch <= integer2bool_vec(period_int, cperiod_arch'high+1);
    
  end process periodmem;
  cperiod <= cperiod_arch;
END ARCHITECTURE behav;

