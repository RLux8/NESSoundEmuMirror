--
-- VHDL Architecture audiotest_lib.NESPlayertoplevel.struct
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 10:16:39 03/15/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.all;


ARCHITECTURE struct OF NESPlayertoplevel IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL I2Cstarttransfer : STD_LOGIC;
   SIGNAL addr             : std_logic_vector(6 DOWNTO 0);
   SIGNAL busy             : STD_LOGIC;
   SIGNAL clk1M            : std_logic;
   SIGNAL cpuclkx8         : std_logic;
   SIGNAL data_wr          : std_logic_vector(7 DOWNTO 0);
   SIGNAL ena              : std_logic;
   SIGNAL error            : std_logic;
   SIGNAL l_data_tx        : std_logic_vector(15 DOWNTO 0);
   SIGNAL leftadcvol       : STD_LOGIC_VECTOR(5 DOWNTO 0);
   SIGNAL leftdacvol       : STD_LOGIC_VECTOR(6 DOWNTO 0);
   SIGNAL mix              : boolean_vector(11 DOWNTO 0);
   SIGNAL r_data_tx        : STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL ready            : STD_LOGIC;
   SIGNAL regaddr          : std_logic_vector(6 DOWNTO 0);
   SIGNAL regdata          : std_logic_vector(8 DOWNTO 0);
   SIGNAL res              : std_logic := '0';
   SIGNAL resetCPU         : boolean;
   SIGNAL rightadcvol      : STD_LOGIC_VECTOR(5 DOWNTO 0);
   SIGNAL rightdacvol      : STD_LOGIC_VECTOR(6 DOWNTO 0);
   SIGNAL runCPU           : boolean;
   SIGNAL rw1              : STD_LOGIC;
   SIGNAL sd_rx            : STD_LOGIC;
   SIGNAL selectedSong     : boolean_vector(7 DOWNTO 0);
   SIGNAL status           : boolean_vector(7 DOWNTO 0);
   SIGNAL syncedl          : std_logic_vector(15 DOWNTO 0);
   SIGNAL syncedr          : std_logic_vector(15 DOWNTO 0);
   SIGNAL update           : STD_LOGIC;
   SIGNAL writedone        : std_logic;

   -- Implicit buffer signal declarations
   SIGNAL SSM2603_cclk_internal : STD_LOGIC;
   SIGNAL ack_error_internal    : STD_LOGIC;


   -- Component Declarations
   COMPONENT PLL50M_to_12M_13_3M_14_3M
   PORT (
      refclk   : IN     std_logic  := '0';
      rst      : IN     std_logic  := '0';
      outclk_0 : OUT    std_logic;
      outclk_1 : OUT    std_logic;
      outclk_2 : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT SSM2603regwriter
   PORT (
      I2Cbusy   : IN     std_logic ;
      clk       : IN     std_logic ;
      regaddr   : IN     std_logic_vector (6 DOWNTO 0);
      regdata   : IN     std_logic_vector (8 DOWNTO 0);
      res_n     : IN     std_logic ;
      setreg    : IN     std_logic ;
      addr      : OUT    std_logic_vector (6 DOWNTO 0);
      data_wr   : OUT    std_logic_vector (7 DOWNTO 0);
      ena       : OUT    std_logic ;
      rw        : OUT    std_logic ;
      writedone : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT codecsetup
   PORT (
      ack_error        : IN     STD_LOGIC ;
      clk              : IN     std_logic ;
      leftadcvol       : IN     STD_LOGIC_VECTOR (5 DOWNTO 0);
      leftdacvol       : IN     STD_LOGIC_VECTOR (6 DOWNTO 0);
      res_n            : IN     std_logic ;
      rightadcvol      : IN     STD_LOGIC_VECTOR (5 DOWNTO 0);
      rightdacvol      : IN     STD_LOGIC_VECTOR (6 DOWNTO 0);
      update           : IN     STD_LOGIC ;
      writedone        : IN     std_logic ;
      I2Cstarttransfer : OUT    STD_LOGIC ;
      error            : OUT    std_logic ;
      ready            : OUT    STD_LOGIC ;
      regaddr          : OUT    std_logic_vector (6 DOWNTO 0);
      regdata          : OUT    std_logic_vector (8 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT entireNES
   PORT (
      clk          : IN     std_logic ;
      clk1M        : IN     std_logic ;
      res_n        : IN     std_logic ;
      resetCPU     : IN     boolean ;
      runCPU       : IN     boolean ;
      selectedSong : IN     boolean_vector (7 DOWNTO 0);
      mix          : OUT    boolean_vector (11 DOWNTO 0);
      status       : OUT    boolean_vector (7 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT i2c_master
   GENERIC (
      input_clk : INTEGER := 50_000_000;      --input clock speed from user logic in Hz
      bus_clk   : INTEGER := 400_000
   );
   PORT (
      addr      : IN     STD_LOGIC_VECTOR (6 DOWNTO 0);
      clk       : IN     STD_LOGIC;
      data_wr   : IN     STD_LOGIC_VECTOR (7 DOWNTO 0);
      ena       : IN     STD_LOGIC;
      reset_n   : IN     STD_LOGIC;
      rw        : IN     STD_LOGIC;
      busy      : OUT    STD_LOGIC;
      data_rd   : OUT    STD_LOGIC_VECTOR (7 DOWNTO 0);
      scl       : INOUT  STD_LOGIC;
      sda       : INOUT  STD_LOGIC;
      ack_error : BUFFER STD_LOGIC
   );
   END COMPONENT;
   COMPONENT i2s_transceiver
   GENERIC (
      mclk_sclk_ratio : INTEGER := 4;       --number of mclk periods per sclk period
      sclk_ws_ratio   : INTEGER := 64;      --number of sclk periods per word select period
      d_width         : INTEGER := 24
   );
   PORT (
      l_data_tx : IN     STD_LOGIC_VECTOR (d_width-1 DOWNTO 0);
      mclk      : IN     STD_LOGIC;
      r_data_tx : IN     STD_LOGIC_VECTOR (d_width-1 DOWNTO 0);
      reset_n   : IN     STD_LOGIC;
      sd_rx     : IN     STD_LOGIC;
      l_data_rx : OUT    STD_LOGIC_VECTOR (d_width-1 DOWNTO 0);
      r_data_rx : OUT    STD_LOGIC_VECTOR (d_width-1 DOWNTO 0);
      sclk      : OUT    STD_LOGIC;
      sd_tx     : OUT    STD_LOGIC;
      ws        : OUT    STD_LOGIC
   );
   END COMPONENT;
   COMPONENT synchroniser
   GENERIC (
      rank : positive
   );
   PORT (
      clk    : IN     std_logic;
      unsync : IN     std_logic_vector (15 DOWNTO 0);
      synced : OUT    std_logic_vector (15 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT taktteiler
   GENERIC (
      MAX : integer := 2
   );
   PORT (
      clk   : IN     std_logic ;
      res_n : IN     std_logic ;
      tick  : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT toplevelcontrol
   GENERIC (
      monoaudio : boolean := false
   );
   PORT (
      cpuclkx8    : IN     std_logic ;
      mix         : IN     boolean_vector (11 DOWNTO 0);
      ready       : IN     STD_LOGIC ;
      res_n       : IN     std_logic ;
      l_data_tx   : OUT    std_logic_vector (15 DOWNTO 0);
      leftadcvol  : OUT    STD_LOGIC_VECTOR (5 DOWNTO 0);
      leftdacvol  : OUT    STD_LOGIC_VECTOR (6 DOWNTO 0);
      r_data_tx   : OUT    STD_LOGIC_VECTOR (15 DOWNTO 0);
      resetCPU    : OUT    boolean ;
      rightadcvol : OUT    STD_LOGIC_VECTOR (5 DOWNTO 0);
      rightdacvol : OUT    STD_LOGIC_VECTOR (6 DOWNTO 0);
      runCPU      : OUT    boolean ;
      update      : OUT    STD_LOGIC 
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : PLL50M_to_12M_13_3M_14_3M USE ENTITY audiotest_lib.PLL50M_to_12M_13_3M_14_3M;
   FOR ALL : SSM2603regwriter USE ENTITY audiotest_lib.SSM2603regwriter;
   FOR ALL : codecsetup USE ENTITY audiotest_lib.codecsetup;
   FOR ALL : entireNES USE ENTITY audiotest_lib.entireNES;
   FOR ALL : i2c_master USE ENTITY audiotest_lib.i2c_master;
   FOR ALL : i2s_transceiver USE ENTITY audiotest_lib.i2s_transceiver;
   FOR ALL : synchroniser USE ENTITY audiotest_lib.synchroniser;
   FOR ALL : taktteiler USE ENTITY audiotest_lib.taktteiler;
   FOR ALL : toplevelcontrol USE ENTITY audiotest_lib.toplevelcontrol;
   -- pragma synthesis_on


BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 3 eb3
   -- eb1 1
   res <= not res_n; 
   sd_rx <= '0';  
   cpurunstd <= '1' when runCPU else '0';
   selectedsong <= std_logic_vector2bool_vec(selectedSongsstd);           
   statusstd <= bool_vec2std_logic_vector(status);                   


   -- Instance port mappings.
   U_2 : PLL50M_to_12M_13_3M_14_3M
      PORT MAP (
         refclk   => clk,
         rst      => res,
         outclk_0 => SSM2603_cclk_internal,
         outclk_1 => OPEN,
         outclk_2 => cpuclkx8
      );
   regwr : SSM2603regwriter
      PORT MAP (
         I2Cbusy   => busy,
         clk       => cpuclkx8,
         regaddr   => regaddr,
         regdata   => regdata,
         res_n     => res_n,
         setreg    => I2Cstarttransfer,
         addr      => addr,
         data_wr   => data_wr,
         ena       => ena,
         rw        => rw1,
         writedone => writedone
      );
   codecstp : codecsetup
      PORT MAP (
         ack_error        => ack_error_internal,
         clk              => cpuclkx8,
         leftadcvol       => leftadcvol,
         leftdacvol       => leftdacvol,
         res_n            => res_n,
         rightadcvol      => rightadcvol,
         rightdacvol      => rightdacvol,
         update           => update,
         writedone        => writedone,
         I2Cstarttransfer => I2Cstarttransfer,
         error            => error,
         ready            => ready,
         regaddr          => regaddr,
         regdata          => regdata
      );
   neswrap : entireNES
      PORT MAP (
         clk          => cpuclkx8,
         clk1M        => clk1M,
         res_n        => res_n,
         resetCPU     => resetCPU,
         runCPU       => runCPU,
         selectedSong => selectedSong,
         mix          => mix,
         status       => status
      );
   U_0 : i2c_master
      GENERIC MAP (
         input_clk => 13_300_000,         --input clock speed from user logic in Hz
         bus_clk   => 100_000
      )
      PORT MAP (
         clk       => cpuclkx8,
         reset_n   => res_n,
         ena       => ena,
         addr      => addr,
         rw        => rw1,
         data_wr   => data_wr,
         busy      => busy,
         data_rd   => OPEN,
         ack_error => ack_error_internal,
         sda       => SSM2603_sda,
         scl       => SSM2603_scl
      );
   U_1 : i2s_transceiver
      GENERIC MAP (
         mclk_sclk_ratio => 4,          --number of mclk periods per sclk period
         sclk_ws_ratio   => 40,         --number of sclk periods per word select period
         d_width         => 16
      )
      PORT MAP (
         reset_n   => res_n,
         mclk      => SSM2603_cclk_internal,
         sclk      => SSM2603_bclk,
         ws        => SSM2603_pblrc,
         sd_tx     => SSM2603_pbdat,
         sd_rx     => sd_rx,
         l_data_tx => syncedl,
         r_data_tx => syncedr,
         l_data_rx => OPEN,
         r_data_rx => OPEN
      );
   lsync : synchroniser
      GENERIC MAP (
         rank => 2
      )
      PORT MAP (
         clk    => SSM2603_cclk_internal,
         unsync => l_data_tx,
         synced => syncedl
      );
   rsync : synchroniser
      GENERIC MAP (
         rank => 2
      )
      PORT MAP (
         clk    => SSM2603_cclk_internal,
         unsync => r_data_tx,
         synced => syncedr
      );
   rateclkdiv : taktteiler
      GENERIC MAP (
         MAX => 12
      )
      PORT MAP (
         clk   => SSM2603_cclk_internal,
         res_n => res_n,
         tick  => clk1M
      );
   ctrl : toplevelcontrol
      PORT MAP (
         cpuclkx8    => cpuclkx8,
         mix         => mix,
         ready       => ready,
         res_n       => res_n,
         l_data_tx   => l_data_tx,
         leftadcvol  => leftadcvol,
         leftdacvol  => leftdacvol,
         r_data_tx   => r_data_tx,
         resetCPU    => resetCPU,
         rightadcvol => rightadcvol,
         rightdacvol => rightdacvol,
         runCPU      => runCPU,
         update      => update
      );

   -- Implicit buffered output assignments
   SSM2603_cclk <= SSM2603_cclk_internal;
   ack_error    <= ack_error_internal;

END struct;