--
-- VHDL Architecture audiotest_lib.dmcsampleshifter.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 15:27:02 01/17/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ARCHITECTURE behav OF dmcsampleshifter IS
BEGIN
  process(clk, res_n) is 
    variable remainingbits: natural range 0 to 8;
    variable bitindex: natural range 0 to 8;
    variable samplebuf: boolean_byte;
    variable gotsample: boolean; 
  begin
    if res_n = '0' then
     remainingbits := 0;
     samplebuf := (others => false);
    else
      if clk'event and clk = '1' then
        if cpuclk then
          if playsample then
            remainingbits := 8;
            samplebuf := sample;
          end if;
          
          if tick then
            if remainingbits /= 0 then
              if reversesamplebyte then
                bitindex := remainingbits - 1;
              else 
                bitindex := 8 - remainingbits;
              end if;
            
              if samplebuf(bitindex) then
                incLevel <= true;
              else
                decLevel <= true;
              end if;
              remainingbits := remainingbits - 1;
            end if;
          else
            incLevel <= false;
            decLevel <= false;
          end if;
        end if;
      end if;
    end if;
    sampledone <= (remainingbits = 0);
    halfsampledone <= (remainingbits < 5);
  end process;
  
END ARCHITECTURE behav;

