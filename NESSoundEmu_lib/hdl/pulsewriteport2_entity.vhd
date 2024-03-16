-- VHDL Entity audiotest_lib.pulsewriteport2.interface
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 14:20:13 02/02/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
--USE IEEE.numeric_std.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ENTITY pulsewriteport2 IS
   PORT( 
      addr            : IN     boolean_vector (1 DOWNTO 0);
      clk             : IN     std_logic;
      data            : IN     boolean_vector (7 DOWNTO 0);
      enabled         : IN     boolean;
      res_n           : IN     std_logic;
      wr              : IN     boolean;
      constvol        : OUT    boolean;
      length          : OUT    boolean_vector (4 DOWNTO 0);
      lengthctren     : OUT    boolean;
      loadperiod      : OUT    boolean;
      loopenvelope    : OUT    boolean;
      mute3           : OUT    boolean;
      period          : OUT    boolean_vector (10 DOWNTO 0);
      pulseduty       : OUT    boolean_vector (1 DOWNTO 0);
      restartenv      : OUT    boolean;
      restartsequence : OUT    boolean;
      startenv        : OUT    boolean;
      sweepen         : OUT    boolean;
      sweepnegate     : OUT    boolean;
      sweepreload     : OUT    boolean;
      sweepshcnt      : OUT    boolean_vector (2 DOWNTO 0);
      sweeptickperiod : OUT    boolean_vector (2 DOWNTO 0);
      volumeset       : OUT    boolean_vector (3 DOWNTO 0);
      wrlength        : OUT    boolean
   );

-- Declarations

END pulsewriteport2 ;
