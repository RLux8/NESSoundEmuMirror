-- VHDL Entity audiotest_lib.dmctimer1.generatedInstance
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 16:31:07 01/23/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY dmctimer1 IS
   PORT( 
      clk           : IN     std_logic;
      cpuclk        : IN     boolean;
      periodsetting : IN     boolean_vector (3 DOWNTO 0);
      res_n         : IN     std_logic;
      tick          : OUT    boolean;
      updateperiod  : IN     boolean
   );

END dmctimer1 ;
