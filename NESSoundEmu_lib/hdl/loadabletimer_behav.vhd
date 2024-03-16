--
-- VHDL Architecture audiotest_lib.loadabletimer.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 11:18:51 02/14/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ENTITY loadabletimer IS
  GENERIC( 
      maxval: positive;
      requiredAddressbits : positive
  );
  
  PORT(
    clk, res_n: IN std_logic;
    tickclk: IN std_logic;
    data: IN std_logic_vector(7 downto 0);
    addr: IN boolean_vector(requiredAddressbits-1 downto 0);
    wr: IN boolean;
    
    tick: OUT boolean;
    timerrunout: OUT boolean
  );
  
  --constant requiredBits : positive := integer(ceil(log2(real(maxval))));
  --constant requiredAdressspace : positive := integer(ceil(log2(real(maxval)) / 8)) + 1;
  --constant requiredAddressbits : positive := integer(ceil(log2(real(requiredAdressspace))));
END ENTITY loadabletimer;

ARCHITECTURE behav OF loadabletimer IS
  constant requiredBits : natural := integer(ceil(log2(real(maxval))));
  
  signal timeriszero: boolean;
  signal reloadvalue: boolean_vector(requiredBits-1 downto 0);
  signal reload : boolean;
  signal running : boolean;
BEGIN
  controlport : process(clk, res_n) is
    variable autoreload: boolean;
    variable supressingtick: boolean;
    variable waitingforcounterreloaded: boolean;
    
    variable tick_int: boolean;
  begin
    if res_n = '0' then
      reloadvalue <= (2 => true, others => false);
      reload <= false;
      waitingforcounterreloaded := false;
      supressingtick := true; -- hack to suppress initial tick blip
      timerrunout <= false;
    else
      if clk'event and clk = '1' then
        
        if tick_int then
          timerrunout <= true;
        end if;
        
        if timeriszero then
          if not supressingtick then
            supressingtick := true;
            tick_int := true;
          else
            tick_int := false;
          end if;
          reload <= autoreload;  
          waitingforcounterreloaded := true;  
        else
          supressingtick := false;
          if waitingforcounterreloaded then
            waitingforcounterreloaded := false;
            reload <= false;
          end if;
        end if;
        
        if wr then
          if bool_vec2integer(addr) = 0 then
            autoreload := (data(0) = '1');
            running <= data(1) = '1';
            timerrunout <= false;
          else
            reloadvalue(bool_vec2integer(addr)*8-1 downto (bool_vec2integer(addr)-1)*8) <= std_logic_vector2bool_vec(data);
          end if;
          
          
          -- reload timer when writing to LSB
          if bool_vec2integer(addr) = 1 then
            reload <= true;
          end if;
        end if;
      end if;
    end if;
    
    tick <= tick_int;
  end process controlport;
  
  
  counter : process(tickclk, res_n) is
    variable currentcounter: integer range maxval downto 0;
  begin
    if res_n = '0' then
      currentcounter := 0;
    else
      if tickclk'event and tickclk = '1' then
        if currentcounter /= 0 and running then
          currentcounter := currentcounter - 1;
        else
          if reload then
            currentcounter := bool_vec2integer(reloadvalue);
          end if;
        end if;
      end if;
    end if;
    
    timeriszero <= currentcounter = 0;
  end process;
END ARCHITECTURE behav;

