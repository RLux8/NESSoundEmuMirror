--
-- VHDL Architecture audiotest_lib.dmcmemoryReader.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 12:26:35 01/22/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all;
LIBRARY ieee;
USE IEEE.numeric_std.all;

ARCHITECTURE behav OF dmcmemoryReader IS
BEGIN
  process(clk, res_n) is 
    variable currsampleaddr: natural range 0 to 65535;
    variable remainingbytes: natural range 0 to 4081;   
    variable waitingforreadack: boolean;
    variable gotreadack: boolean;
    variable requestedack: boolean;
    variable lastsampledone: boolean;
    variable playfirstsamplebyte: boolean;
  begin
    if res_n = '0' then
      waitingforreadack := false;
      currsampleaddr := 0;
      lastsampledone := true;
      remainingbytes := 0;
      playfirstsamplebyte := false;
      gotreadack := false;
      requestedack := false;
    else
      if clk'event and clk = '1' then
        if loadcurrentaddrandlen then
            currsampleaddr := 16#C000# + bool_vec2integer(sampleencaddr) * 64;
            remainingbytes := bool_vec2integer(sampleenclength) * 16 + 1;
            playfirstsamplebyte := true;
        end if;
        
        if waitingforreadack and dmcreadack then
          gotreadack := true;
        end if;
        
        if requestedack and not gotreadack then
          dmcreadreq <= true;
        elsif gotreadack then
          dmcreadreq <= false;
        end if;
          
        if cpuclk then
          if enableplayback then
            if loopenable and remainingbytes = 0 then
              currsampleaddr := 16#C000# + bool_vec2integer(sampleencaddr) * 64;
              remainingbytes := bool_vec2integer(sampleenclength) * 16 + 1;
            end if;
            
            
            if remainingbytes /= 0 then
              if gotreadack and waitingforreadack then
                waitingforreadack := false;
                gotreadack := false;
                sample <= dmcdata;
                
                if currsampleaddr /= 16#FFFF# then 
                  currsampleaddr := currsampleaddr + 1;
                else
                  currsampleaddr := 16#8000#;
                end if;

                remainingbytes := remainingbytes - 1;
                playfirstsamplebyte := false;
                playsample <= true;
              else
                playsample <= false;
              end if;
              
              if (sampledone and not lastsampledone) or playfirstsamplebyte then
                dmcaddr <= integer2bool_vec(currsampleaddr, 16);
                requestedack := true;
                waitingforreadack := true;
              else
                requestedack := false;
              end if;
              
            end if;
            lastsampledone := sampledone;
          end if;
        end if;
      end if;
    end if;
    playbackdone <= (remainingbytes = 0); 
  end process;
END ARCHITECTURE behav;



