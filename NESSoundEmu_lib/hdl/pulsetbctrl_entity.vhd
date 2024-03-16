-- VHDL Entity audiotest_lib.pulseTBctrl.interface
--
-- Created:
--          by - redacted.redacted (pc038)
--          at - 12:52:30 01/15/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE IEEE.numeric_std.all;

ENTITY pulseTBctrl IS
   PORT( 
      apuclk : IN     boolean;
      clk    : IN     std_logic;
      res_n  : IN     std_logic;
      addr   : OUT    integer RANGE 0 TO 3;
      data   : OUT    boolean_vector (7 DOWNTO 0);
      genint : OUT    boolean;
      mode   : OUT    boolean;
      resctr : OUT    boolean;
      wr     : OUT    boolean
   );

-- Declarations

END pulseTBctrl ;
