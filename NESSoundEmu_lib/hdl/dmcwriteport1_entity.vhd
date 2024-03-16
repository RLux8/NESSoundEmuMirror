-- VHDL Entity audiotest_lib.dmcwriteport1.generatedInstance
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 16:31:07 01/23/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY dmcwriteport1 IS
   PORT( 
      addr                  : IN     boolean_vector (1 DOWNTO 0);
      clearintflag          : IN     boolean;
      clk                   : IN     std_logic;
      data                  : IN     boolean_vector (7 DOWNTO 0);
      enabled               : IN     boolean;
      enableplayback        : OUT    boolean;
      irq                   : OUT    boolean;
      loadcurrentaddrandlen : OUT    boolean;
      loadval               : OUT    boolean_vector (6 DOWNTO 0);
      loadvalue             : OUT    boolean;
      loopenable            : OUT    boolean;
      periodsetting         : OUT    boolean_vector (3 DOWNTO 0);
      playbackdone          : IN     boolean;
      playingsample         : OUT    boolean;
      res_n                 : IN     std_logic;
      sampleencaddr         : OUT    boolean_vector (7 DOWNTO 0);
      sampleenclength       : OUT    boolean_vector (7 DOWNTO 0);
      updateperiod          : OUT    boolean;
      wr                    : IN     boolean
   );

END dmcwriteport1 ;

