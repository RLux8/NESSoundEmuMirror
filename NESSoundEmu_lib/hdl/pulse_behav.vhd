--
-- VHDL Architecture audiotest_lib.pulse.behav
--
-- Created:
--          by - redacted.redacted (pc038)
--          at - 16:06:14 12/11/23
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF clkdivandsequence IS
BEGIN
  process(clk, res_n) is 
    variable pulsetimer: unsigned(10 downto 0);
    variable sequencestep: unsigned range 0 to 7;
    
    type duytT is range 0 to 3;
    type sequencesLUTT is array(dutyT'range) of std_logic_vector;
    constant sequencesLUT : sequencesLUTT := (
      0 => 8B"0100_0000",
      1 => 8B"0110_0000",
      2 => 8B"0111_1000",
      3 => 8B"1011_1111"
      );
      
      
  begin
    if res_n = '0' then
      pulsetimer := 0;
      sequencestep := 0;
    else
      if clk'event and clk = '1' then
        -- usually count down and then reload the value
        if tick = '1' then
          if pulsetimer /= 0 then
            pulsetimer := pulsetimer - 1;
          else
            pulsetimer := to_unsigned(pulseperiod);
            if sequencestep /= 0 then
              sequencestep := sequencestep - 1;
            else
              sequencestep := 7;
            end if;
          end if;
        end if;
        
        -- forced reload is also possible
        if restartsequence = '1' then
          sequencestep := 7;
        end if;
        
        
        
      end if;
      
      -- outputs
      if pulsetimer < 8 or forceoff = '1' then
        q <= '0';
      else
        q <= sequencesLUT(to_unsigned(duty))(sequencestep);
      end if;
      pulsetimerq <= std_logic_vector(pulsetimer);
    end if;
    
  end process;
END ARCHITECTURE behav;

