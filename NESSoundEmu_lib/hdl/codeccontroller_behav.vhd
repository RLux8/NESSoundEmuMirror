--
-- VHDL Architecture audiotest_lib.codeccontroller.behav
--
-- Created:
--          by - redacted.redacted (pc038)
--          at - 16:56:17 12/04/23
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF codeccontroller IS
  type stateT is (INIT, POWERUP, WRITINGINIT, WRITING, WAITFORVMIDCAP, ENABLEDIGCORE, ENABLEDAC, DONE);
  signal currentstate: stateT;
  
  
  subtype regaddrT is natural range 0 to 18;
  
  constant ADCLEFTINVOLREG: regaddrT := 0;
  constant ADCRIGHTINVOLREG: regaddrT := 1;
  constant DACLEFTINVOLREG: regaddrT := 2;
  constant DACRIGHTINVOLREG: regaddrT := 3;
  constant POWERMGMTREG: regaddrT := 6;
  constant SAMPLRATEREG: regaddrT := 8;
  constant DIGCOREENREG: regaddrT := 9;
  constant NOISEGATEREG: regaddrT := 18;
  
  signal currentregaddr: regaddrT;
  
  

BEGIN
  fsm_state_transition : process(clk, res_n) is 
    variable state: stateT;
    
    variable regaddr: regaddrT;
    
    constant CAPCHARGEWAITCLKS: natural := 2000; --2000000; --using a delay of 40ms(@50MHz) since there is no documentation on the capacitor size used for VMID by SSM2603 on the Cyclone 5 GX starter board
    subtype capwaitctrT is natural range 0 to CAPCHARGEWAITCLKS; 
    variable capwaitctr: capwaitctrT;
    
    variable lastbusy: std_logic;
  begin
    if res_n = '0' then
      state := INIT;
      capwaitctr := 0;
      lastbusy := '1';
      regaddr := POWERMGMTREG;
    else
      if clk'event and clk = '1' then
          if writedone = '1' then
            highlevelstatetransitions : case state is
              when INIT => 
                state := POWERUP;
                capwaitctr := 0;
              when POWERUP =>
                state := WRITINGINIT;
                regaddr := POWERMGMTREG;
              when WRITINGINIT =>
                state := WRITING;
                regaddr := ADCLEFTINVOLREG;
              when WRITING => 
                regtransitions : case regaddr is
                  when ADCLEFTINVOLREG => regaddr := ADCRIGHTINVOLREG;
                  when ADCRIGHTINVOLREG => regaddr := DACLEFTINVOLREG;
                  when DACLEFTINVOLREG => regaddr := DACRIGHTINVOLREG;
                  when DACRIGHTINVOLREG => regaddr := SAMPLRATEREG;
                  when SAMPLRATEREG => state := WAITFORVMIDCAP;
                  when others => regaddr := ADCRIGHTINVOLREG;
                end case regtransitions;
              when WAITFORVMIDCAP => 
                if capwaitctr /= capwaitctrT'high then
                  capwaitctr := capwaitctr + 1;
                else
                  state := ENABLEDIGCORE;
                end if;
              when ENABLEDIGCORE => 
                state := ENABLEDAC;
                regaddr := DIGCOREENREG;
              when ENABLEDAC => 
                state := DONE;
                regaddr := DIGCOREENREG;
              when DONE => 
                if update = '1' then
                  state := INIT;
                else
                  state := DONE;
                end if;
              when others => state := INIT;
            end case highlevelstatetransitions;
          end if;
        end if;
    end if;
    currentstate <= state;
    currentregaddr <= regaddr;
  end process fsm_state_transition;
  
  fsm_outputs : process(currentstate, currentregaddr) is 
    variable data: std_logic_vector(8 downto 0);
  
  begin
    outputassignments : case currentstate is
      when POWERUP => 
        data := B"000010011"; -- power up all components except mic and line in, also keep output off for now as per DS
        I2Cstarttransfer <= '1';
        ready <= '0';
      when WRITINGINIT =>
        I2Cstarttransfer <= '0';
      when WRITING =>
        I2Cstarttransfer <= '1';
        regdataout : case currentregaddr is
          when ADCLEFTINVOLREG => data := B"000" & leftadcvol;
          when ADCRIGHTINVOLREG => data := B"000" & rightadcvol;
          when DACLEFTINVOLREG => data := B"00" & leftdacvol;
          when DACRIGHTINVOLREG => data := B"00" & rightdacvol;
          when SAMPLRATEREG => data := B"000000001"; -- 48 kHz sample rate at 12 MHz MCLK;
          when others => null;
        end case regdataout;
      when WAITFORVMIDCAP => I2Cstarttransfer <= '0';
      when ENABLEDIGCORE => 
        data := B"000000001"; -- power up the digital core
        I2Cstarttransfer <= '1';
      when ENABLEDAC =>
        data := B"000000011"; -- power up all components except mic and line in, fianlly enable DAC
        I2Cstarttransfer <= '1';
      when DONE => 
        I2Cstarttransfer <= '0';
        ready <= '1';
      when others => null;
    end case outputassignments;
    regaddr <= std_logic_vector(to_unsigned(currentregaddr, 7));
    regdata <= data;
  end process fsm_outputs;
  
  
END ARCHITECTURE behav;

