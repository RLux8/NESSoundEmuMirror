-- VHDL Entity audiotest_lib.songRAMwrapper.symbol
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 10:40:31 02/20/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ENTITY songRAMwrapper IS
   PORT( 
      addr : IN     boolean_vector (23 DOWNTO 0);
      clk  : IN     std_logic;
      q    : OUT    boolean_vector (7 DOWNTO 0)
   );

-- Declarations

END songRAMwrapper ;

