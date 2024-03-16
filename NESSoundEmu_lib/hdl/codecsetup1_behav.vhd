--
-- VHDL Architecture audiotest_lib.codecsetup1.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 16:42:10 12/18/23
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF codecsetup IS
type stateT is (INIT, RESETCHIPWAIT, POWERUP, WRITINGINIT, WRITING, WAITFORVMIDCAP, ENABLEDIGCORE, ENABLEDAC, DONE, I2CERROR);
  signal currentstate: stateT;
  
  
  subtype regaddrT is natural range 0 to 18;
  
  constant ADCLEFTINVOLREG: regaddrT := 0;
  constant ADCRIGHTINVOLREG: regaddrT := 1;
  constant DACLEFTINVOLREG: regaddrT := 2;
  constant DACRIGHTINVOLREG: regaddrT := 3;
  constant DIGPATHCONFREG: regaddrT := 5;
  constant POWERMGMTREG: regaddrT := 6;
  constant DIGIFCNFREG: regaddrT := 7;
  constant SAMPLRATEREG: regaddrT := 8;
  constant DIGCOREENREG: regaddrT := 9;
  constant AAUDIOPATHREG: regaddrT := 4;
  constant RESETCHIPREG: regaddrT := 15;
  constant NOISEGATEREG: regaddrT := 18;
  
  signal currentregaddr: regaddrT;
  
  

BEGIN
  fsm_state_transition : process(clk, res_n) is 
    variable state: stateT;
    
    variable regaddr: regaddrT;
    
    constant CAPCHARGEWAITCLKS: natural := 2000000; --using a delay of 40ms(@50MHz) since there is no documentation on the capacitor size used for VMID by SSM2603 on the Cyclone 5 GX starter board
    constant WAITAFTERRESETCLKS: natural := 200000;
    subtype waitctrT is natural range 0 to CAPCHARGEWAITCLKS; 
    variable waitctr: waitctrT;
    
    variable lastwritedone: std_logic;
  begin
    if res_n = '0' then
      state := INIT;
      waitctr := 0;
      regaddr := POWERMGMTREG;
      lastwritedone := '0';
    else
      if clk'event and clk = '1' then
          if ack_error = '1' then
            state := I2CERROR;
          end if;
          
          
          if writedone = '1' then
            highlevelstatetransitions : case state is
              when INIT => 
                waitctr := 0;
                regaddr := RESETCHIPREG;
                state := RESETCHIPWAIT;
              when RESETCHIPWAIT=>
                if waitctr /= WAITAFTERRESETCLKS then
                  waitctr := waitctr + 1;
                else
                  state := POWERUP;
                end if;
              when POWERUP =>
                if lastwritedone = '0' then
                  state := WRITINGINIT;
                  regaddr := POWERMGMTREG;
                end if;
              when WRITINGINIT =>
                state := WRITING;
                regaddr := ADCLEFTINVOLREG;
              when WRITING => 
                if lastwritedone = '0' then
                  regtransitions : case regaddr is
                    when ADCLEFTINVOLREG => regaddr := ADCRIGHTINVOLREG;
                    when ADCRIGHTINVOLREG => regaddr := DACLEFTINVOLREG;
                    when DACLEFTINVOLREG => regaddr := DACRIGHTINVOLREG;
                    when DACRIGHTINVOLREG => regaddr := DIGPATHCONFREG;
                    when DIGPATHCONFREG => regaddr := AAUDIOPATHREG;
                    when AAUDIOPATHREG => regaddr := DIGIFCNFREG;
                    when DIGIFCNFREG => regaddr := SAMPLRATEREG;
                    when SAMPLRATEREG => 
                      if update = '1' then
                        state := DONE;
                      else
                        state := WAITFORVMIDCAP;
                        waitctr := 0;
                      end if;
                    when others => regaddr := ADCRIGHTINVOLREG;
                  end case regtransitions;
                end if;
              when WAITFORVMIDCAP => 
                if waitctr /= waitctrT'high then
                  waitctr := waitctr + 1;
                else
                  state := ENABLEDIGCORE;
                end if;
              when ENABLEDIGCORE => 
                if lastwritedone = '0' then
                  state := ENABLEDAC;
                  regaddr := DIGCOREENREG;
                end if;
              when ENABLEDAC => 
                if lastwritedone = '0' then
                  state := DONE;
                  regaddr := POWERMGMTREG;
                end if;
              when DONE => 
                if update = '1' then
                  state := WRITINGINIT;
                else
                  state := DONE;
                end if;
              when I2CERROR => 
                if update = '1' then
                  state := INIT;
                else
                  state := I2CERROR;
                end if;
              when others => state := INIT;
            end case highlevelstatetransitions;
          end if;
          lastwritedone := writedone;
        end if;
    end if;
    currentstate <= state;
    currentregaddr <= regaddr;
  end process fsm_state_transition;
  
  fsm_outputs : process(all) is 
    variable data: std_logic_vector(8 downto 0);
  
  begin
    ready <= '0';
    
    outputassignments : case currentstate is
      when INIT => 
        I2Cstarttransfer <= '1';
        data := B"000000000";
        error <= '0';
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
          when DIGPATHCONFREG => data := B"000000000"; -- enable DAC in digital path configuration
          when DIGIFCNFREG => data := B"000000010"; --use I2S mode
          when AAUDIOPATHREG => data := B"000010000";
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
      when I2CERROR => 
        I2Cstarttransfer <= '0';
        ready <= '0';
        error <= '1';
      when others => I2Cstarttransfer <= '0';
    end case outputassignments;
    regaddr <= std_logic_vector(to_unsigned(currentregaddr, 7));
    regdata <= data;
  end process fsm_outputs;
  
END ARCHITECTURE behav;

