--
-- VHDL Architecture audiotest_lib.noisewriteport.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 14:28:04 01/17/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--

LIBRARY ieee;
USE IEEE.numeric_std.all;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;


ARCHITECTURE behav OF noisewriteport IS
BEGIN
  writeport : process(clk, res_n) is
    variable next_wrlength: boolean;
    variable lengthctrenreg: boolean;
  begin
    if res_n = '0' then
      next_wrlength := false;
      
    else
      if clk'event and clk = '1' then
        wrlength <= next_wrlength;
        
        
        next_wrlength := false;
        
        restartenv <= false;
        
        if wr then
          addressdecode : case bool_vec2integer(addr) is
          when 0 =>
            loopenvelope <= data(5);
            constvol <= data(4);
            lengthctrenreg := not data(5);
            volumeset <= data(3 downto 0);
          when 1 => null;
          when 2 => 
            periodsetting <= data(3 downto 0);
            usebit6forfb <= data(7);
          when 3 => 
            length <= data(7 downto 3);
            next_wrlength := true;
            startenv <= true;
          when others => report "got address ";
          end case addressdecode;
        end if;
      end if;
    end if;
    mute3 <= not enabled;
    lengthctren <= lengthctrenreg and enabled;
  end process writeport;
END ARCHITECTURE behav;



