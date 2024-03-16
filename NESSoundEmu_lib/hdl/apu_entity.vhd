-- VHDL Entity audiotest_lib.apu.symbol
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 16:10:48 03/08/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library audiotest_lib;
use audiotest_lib.booleanvectors.all;

ENTITY apu IS
   PORT( 
      addr       : IN     boolean_vector (4 DOWNTO 0);
      apuclk     : IN     boolean;
      clk        : IN     std_logic;
      cpuclk     : IN     boolean;
      dmcdata    : IN     boolean_vector (7 DOWNTO 0);
      dmcreadack : IN     boolean;
      rd         : IN     boolean;
      res_n      : IN     std_logic;
      wr         : IN     boolean;
      dmcaddr    : OUT    boolean_vector (15 DOWNTO 0);
      dmcreadreq : OUT    boolean;
      irq        : OUT    boolean;
      mix        : OUT    boolean_vector (7 DOWNTO 0);
      data       : INOUT  std_logic_vector (7 DOWNTO 0)
   );

-- Declarations

END apu ;

