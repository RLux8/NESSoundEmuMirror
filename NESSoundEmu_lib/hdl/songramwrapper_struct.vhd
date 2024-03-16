--
-- VHDL Architecture audiotest_lib.songRAMwrapper.struct
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 10:47:45 02/20/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;


ARCHITECTURE struct OF songRAMwrapper IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL address    : STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL qw         : STD_LOGIC_VECTOR(63 DOWNTO 0);
   SIGNAL zero1wide  : STD_LOGIC;
   SIGNAL zero64wide : STD_LOGIC_VECTOR(63 DOWNTO 0);


   -- Component Declarations
   COMPONENT bytemux1
   PORT (
      addr    : IN     boolean_vector (23 DOWNTO 0);
      qw      : IN     STD_LOGIC_VECTOR (63 DOWNTO 0);
      address : OUT    STD_LOGIC_VECTOR (15 DOWNTO 0);
      q       : OUT    boolean_vector (7 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT quartusNESsongRAM
   PORT (
      address : IN     STD_LOGIC_VECTOR (15 DOWNTO 0);
      clock   : IN     STD_LOGIC  := '1';
      data    : IN     STD_LOGIC_VECTOR (63 DOWNTO 0);
      wren    : IN     STD_LOGIC;
      q       : OUT    STD_LOGIC_VECTOR (63 DOWNTO 0)
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : bytemux1 USE ENTITY audiotest_lib.bytemux1;
   FOR ALL : quartusNESsongRAM USE ENTITY audiotest_lib.quartusNESsongRAM;
   -- pragma synthesis_on


BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 2 eb2
   -- eb1 1  
   zero64wide <= (others => '0');
   zero1wide <= '0';                                      


   -- Instance port mappings.
   U_1 : bytemux1
      PORT MAP (
         addr    => addr,
         qw      => qw,
         address => address,
         q       => q
      );
   U_0 : quartusNESsongRAM
      PORT MAP (
         address => address,
         clock   => clk,
         data    => zero64wide,
         wren    => zero1wide,
         q       => qw
      );

END struct;
