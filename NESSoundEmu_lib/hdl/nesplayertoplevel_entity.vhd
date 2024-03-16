-- VHDL Entity audiotest_lib.NESPlayertoplevel.symbol
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 10:16:39 03/15/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY NESPlayertoplevel IS
   PORT( 
      clk              : IN     std_logic;
      res_n            : IN     std_logic;
      selectedSongsstd : IN     std_logic_vector (7 DOWNTO 0);
      SSM2603_bclk     : OUT    STD_LOGIC;
      SSM2603_cclk     : OUT    STD_LOGIC;
      SSM2603_pbdat    : OUT    STD_LOGIC;
      SSM2603_pblrc    : OUT    STD_LOGIC;
      ack_error        : OUT    STD_LOGIC;
      cpurunstd        : OUT    std_logic;
      statusstd        : OUT    std_logic_vector (7 DOWNTO 0);
      SSM2603_scl      : INOUT  STD_LOGIC;
      SSM2603_sda      : INOUT  STD_LOGIC
   );

-- Declarations

END NESPlayertoplevel ;

