--
-- VHDL Architecture audiotest_lib.pulselentghunit.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 16:02:58 01/15/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
use ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ARCHITECTURE behav OF pulselentghunit IS
BEGIN
     process(clk, res_n) is
    variable q_int: natural range 0 to 255;
    variable lastfclk: boolean; 
    type initialValueLUTT is array(natural range 0 to 31) of natural;
    constant initialValueLUT : initialValueLUTT := (10,254,20,2,40,4,80,6,160,8,60,10,14,12,26,14,12,16,24,18,48,20,96,22,192,24,72,26,16,28,32,30);
  begin
    if res_n = '0' then
      q_int := 0;
      iszero <= false;
      lastfclk := false;
    else
      if clk'event and clk = '1' then
        -- enabled = 0 forces ctr to zero
        if lengthctren then
          --q_int := 0;
        end if;
        
        -- use LUT to initially fill counter
        if wrlength then
          q_int := initialValueLUT(bool_vec2integer(length)) + INITOFFSET;
        else
          if fclk and lengthctren and not lastfclk then
            if q_int /= 0 then
              q_int := q_int - 1;
            end if;
          end if;
        end if;
        
        lastfclk := fclk;
      end if;
    end if; 
    
    if q_int = 0 then
      iszero <= true;
    else
      iszero <= false;
    end if;
  end process;
END ARCHITECTURE behav;

