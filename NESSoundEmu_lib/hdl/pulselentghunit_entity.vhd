-- VHDL Entity audiotest_lib.pulselentghunit.symbol
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 14:19:07 02/02/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
--USE IEEE.numeric_std.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ENTITY pulselentghunit IS
   GENERIC( 
      INITOFFSET : integer := 0
   );
   PORT( 
      clk         : IN     std_logic;
      fclk        : IN     boolean;
      length      : IN     boolean_vector (4 DOWNTO 0);
      lengthctren : IN     boolean;
      res_n       : IN     std_logic;
      wrlength    : IN     boolean;
      iszero      : OUT    boolean
   );

-- Declarations

END pulselentghunit ;
