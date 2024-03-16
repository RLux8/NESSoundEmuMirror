--
-- VHDL Architecture audiotest_lib.namco163statemachine.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 16:22:40 02/09/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library ieee; use ieee.numeric_std.all;

ARCHITECTURE behav OF namco163statemachine IS
  type stateT is (INIT, GETPHASE1, GETPHASE2, GETPHASE3, GETFREQ1, GETFREQ2, GETFREQ3, GETOFFSET, GETVOLUME, GETSAMPLE, STOREPHASE1, STOREPHASE2, STOREPHASE3, WAIT1, WAIT2, WAIT3);
  
  signal currentstate: stateT;
  signal activechannel: integer range 0 to 7;
  subtype channeloutputT is integer range 0 to 255; 
  type channeloutputsT is array(7 downto 0) of channeloutputT;
  signal channeloutputs: channeloutputsT;
BEGIN
  fsm_transitions : process(clk, res_n) is
  begin
    if res_n = '0' then
      currentstate <= INIT;
    else
      if clk'event and clk = '1' then
        if cpuclk then
          if enableFSM then
            if currentstate /= stateT'right then
              currentstate <= stateT'succ(currentstate);
            else
              currentstate <= GETPHASE1;
            end if;
          else
            currentstate <= INIT;
          end if;
        end if;
      end if;
    end if;
  end process fsm_transitions;
  
  
  
  fsm_outputs : process(clk, res_n) is
    variable phase: boolean_vector(23 downto 0);
    variable frequency: boolean_vector(17 downto 0);
    variable samplelen: boolean_vector(8 downto 0);
    variable sampleoffset: boolean_byte;
    variable volume: boolean_nibble;
    variable sampleaddr: boolean_byte; -- THIS IS A NIBBLE ADDRESS!
    variable sample: boolean_nibble;
    variable writeaval: boolean;
    variable supressingwr: boolean;
    variable last_state: stateT;
    
    constant PHASEOFFSETLADDR : integer := 16#41#;
    constant PHASEOFFSETMADDR : integer := 16#43#;
    constant PHASEOFFSETHADDR : integer := 16#45#;
    constant FREQLADDR : integer := 16#40#;
    constant FREQMADDR : integer := 16#42#;
    constant FREQHANDLENADDR : integer := 16#44#;
    constant OFFFSETADDR : integer := 16#46#;
    constant VOLUMEADDR : integer := 16#47#;
  begin
    -- since the RAM block we use has a registered address port, we have to wait for one clock after setting the address
    -- here we set the address we will read from / write to one fsm step ahead
    if res_n = '0' then
      activechannel <= 7;
      phase := (others => false);
      frequency := (others => false);
      samplelen := (others => false);
      sampleoffset := (others => false);
      volume := (others => false);
      sampleaddr := (others => false);
      sample := (others => false);
      
      supressingwr := false;
      writeaval := false;
    else
      if clk'event and clk = '1' then
        if cpuclk then
          case currentstate is 
            when INIT => 
              activechannel <= 7;
              wram_address <= integer2bool_vec(PHASEOFFSETLADDR + activechannel*8, wram_address'high+1);
              writeaval := false;
              
              for i in channeloutputs'range loop
                channeloutputs(i) <= 128;
              end loop;
            
            when GETPHASE1 => 
              phase(7 downto 0) := ramdataout;
              
              wram_address <= integer2bool_vec(PHASEOFFSETMADDR + activechannel*8, wram_address'high+1);
              writeaval := false;
            when GETPHASE2 => 
              phase(15 downto 8) := ramdataout;
              
              wram_address <= integer2bool_vec(PHASEOFFSETHADDR + activechannel*8, wram_address'high+1);
              writeaval := false;
            when GETPHASE3 => 
              phase(23 downto 16) := ramdataout;
              
              wram_address <= integer2bool_vec(FREQLADDR + activechannel*8, wram_address'high+1);
              writeaval :=  false;
            when GETFREQ1 => 
              frequency(7 downto 0) := ramdataout;
              
              wram_address <= integer2bool_vec(FREQMADDR + activechannel*8, wram_address'high+1);
              writeaval :=  false;
            when GETFREQ2 => 
              frequency(15 downto 8) := ramdataout;
              
              wram_address <= integer2bool_vec(FREQHANDLENADDR + activechannel*8, wram_address'high+1);
              writeaval :=  false;
            when GETFREQ3 => 
              frequency(17 downto 16) := ramdataout(1 downto 0);
              samplelen := integer2bool_vec(256 - bool_vec2integer(ramdataout(7 downto 2))*4, 9);
              
              if bool_vec2integer(samplelen) /= 0 then
                phase := integer2bool_vec(((bool_vec2integer(phase) + bool_vec2integer(frequency)) mod (bool_vec2integer(samplelen) * 2**16)) ,24);
              end if;
              
              wram_address <= integer2bool_vec(OFFFSETADDR + activechannel*8, wram_address'high+1);
              writeaval := false;
            when GETOFFSET => 
              sampleoffset := ramdataout;
              
              wram_address <= integer2bool_vec(VOLUMEADDR + activechannel*8, wram_address'high+1);
              writeaval := false;
            when GETVOLUME => 
              volume := ramdataout(3 downto 0);
              
              sampleaddr := integer2bool_vec(bool_vec2integer(phase srl 16) + bool_vec2integer(sampleoffset), 8);
              wram_address <= sampleaddr(7 downto 1);
            when GETSAMPLE =>
              if not sampleaddr(0) then
                sample := ramdataout(3 downto 0);
              else
                sample := ramdataout(7 downto 4);
              end if;
              
              channeloutputs(activechannel) <= 128 + (bool_vec2integer(sample) - 8)*bool_vec2integer(volume);
              
              
              wram_address <= integer2bool_vec(PHASEOFFSETLADDR + activechannel*8, wram_address'high+1);
              ramdatain <= phase(7 downto 0);
              writeaval := bool_vec2integer(frequency) /= 0;   
            when STOREPHASE1 => 
              
              
              wram_address <= integer2bool_vec(PHASEOFFSETMADDR+ activechannel*8, wram_address'high+1);
              ramdatain <= phase(15 downto 8);
              writeaval := bool_vec2integer(frequency) /= 0; 
            when STOREPHASE2 => 
              
              wram_address <= integer2bool_vec(PHASEOFFSETHADDR + activechannel*8, wram_address'high+1);
              ramdatain <= phase(23 downto 16);
              writeaval :=  bool_vec2integer(frequency) /= 0; 
              
            when STOREPHASE3 => 
              -- setup read address for next channel phase read
              if activechannel < channeloutputsT'high - activechannels + 2 then
                activechannel <= channeloutputsT'high;
              else
                activechannel <= activechannel - 1;
              end if;
                    
              wram_address <= integer2bool_vec(PHASEOFFSETLADDR + activechannel*8, wram_address'high+1);
              writeaval := false;
              
            when WAIT1 | WAIT2 | WAIT3 => null;
              
          end case;
        end if;
        
        if writeaval and not supressingwr then
          supressingwr := true;
          ramwr <= true;
        else
          ramwr <= false;
        end if;
        
        if last_state /= currentstate then
          supressingwr := false;
        end if;
        
        last_state := currentstate;
      end if;
    end if;
  end process fsm_outputs;
  
  
  endmix : process(all) is
    variable channelsum: integer range 0 to (channeloutputT'high)*channeloutputsT'length;
  begin
    if useTDM then
      n163mix <= integer2bool_vec(channeloutputs(activechannel), n163mix'high+1);
    else
      channelsum := 0;
      for i in channeloutputsT'range loop
        if i > 7 - activechannels then
          channelsum := channelsum + channeloutputs(i);
        end if;
      end loop;
      
      n163mix <= integer2bool_vec(channelsum / activechannels, n163mix'high+1);
    end if;
  end process endmix;

END ARCHITECTURE behav;

