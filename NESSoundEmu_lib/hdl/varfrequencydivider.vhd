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
use ieee.math_real.all;

library audiotest_lib; use audiotest_lib.booleanvectors.all;

ENTITY varfrequencydivider IS
  generic(
    MAX : natural
  );
  port(
    clk, res_n : in std_logic;
    tick : in boolean;
    
    period : in boolean_vector(integer(ceil(log2(real(MAX+1))))-1 downto 0);
    enable : in boolean;
		
    tock : out boolean;
    tock_long : out boolean
  );
END varfrequencydivider;

ARCHITECTURE behav OF varfrequencydivider IS
    signal tock_longi: boolean;
BEGIN
  counter : process(clk, res_n) is 
    variable pulsetimer: natural range 0 to MAX;
  begin
    if res_n = '0' then
      pulsetimer := natural(0);
    else
      if clk'event and clk = '1' then
        if enable then
          if tick then
            if pulsetimer /= 0 then
              pulsetimer := pulsetimer - 1;
              tock_longi <= false;
            else
              pulsetimer := bool_vec2integer(period);
              tock_longi <= true;
            end if;
          end if;
        else
          pulsetimer := natural(0);
        end if;
      end if;
    end if;
  end process counter;
  
  shortener : process(clk, res_n) is
    variable supressingtock: boolean;
  begin
  if res_n = '0' then
      supressingtock := false;
    else
      if clk'event and clk = '1' then
        if tock_longi and not supressingtock then
          tock <= true;
          supressingtock := true;
        else
          tock <= false;
        end if;
        
        if not tock_longi then
          supressingtock := false;
        end if;
      end if;
    end if;
  end process shortener;
  
  tock_long <= tock_longi;
end architecture;
