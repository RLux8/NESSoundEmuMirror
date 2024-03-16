-- VHDL Entity audiotest_lib.triangleseq.symbol
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 14:35:06 02/02/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ENTITY triangleseq IS
   PORT( 
      clk          : IN     std_logic;
      res_n        : IN     std_logic;
      tick         : IN     boolean;
      tickdisableA : IN     boolean;
      tickdisableB : IN     boolean;
      q            : OUT    boolean_vector (3 DOWNTO 0)
   );

-- Declarations

END triangleseq ;
