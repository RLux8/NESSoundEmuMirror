-- VHDL Entity audiotest_lib.noisewriteport.interface
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 14:17:02 02/02/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ENTITY noisewriteport IS
   PORT( 
      addr          : IN     boolean_vector (1 DOWNTO 0);
      clk           : IN     std_logic;
      data          : IN     boolean_vector (7 DOWNTO 0);
      enabled       : IN     boolean;
      res_n         : IN     std_logic;
      wr            : IN     boolean;
      constvol      : OUT    boolean;
      length        : OUT    boolean_vector (4 DOWNTO 0);
      lengthctren   : OUT    boolean;
      loopenvelope  : OUT    boolean;
      mute3         : OUT    boolean;
      periodsetting : OUT    boolean_vector (3 DOWNTO 0);
      restartenv    : OUT    boolean;
      startenv      : OUT    boolean;
      usebit6forfb  : OUT    boolean;
      volumeset     : OUT    boolean_vector (3 DOWNTO 0);
      wrlength      : OUT    boolean
   );

-- Declarations

END noisewriteport ;
