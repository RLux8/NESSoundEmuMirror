--
-- VHDL Architecture heike_lib.taktteiler.behav
--
-- Created:
--          by - leylknci.meyer (pc038)
--          at - 16:45:30 11/22/23
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library ieee; 
use ieee.numeric_std.all; 
use ieee.math_real.all;

ARCHITECTURE behav OF taktteiler IS
BEGIN
  process(clk, res_n) is
    constant N : integer := integer(ceil(log2(real(MAX))));
    variable q_int: unsigned(N-1 downto 0);
  begin
    if res_n = '0' then
      q_int := (others => '0');
      tick <= '0';
    else
      if clk'event and clk = '1' then
        if q_int /= MAX then
          q_int := q_int + 1;
          tick <= '0';
        else
          q_int := (others => '0');
          tick <= '1';
        end if;
      end if;
    end if; 
  end process;
END ARCHITECTURE behav;


