-- VHDL Entity audiotest_lib.dmcmemoryReader.interface
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 14:36:04 02/02/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ENTITY dmcmemoryReader IS
   PORT( 
      clk                   : IN     std_logic;
      cpuclk                : IN     boolean;
      dmcdata               : IN     boolean_vector (7 DOWNTO 0);
      dmcreadack            : IN     boolean;
      enableplayback        : IN     boolean;
      halfsampledone        : IN     boolean;
      loadcurrentaddrandlen : IN     boolean;
      loopenable            : IN     boolean;
      res_n                 : IN     std_logic;
      sampledone            : IN     boolean;
      sampleencaddr         : IN     boolean_vector (7 DOWNTO 0);
      sampleenclength       : IN     boolean_vector (7 DOWNTO 0);
      dmcaddr               : OUT    boolean_vector (15 DOWNTO 0);
      dmcreadreq            : OUT    boolean;
      playbackdone          : OUT    boolean;
      playsample            : OUT    boolean;
      sample                : OUT    boolean_vector (7 DOWNTO 0)
   );

-- Declarations

END dmcmemoryReader ;

