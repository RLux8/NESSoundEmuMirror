--
-- VHDL Architecture audiotest_lib.synchroniser.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 09:52:17 03/15/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY synchroniser IS
  --type synctype; HDL designer wont show the type generic in the graphical view?
  generic(
    
    rank : positive
  );
  port(
    clk : in std_logic;
    --unsync : in synctype;
    --synced : out synctype
    unsync : in std_logic_vector(15 downto 0);
    synced : out std_logic_vector(15 downto 0)
  );
END ENTITY synchroniser;

--
ARCHITECTURE behav OF synchroniser IS
BEGIN
  process(clk) is
    subtype synctype is std_logic_vector(15 downto 0);
    type memoryT is array(rank - 1 downto 0) of synctype;
    variable memory: memoryT;
  begin
    synced <= memory(rank - 1);
    for i in memory'range loop
      if i /= 0 then
        memory(i) := memory(i-1);
      end if;
    end loop;
    memory(0) := unsync;
  end process;
END ARCHITECTURE behav;

