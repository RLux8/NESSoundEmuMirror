-- VHDL Entity audiotest_lib.tritimer.interface
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 14:34:32 02/02/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ENTITY tritimer IS
   PORT( 
      clk    : IN     std_logic;
      cpuclk : IN     boolean;
      period : IN     boolean_vector (10 DOWNTO 0);
      res_n  : IN     std_logic;
      tick   : OUT    boolean
   );

-- Declarations

END tritimer ;

