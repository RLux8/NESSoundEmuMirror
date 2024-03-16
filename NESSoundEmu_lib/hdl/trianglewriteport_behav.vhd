--
-- VHDL Architecture audiotest_lib.trianglewriteport.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 13:12:08 01/16/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ARCHITECTURE behav OF trianglewriteport IS
BEGIN
  writeport : process(clk, res_n) is
    variable next_wrlength: boolean;
    variable lengthctrenreg: boolean;
  begin
    if res_n = '0' then
      next_wrlength := false;
      lengthctrenreg := false;
      period <= (others => false);
    else
      if clk'event and clk = '1' then
        wrlength <= next_wrlength;
        
        
        next_wrlength := false;
        
        linearreload <= false;
        
        if wr then
          addressdecode : case bool_vec2integer(addr) is
          when 0 =>
            reloadval <= data(6 downto 0);
            linearctrl <= data(7);
            lengthctrenreg := not data(7);
          when 1 => null;
          when 2 => 
            period(7 downto 0) <= data;
          when 3 => 
            period(10 downto 8) <= data(2 downto 0);
            length <= data(7 downto 3);
            next_wrlength := true;
            linearreload <= true;
          when others => report "got address ";
          end case addressdecode;
        end if;
      end if;
    end if;
    mute1 <= not enabled;
    lengthctren <= lengthctrenreg and enabled;
  end process writeport;
END ARCHITECTURE behav;

