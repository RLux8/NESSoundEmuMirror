--
-- VHDL Architecture audiotest_lib.dmcwriteport.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 13:07:49 01/22/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;


ARCHITECTURE behav OF dmcwriteport IS
BEGIN
   writeport : process(clk, res_n) is
    variable next_loadvalue: boolean;
    variable interruptsenabled: boolean;
    variable next_loadaddrlen: boolean;
    variable interruptactive: boolean;
    variable last_playbackdone: boolean;
  begin
    if res_n = '0' then
      next_loadvalue := false;
      interruptsenabled := false;
      interruptactive := false;
      last_playbackdone := false;
    else
      if clk'event and clk = '1' then
        if playbackdone and not last_playbackdone and interruptsenabled and not interruptactive then
          interruptactive := true;
        end if;
        
        
        
        if clearintflag then
          interruptactive := false;
        end if;
        loadvalue <= next_loadvalue;
        loadcurrentaddrandlen <= next_loadaddrlen;
        
        next_loadvalue := false;
        next_loadaddrlen := false;
        updateperiod <= false;
        if wr then
          addressdecode : case to_integer(unsigned(bool_vec2std_logic_vector(addr))) is
          when 0 =>
            interruptsenabled := data(7);
            interruptactive := data(7);
              
            loopenable <= data(6);
            periodsetting <= data(3 downto 0);
            updateperiod <= true;
          when 1 => 
            loadval <= data(6 downto 0);
            next_loadvalue := true;
          when 2 => 
            sampleencaddr <= data;
            next_loadaddrlen := true;
          when 3 => 
            sampleenclength <= data;
            next_loadaddrlen := true;
          end case addressdecode;
        end if;
        
        last_playbackdone := playbackdone;
      end if;
    end if;
  
  enableplayback <= enabled;
  irq <= interruptactive;
  playingsample <= not playbackdone;
  end process writeport;
END ARCHITECTURE behav;



