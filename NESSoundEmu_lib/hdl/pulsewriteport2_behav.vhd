--
-- VHDL Architecture audiotest_lib.pulsewriteport2.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 14:55:48 01/10/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;


ARCHITECTURE behav OF pulsewriteport2 IS
  signal startenv_int: boolean;
BEGIN
   writeport : process(clk, res_n) is
    variable next_wrlength: boolean;
    variable next_loadperiod: boolean;
    variable next_startenv: boolean;
    variable loopenv_int: boolean;
  begin
    if res_n = '0' then
      next_wrlength := false;
      next_loadperiod := false;
      next_startenv := false;
      sweepreload  <= false;
      loadperiod <= false;
    else
      if clk'event and clk = '1' then
        wrlength <= next_wrlength;
        loadperiod <= next_loadperiod;
        restartsequence <= false;
        startenv_int <= next_startenv;
        restartenv <= false;
        
        next_wrlength := false;
        next_loadperiod := false;
        next_startenv := false;
        loadperiod <= false;
        if wr then
          addressdecode : case bool_vec2integer(addr) is
          when 0 =>
            pulseduty <= data(7 downto 6);
            loopenv_int := data(5);
            constvol <= data(4);
            volumeset <= data(3 downto 0);
            restartenv <= true;
          when 1 => 
            sweepen <= data(7);
            sweeptickperiod <= data(6 downto 4);
            sweepnegate <= data(3);
            sweepshcnt <= data(2 downto 0);
          when 2 => 
            period(7 downto 0) <= data;
            loadperiod <= true;
          when 3 => 
            period(10 downto 8) <= data(2 downto 0);
            loadperiod <= true;
            length <= data(7 downto 3);
            next_wrlength := true;
            next_loadperiod := true;
            restartsequence <= true;
            next_startenv := true;
          when others => report "got address ";
          end case addressdecode;
        end if;
      end if;
    end if;
    loopenvelope <= loopenv_int;
    startenv <= startenv_int;
    restartenv <= startenv_int;
    lengthctren <= not loopenv_int and enabled;
    mute3 <= not enabled;
  end process writeport;
END ARCHITECTURE behav;

