--
-- VHDL Architecture audiotest_lib.namco163tb.struct
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 11:09:20 02/19/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE IEEE.numeric_std.all;

LIBRARY audiotest_lib;

ARCHITECTURE struct OF namco163tb IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL addr   : boolean_vector(1 DOWNTO 0);
   SIGNAL clk    : std_logic;
   SIGNAL cpuclk : boolean;
   SIGNAL data   : std_logic_vector(7 DOWNTO 0);
   SIGNAL rd     : boolean;
   SIGNAL res_n  : std_logic;
   SIGNAL tick   : boolean;
   SIGNAL wr     : boolean;


   -- Component Declarations
   COMPONENT clk_res_gen_var
   GENERIC (
      ONTIME    : time := 10 ns;
      OFFTIME   : time := 10 ns;
      RESETTIME : time := 35 ns
   );
   PORT (
      clk   : OUT    std_logic ;
      res_n : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT namco163
   GENERIC (
      USETDM : boolean := true
   );
   PORT (
      addr    : IN     boolean_vector (1 DOWNTO 0);
      clk     : IN     std_logic ;
      cpuclk  : IN     boolean ;
      rd      : IN     boolean ;
      res_n   : IN     std_logic ;
      wr      : IN     boolean ;
      n163mix : OUT    boolean_vector (7 DOWNTO 0);
      data    : INOUT  std_logic_vector (7 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT namco163tbctrl
   PORT (
      clk   : IN     std_logic ;
      res_n : IN     std_logic ;
      tick  : IN     boolean ;
      addr  : OUT    boolean_vector (1 DOWNTO 0);
      rd    : OUT    boolean ;
      wr    : OUT    boolean ;
      data  : INOUT  std_logic_vector (7 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT taktteilerboolean
   GENERIC (
      MAX : integer := 8
   );
   PORT (
      clk   : IN     std_logic ;
      res_n : IN     std_logic ;
      tick  : OUT    boolean 
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : clk_res_gen_var USE ENTITY audiotest_lib.clk_res_gen_var;
   FOR ALL : namco163 USE ENTITY audiotest_lib.namco163;
   FOR ALL : namco163tbctrl USE ENTITY audiotest_lib.namco163tbctrl;
   FOR ALL : taktteilerboolean USE ENTITY audiotest_lib.taktteilerboolean;
   -- pragma synthesis_on


BEGIN

   -- Instance port mappings.
   U_1 : clk_res_gen_var
      GENERIC MAP (
         ONTIME    => 37.6 ns,
         OFFTIME   => 37.6 ns,
         RESETTIME => 35 ns
      )
      PORT MAP (
         clk   => clk,
         res_n => res_n
      );
   U_0 : namco163
      GENERIC MAP (
         USETDM => true
      )
      PORT MAP (
         addr    => addr,
         clk     => clk,
         cpuclk  => cpuclk,
         rd      => rd,
         res_n   => res_n,
         wr      => wr,
         n163mix => OPEN,
         data    => data
      );
   n163tbctrl : namco163tbctrl
      PORT MAP (
         clk   => clk,
         res_n => res_n,
         tick  => tick,
         addr  => addr,
         rd    => rd,
         wr    => wr,
         data  => data
      );
   U_2 : taktteilerboolean
      GENERIC MAP (
         MAX => 8
      )
      PORT MAP (
         clk   => clk,
         res_n => res_n,
         tick  => cpuclk
      );
   U_3 : taktteilerboolean
      GENERIC MAP (
         MAX => 16
      )
      PORT MAP (
         clk   => clk,
         res_n => res_n,
         tick  => tick
      );

END struct;
