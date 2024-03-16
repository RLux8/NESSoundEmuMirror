-- VHDL Entity audiotest_lib.lengthCtr.symbol
--
-- Created:
--          by - redacted.redacted (pc038)
--          at - 12:43:54 12/12/23
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY lengthCtr IS
   GENERIC( 
      INITOFFSET : unsigned := 0
   );
   PORT( 
      clk     : IN     std_logic;
      enabled : IN     std_logic;
      l       : IN     std_logic_vector (4 DOWNTO 0);
      res_n   : IN     std_logic;
      tick    : IN     std_logic;
      wr      : IN     std_logic;
      iszero  : OUT    std_logic
   );

-- Declarations

END lengthCtr ;
