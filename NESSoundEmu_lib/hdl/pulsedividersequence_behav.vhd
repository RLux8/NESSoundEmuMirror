--
-- VHDL Architecture audiotest_lib.pulsedividersequence.behav
--
-- Created:
--          by - redacted.redacted (pc038)
--          at - 12:58:42 01/15/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ARCHITECTURE behav OF pulsedividersequence IS
    
BEGIN
  process(clk, res_n) is 
    variable pulsetimer: natural range 0 to 2047;
    variable sequencestep: natural range 0 to 7;
    type sequencesLUTT is array(0 to 3) of std_logic_vector(7 downto 0);
    constant sequencesLUT : sequencesLUTT := (
      0 => B"0100_0000",
      1 => B"0110_0000",
      2 => B"0111_1000",
      3 => B"1011_1111"
      );       
  begin
    if res_n = '0' then
      pulsetimer := natural(0);
      sequencestep := natural(7);
    else
      if clk'event and clk = '1' then
        -- usually count down and then reload the value
        if apuclk then
          if pulsetimer /= 0 then
            pulsetimer := pulsetimer - 1;
          else
            pulsetimer := bool_vec2integer(cperiod);
            if sequencestep /= 0 then
              sequencestep := sequencestep - 1;
            else
              sequencestep := 7;
            end if;
          end if;
        end if;
        
        -- forced reload is also possible
        if restartsequence then
          sequencestep := 7;
        end if;
        
      end if;
      
      -- outputs
      if pulsetimer < 8 then
        q <= false;
      else
        if sequencesLUT(bool_vec2integer(pulseduty))(sequencestep) = '1' then
          q <= true;
        else
          q <= false;
        end if;
      end if;
      
      
    end if;
    pulsetimerq <= integer2bool_vec(pulsetimer, pulsetimerq'high+1);
  end process;
end architecture;
