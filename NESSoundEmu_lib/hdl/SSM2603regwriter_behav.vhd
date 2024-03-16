--
-- VHDL Architecture audiotest_lib.SSM2603regwriter.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 13:34:49 12/14/23
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF SSM2603regwriter IS
  type stateT is (IDLE, WAITI2C, WRITINGBYTE1, WRITINGBYTE2, DONE1, DONE2, DONE3, DONE4);
  signal currentstate: stateT;
  constant DEVADDR: std_logic_vector(6 downto 0) := B"0011010"; 
  
  signal I2Ctransfreq: std_logic;
BEGIN
  fsm_state_transition : process(clk, res_n) is 
    variable state: stateT;
    variable lastsetreg: std_logic;
    variable lastbusy: std_logic;
    subtype waitforI2CctrT is positive range 1 to 1000;
    variable waitforI2Cctr: waitforI2CctrT;
  begin
    if res_n = '0' then
      state := IDLE;
      lastsetreg := '0';
      waitforI2Cctr := 1;
    else
      if clk'event and clk = '1' then
        transitions : case state is
          when IDLE => 
            if setreg = '1' then
              state := WAITI2C;
            end if;
          when WAITI2C =>
            if I2Cbusy = '0' then
              state := WRITINGBYTE1;
            end if;
          when WRITINGBYTE1 =>
            if I2Cbusy = '1' then
              state := WRITINGBYTE2;
            end if;
          when WRITINGBYTE2 => 
            if I2Cbusy = '0' and lastbusy = '1' then
              state := DONE1;
              waitforI2Cctr := 1;
            end if;
          when DONE1 => 
            if waitforI2Cctr /= waitforI2CctrT'high then
              waitforI2Cctr := waitforI2Cctr + 1;
            else
              state := DONE2;
          end if;
          when DONE2 => state := DONE3;
          when DONE3 => state := DONE4;  
          when DONE4 => state := IDLE;  
        end case transitions;
        
        lastsetreg := setreg;
        lastbusy := I2Cbusy;
      end if;
    end if;
    currentstate <= state;
  end process fsm_state_transition;
  
  
  fsm_outputs : process(all) is 
    variable lastsetreg: std_logic;
  begin
    writedone <= '1';
    I2Ctransfreq <= '0';
    data_wr <= (others => '0');
    
        transitions : case currentstate is
          when IDLE => 
            I2Ctransfreq <= '0';
            writedone <= '1';
          when WAITI2C => 
            writedone <= '0';
            
          when WRITINGBYTE1 => 
            data_wr <= regaddr & regdata(8);
            I2Ctransfreq <= '1';
          when WRITINGBYTE2 => 
            data_wr <= regdata(7 downto 0);
            I2Ctransfreq <= '1';
          when DONE1 => 
            I2Ctransfreq <= '0';
            writedone <= '1';
          when DONE2 => null;
          when DONE3 => null;
          when DONE4 => null;
            
        end case transitions;
        
    addr <= DEVADDR;
    rw <= '0';
  end process fsm_outputs;
    
  
  
  generate_enable_pulse : process(clk, res_n) is 
    variable lastI2Crequest: std_logic;
    variable lastbusy: std_logic;
  begin
    if res_n = '0' then
      lastI2Crequest := '0';
    else
      if clk'event and clk = '1' then
        if I2Ctransfreq = '1' and lastI2Crequest = '0' then
          ena <= '1';
        elsif I2Cbusy = '0' and lastbusy = '1' then
          ena <= '0';
        end if;
        
        lastI2Crequest := I2Ctransfreq;
        lastbusy := I2Cbusy;
      end if;
    end if;
  end process generate_enable_pulse;
END ARCHITECTURE behav;

