-- VHDL Entity audiotest_lib.songRAMwrapperwithwr.symbol
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 15:37:39 02/01/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ENTITY songRAMwrapperwithwr IS
   PORT( 
      addr : IN     boolean_vector (17 DOWNTO 0);
      clk  : IN     std_logic;
      wr   : IN     boolean;
      q    : OUT    boolean_vector (7 DOWNTO 0)
   );

-- Declarations

END songRAMwrapperwithwr ;
