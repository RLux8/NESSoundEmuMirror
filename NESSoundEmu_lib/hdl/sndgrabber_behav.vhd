--
-- VHDL Architecture audiotest_lib.sndgrabber.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 17:12:06 02/05/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

ARCHITECTURE behav OF sndgrabber IS
BEGIN
  writing :
  process
      file      outfile  : text is out "TBout.rwav";  --declare output file
      variable outline          : line;
  begin
    --write(linenumber,value(real type),justified(side),field(width),digits(natural));
    write(outline, bool_vec2integer(mix srl 4), right, 3);
    -- write line to external file.
    writeline(outfile, outline);
    wait for 22.6 us;
  end process writing;
END ARCHITECTURE behav;

