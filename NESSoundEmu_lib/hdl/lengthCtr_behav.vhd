--
-- VHDL Architecture audiotest_lib.lengthCtr.behav
--
-- Created:
--          by - redacted.redacted (pc038)
--          at - 12:17:26 12/12/23
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF lengthCtr IS
BEGIN
  process(clk, res_n) is
    variable q_int: unsigned range 0 to 255;
    
    type initialValueLUTT is array(unsigned range 0 to 31) of unsigned;
    constant initialValueLUT : initialValueLUTT := (10,254,20,2,40,4,80,6,160,8,60,10,14,12,26,14,12,26,14,12,16,24,18,48,20,96,22,192,24,72,26,16,28,32,30);
  begin
    if res_n = '0' then
      q_int := 0;
      iszero <= '0';
    else
      if clk'event and clk = '1' then
        -- enabled = 0 forces ctr to zero
        if enabled = '0' then
          q_int := 0;
        end if;
        
        -- use LUT to initially fill counter
        if wr = '1' then
          q_int := initialValueLUT(to_unsigned(l)) + INITOFFSET;
        else
          if tickclk = '1' and enabled = '1' and halt = '0' then
            if q_int /= 0 then
              q_int := q_int - 1;
            end if;
          end if;
        end if;
      end if;
    end if; 
    
    if q_int = 0 then
      iszero <= '1';
    else
      iszero <= '0';
    end if;
  end process;
END ARCHITECTURE behav;

