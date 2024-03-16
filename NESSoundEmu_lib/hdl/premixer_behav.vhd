--
-- VHDL Architecture audiotest_lib.premixer.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 12:55:03 01/23/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF premixer IS
  signal outputon: boolean;
BEGIN
  outputon <= q and not(mute1 or mute2 or mute3);
  mixed <= volume when outputon else (others => false);
END ARCHITECTURE behav;

