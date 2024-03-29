--
-- VHDL Architecture audiotest_lib.noisechannel.struct
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


ARCHITECTURE struct OF noisechannel IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL bit0          : boolean;
   SIGNAL constvol      : boolean;
   SIGNAL length        : boolean_vector(4 DOWNTO 0);
   SIGNAL lengthctren   : boolean;
   SIGNAL loopenvelope  : boolean;
   SIGNAL mute3         : boolean;
   SIGNAL periodsetting : boolean_vector(3 DOWNTO 0);
   SIGNAL restartenv    : boolean;
   SIGNAL startenv      : boolean;
   SIGNAL tick          : boolean;
   SIGNAL usebit6forfb  : boolean;
   SIGNAL volume        : boolean_vector(3 DOWNTO 0);
   SIGNAL volumeset     : boolean_vector(3 DOWNTO 0);
   SIGNAL wrlength      : boolean;

   -- Implicit buffer signal declarations
   SIGNAL leniszero_internal : boolean;


   -- Component Declarations
   COMPONENT NoiseLFSR1
   PORT (
      clk          : IN     std_logic ;
      cpuclk       : IN     boolean ;
      res_n        : IN     std_logic ;
      tick         : IN     boolean ;
      usebit6forfb : IN     boolean ;
      bit0         : OUT    boolean 
   );
   END COMPONENT;
   COMPONENT noisetimer
   PORT (
      clk           : IN     std_logic ;
      cpuclk        : IN     boolean ;
      periodsetting : IN     boolean_vector (3 DOWNTO 0);
      res_n         : IN     std_logic ;
      tick          : OUT    boolean 
   );
   END COMPONENT;
   COMPONENT noisewriteport
   PORT (
      addr          : IN     boolean_vector (1 DOWNTO 0);
      clk           : IN     std_logic ;
      data          : IN     boolean_vector (7 DOWNTO 0);
      enabled       : IN     boolean ;
      res_n         : IN     std_logic ;
      wr            : IN     boolean ;
      constvol      : OUT    boolean ;
      length        : OUT    boolean_vector (4 DOWNTO 0);
      lengthctren   : OUT    boolean ;
      loopenvelope  : OUT    boolean ;
      mute3         : OUT    boolean ;
      periodsetting : OUT    boolean_vector (3 DOWNTO 0);
      restartenv    : OUT    boolean ;
      startenv      : OUT    boolean ;
      usebit6forfb  : OUT    boolean ;
      volumeset     : OUT    boolean_vector (3 DOWNTO 0);
      wrlength      : OUT    boolean 
   );
   END COMPONENT;
   COMPONENT premixer
   PORT (
      mute1  : IN     boolean ;
      mute2  : IN     boolean ;
      mute3  : IN     boolean ;
      q      : IN     boolean ;
      volume : IN     boolean_vector (3 DOWNTO 0);
      mixed  : OUT    boolean_vector (3 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT pulseenv
   PORT (
      clk          : IN     std_logic ;
      constvol     : IN     boolean ;
      loopenvelope : IN     boolean ;
      qfclk        : IN     boolean ;
      res_n        : IN     std_logic ;
      restartenv   : IN     boolean ;
      startenv     : IN     boolean ;
      volumeset    : IN     boolean_vector (3 DOWNTO 0);
      volume       : OUT    boolean_vector (3 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT pulselentghunit
   GENERIC (
      INITOFFSET : integer := 0
   );
   PORT (
      clk         : IN     std_logic ;
      fclk        : IN     boolean ;
      length      : IN     boolean_vector (4 DOWNTO 0);
      lengthctren : IN     boolean ;
      res_n       : IN     std_logic ;
      wrlength    : IN     boolean ;
      iszero      : OUT    boolean 
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : NoiseLFSR1 USE ENTITY audiotest_lib.NoiseLFSR1;
   FOR ALL : noisetimer USE ENTITY audiotest_lib.noisetimer;
   FOR ALL : noisewriteport USE ENTITY audiotest_lib.noisewriteport;
   FOR ALL : premixer USE ENTITY audiotest_lib.premixer;
   FOR ALL : pulseenv USE ENTITY audiotest_lib.pulseenv;
   FOR ALL : pulselentghunit USE ENTITY audiotest_lib.pulselentghunit;
   -- pragma synthesis_on


BEGIN

   -- Instance port mappings.
   nlfsr : NoiseLFSR1
      PORT MAP (
         clk          => clk,
         cpuclk       => cpuclk,
         res_n        => res_n,
         tick         => tick,
         usebit6forfb => usebit6forfb,
         bit0         => bit0
      );
   ntimer : noisetimer
      PORT MAP (
         clk           => clk,
         cpuclk        => cpuclk,
         periodsetting => periodsetting,
         res_n         => res_n,
         tick          => tick
      );
   nwport : noisewriteport
      PORT MAP (
         addr          => addr,
         clk           => clk,
         data          => data,
         enabled       => enabled,
         res_n         => res_n,
         wr            => wr,
         constvol      => constvol,
         length        => length,
         lengthctren   => lengthctren,
         loopenvelope  => loopenvelope,
         mute3         => mute3,
         periodsetting => periodsetting,
         restartenv    => restartenv,
         startenv      => startenv,
         usebit6forfb  => usebit6forfb,
         volumeset     => volumeset,
         wrlength      => wrlength
      );
   U_0 : premixer
      PORT MAP (
         mute1  => leniszero_internal,
         mute2  => leniszero_internal,
         mute3  => mute3,
         q      => bit0,
         volume => volume,
         mixed  => mixed
      );
   puenv : pulseenv
      PORT MAP (
         clk          => clk,
         constvol     => constvol,
         loopenvelope => loopenvelope,
         qfclk        => qfclk,
         res_n        => res_n,
         restartenv   => restartenv,
         startenv     => startenv,
         volumeset    => volumeset,
         volume       => volume
      );
   U_3 : pulselentghunit
      PORT MAP (
         clk         => clk,
         fclk        => fclk,
         length      => length,
         lengthctren => lengthctren,
         res_n       => res_n,
         wrlength    => wrlength,
         iszero      => leniszero_internal
      );

   -- Implicit buffered output assignments
   leniszero <= leniszero_internal;

END struct;
