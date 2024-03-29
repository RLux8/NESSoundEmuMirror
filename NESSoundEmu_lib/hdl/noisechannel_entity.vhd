-- VHDL Entity audiotest_lib.noisechannel.symbol
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 14:43:06 02/02/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ENTITY noisechannel IS
   PORT( 
      addr      : IN     boolean_vector (1 DOWNTO 0);
      clk       : IN     std_logic;
      cpuclk    : IN     boolean;
      data      : IN     boolean_vector (7 DOWNTO 0);
      enabled   : IN     boolean;
      fclk      : IN     boolean;
      qfclk     : IN     boolean;
      res_n     : IN     std_logic;
      wr        : IN     boolean;
      leniszero : OUT    boolean;
      mixed     : OUT    boolean_vector (3 DOWNTO 0)
   );

-- Declarations

END noisechannel ;

