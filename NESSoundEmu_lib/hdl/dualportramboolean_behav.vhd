--
-- VHDL Architecture audiotest_lib.dualportramboolean.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 12:25:18 02/15/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ENTITY dualportramboolean IS
  generic (
    dataw: positive;
    addrw: positive
  );
  
  port (
		datain_a : in boolean_vector(dataw-1 downto 0);
		datain_b : in boolean_vector(dataw-1 downto 0);
		wren_a : in boolean;
		wren_b : in boolean;
		clk : in STD_LOGIC;
		addr_a : boolean_vector(addrw-1 downto 0);
		addr_b : boolean_vector(addrw-1 downto 0);
		dataout_a : out boolean_vector(dataw-1 downto 0);
		dataout_b : out boolean_vector(dataw-1 downto 0)
	);
END ENTITY dualportramboolean;

--
ARCHITECTURE behav OF dualportramboolean IS
  type memoryT is array(2**addrw - 1 downto 0) of boolean_vector(dataw-1 downto 0);
BEGIN
  process(clk) is
    variable memory: memoryT;
  begin
    if clk'event and clk = '1' then
      
      if wren_b then
        memory(bool_vec2integer(addr_b)) := datain_b;
      elsif wren_a then
        memory(bool_vec2integer(addr_a)) := datain_a;
      end if;
      dataout_a <= memory(bool_vec2integer(addr_a));
      dataout_b <= memory(bool_vec2integer(addr_b));
    end if;
    
    
  end process;
  
  
END ARCHITECTURE behav;

