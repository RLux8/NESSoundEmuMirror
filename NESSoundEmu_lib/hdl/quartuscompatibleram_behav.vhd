--
-- VHDL Architecture audiotest_lib.quartuscompatibleram.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 15:16:37 01/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
--
-- VHDL Architecture audiotest_lib.quartuscompatram.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 14:39:36 01/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;


ENTITY quartuscompatibleram IS
   generic(
    data_width : natural;
    addr_width : natural
    ); 
   PORT
   (
      clk:          IN   std_logic;
      data:           IN   boolean_vector (data_width-1 DOWNTO 0);
      write_address:  IN   boolean_vector(addr_width-1 downto 0); --integer RANGE 0 to 2**addr_width - 1;
      read_address:   IN   boolean_vector(addr_width-1 downto 0);
      we:             IN   boolean;
      q:              OUT  boolean_vector (data_width-1 DOWNTO 0)
   );
END ENTITY quartuscompatibleram;

--
ARCHITECTURE behav OF quartuscompatibleram IS
   --TYPE mem IS ARRAY(0 TO 2**addr_width-1) OF boolean_vector(data_width-1 downto 0);
   TYPE mem IS ARRAY(0 TO 2**addr_width-1) OF integer range  0 to 2**data_width-1;
   SIGNAL ram_block : mem;
   SIGNAL read_address_reg : boolean_vector(addr_width-1 downto 0);
BEGIN
  PROCESS (clk)
   BEGIN
      IF clk'event AND clk = '1' THEN
         IF we THEN
            --ram_block(bool_vec2integer(write_address)) <= data;
            ram_block(bool_vec2integer(write_address)) <= bool_vec2integer(data);
         END IF;
         read_address_reg <= read_address;
      END IF;
   END PROCESS;
   q <= integer2bool_vec(ram_block(bool_vec2integer(read_address_reg)), data_width);
   --q <= ram_block(bool_vec2integer(read_address_reg));
END ARCHITECTURE behav;



