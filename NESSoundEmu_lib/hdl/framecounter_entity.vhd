-- VHDL Entity audiotest_lib.framecounter.symbol
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 14:04:34 01/25/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY framecounter IS
   PORT( 
      apuclk       : IN     boolean;
      clearintflag : IN     boolean;
      clk          : IN     std_logic;
      genint       : IN     boolean;
      mode         : IN     boolean;
      res_n        : IN     std_logic;
      resctr       : IN     boolean;
      fclk         : OUT    boolean;
      frameint     : OUT    boolean;
      hfclk        : OUT    boolean;
      qfclk        : OUT    boolean
   );

-- Declarations

END framecounter ;
