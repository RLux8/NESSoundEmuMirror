--
-- VHDL Architecture audiotest_lib.trianglechannel.struct
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 11:09:33 02/08/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;


ARCHITECTURE struct OF trianglechannel IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL length       : boolean_vector(4 DOWNTO 0);
   SIGNAL lengthctren  : boolean;
   SIGNAL linearctrl   : boolean;
   SIGNAL lineariszero : boolean;
   SIGNAL linearreload : boolean;
   SIGNAL mute1        : boolean;
   SIGNAL period       : boolean_vector(10 DOWNTO 0);
   SIGNAL q1           : boolean;
   SIGNAL reloadval    : boolean_vector(6 DOWNTO 0);
   SIGNAL tick         : boolean;
   SIGNAL vol          : boolean_vector(3 DOWNTO 0);
   SIGNAL wrlength     : boolean;

   -- Implicit buffer signal declarations
   SIGNAL iszero_internal : boolean;


   -- Component Declarations
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
   COMPONENT trianglelengthunit
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
   COMPONENT trianglelinearctr
   PORT (
      clk          : IN     std_logic ;
      fclk         : IN     boolean ;
      linearctrl   : IN     boolean ;
      linearreload : IN     boolean ;
      reloadval    : IN     boolean_vector (6 DOWNTO 0);
      res_n        : IN     std_logic ;
      lineariszero : OUT    boolean 
   );
   END COMPONENT;
   COMPONENT triangleseq
   PORT (
      clk          : IN     std_logic ;
      res_n        : IN     std_logic ;
      tick         : IN     boolean ;
      tickdisableA : IN     boolean ;
      tickdisableB : IN     boolean ;
      q            : OUT    boolean_vector (3 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT trianglewriteport
   PORT (
      addr         : IN     boolean_vector (1 DOWNTO 0);
      clk          : IN     std_logic ;
      data         : IN     boolean_vector (7 DOWNTO 0);
      enabled      : IN     boolean ;
      res_n        : IN     std_logic ;
      wr           : IN     boolean ;
      length       : OUT    boolean_vector (4 DOWNTO 0);
      lengthctren  : OUT    boolean ;
      linearctrl   : OUT    boolean ;
      linearreload : OUT    boolean ;
      mute1        : OUT    boolean ;
      period       : OUT    boolean_vector (10 DOWNTO 0);
      reloadval    : OUT    boolean_vector (6 DOWNTO 0);
      wrlength     : OUT    boolean 
   );
   END COMPONENT;
   COMPONENT tritimer
   PORT (
      clk    : IN     std_logic ;
      cpuclk : IN     boolean ;
      period : IN     boolean_vector (10 DOWNTO 0);
      res_n  : IN     std_logic ;
      tick   : OUT    boolean 
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : premixer USE ENTITY audiotest_lib.premixer;
   FOR ALL : trianglelengthunit USE ENTITY audiotest_lib.trianglelengthunit;
   FOR ALL : trianglelinearctr USE ENTITY audiotest_lib.trianglelinearctr;
   FOR ALL : triangleseq USE ENTITY audiotest_lib.triangleseq;
   FOR ALL : trianglewriteport USE ENTITY audiotest_lib.trianglewriteport;
   FOR ALL : tritimer USE ENTITY audiotest_lib.tritimer;
   -- pragma synthesis_on


BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 1 eb1
   -- eb1 1 
   q1 <= true;
                                          


   -- Instance port mappings.
   U_1 : premixer
      PORT MAP (
         mute1  => mute1,
         mute2  => mute1,
         mute3  => mute1,
         q      => q1,
         volume => vol,
         mixed  => mixed
      );
   trilen : trianglelengthunit
      PORT MAP (
         clk         => clk,
         fclk        => fclk,
         length      => length,
         lengthctren => lengthctren,
         res_n       => res_n,
         wrlength    => wrlength,
         iszero      => iszero_internal
      );
   U_0 : trianglelinearctr
      PORT MAP (
         clk          => clk,
         fclk         => fclk,
         linearctrl   => linearctrl,
         linearreload => linearreload,
         reloadval    => reloadval,
         res_n        => res_n,
         lineariszero => lineariszero
      );
   U_2 : triangleseq
      PORT MAP (
         clk          => clk,
         res_n        => res_n,
         tick         => tick,
         tickdisableA => iszero_internal,
         tickdisableB => lineariszero,
         q            => vol
      );
   triWport : trianglewriteport
      PORT MAP (
         addr         => addr,
         clk          => clk,
         data         => data,
         enabled      => enabled,
         res_n        => res_n,
         wr           => wr,
         length       => length,
         lengthctren  => lengthctren,
         linearctrl   => linearctrl,
         linearreload => linearreload,
         mute1        => mute1,
         period       => period,
         reloadval    => reloadval,
         wrlength     => wrlength
      );
   tritim : tritimer
      PORT MAP (
         clk    => clk,
         cpuclk => cpuclk,
         period => period,
         res_n  => res_n,
         tick   => tick
      );

   -- Implicit buffered output assignments
   iszero <= iszero_internal;

END struct;