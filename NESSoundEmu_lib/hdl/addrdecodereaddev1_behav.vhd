--
-- VHDL Architecture audiotest_lib.addrdecodereaddev1.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 12:59:25 02/05/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ARCHITECTURE behav OF addrdecodereaddev IS
begin
  process(all) is
  begin
    apurd <= false;
    controlportrd <= false;
    memrd <= false;
    n163rd <= false;
    vrc6rd <= false;
    case bool_vec2integer(addr) is
      -- apu address space
      when 16#4000# to 16#4017# => 
        apurd <= rd;
      
      when 16#4040# =>
        controlportrd <= rd;
        
      when 16#4800# => 
        n163rd <= rd;
        
      when others => memrd <= rd;
    end case;
  end process;
END ARCHITECTURE behav;

