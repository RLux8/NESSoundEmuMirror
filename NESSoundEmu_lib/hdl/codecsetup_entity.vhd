-- VHDL Entity audiotest_lib.codecsetup.symbol
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 12:56:06 12/19/23
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE IEEE.numeric_std.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.all;
LIBRARY altera_mf; USE altera_mf.altera_mf_components.all;
USE ieee.std_logic_unsigned.all;

ENTITY codecsetup IS
   PORT( 
      ack_error        : IN     STD_LOGIC;
      clk              : IN     std_logic;
      leftadcvol       : IN     STD_LOGIC_VECTOR (5 DOWNTO 0);
      leftdacvol       : IN     STD_LOGIC_VECTOR (6 DOWNTO 0);
      res_n            : IN     std_logic;
      rightadcvol      : IN     STD_LOGIC_VECTOR (5 DOWNTO 0);
      rightdacvol      : IN     STD_LOGIC_VECTOR (6 DOWNTO 0);
      update           : IN     STD_LOGIC;
      writedone        : IN     std_logic;
      I2Cstarttransfer : OUT    STD_LOGIC;
      error            : OUT    std_logic;
      ready            : OUT    STD_LOGIC;
      regaddr          : OUT    std_logic_vector (6 DOWNTO 0);
      regdata          : OUT    std_logic_vector (8 DOWNTO 0)
   );

-- Declarations

END codecsetup ;

