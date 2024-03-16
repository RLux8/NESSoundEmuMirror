--
-- VHDL Architecture audiotest_lib.boolstdlogicbusconverter.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 10:09:10 02/14/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ENTITY boolstdlogicbusconverter IS
  GENERIC( 
      dataw : positive
  );
  PORT(
    datafrombus : OUT boolean_vector(dataw-1 downto 0);
    datatobus: IN boolean_vector(dataw-1 downto 0);
    databus: INOUT std_logic_vector(dataw-1 downto 0);
    putdataonbus: IN boolean
  );
END ENTITY boolstdlogicbusconverter;

--
ARCHITECTURE behav OF boolstdlogicbusconverter IS
  
BEGIN
  process(all) is
    variable highZ : std_logic_vector(dataw-1 downto 0);
  begin
    for i in highZ'range loop
      highZ(i) := 'Z';
    end loop;
    
    datafrombus <= std_logic_vector2bool_vec(databus);
    
    if putdataonbus then
      databus <= bool_vec2std_logic_vector(datatobus);
    else
      databus <= highZ;
    end if;
  end process;
END ARCHITECTURE behav;

