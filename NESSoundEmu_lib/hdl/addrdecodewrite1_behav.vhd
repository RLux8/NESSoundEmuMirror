--
-- VHDL Architecture audiotest_lib.addrdecodewrite1.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 13:00:11 02/05/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all;
ARCHITECTURE behav OF addrdecodewritedev IS
 signal vectorramwr_arch: boolean;
BEGIN
  wrdecode : process(all) is
  begin
    apuwr <= false;
    vectorramwr_arch <= false;
    bkswwr <= false;
    controlportwr <= false;
    n163wr <= false;
    vrc6wr <= false;
    vrc6addr <= (others => false);
    ratetimerwr <= false;
    
    case bool_vec2integer(addr) is
   
      -- apu address space
      when 16#4000# to 16#4017# => 
        apuwr <= wr;
        
      -- vector overlay access
      when 16#4020# to 16#402F# => vectorramwr_arch <= wr; 
        
      -- rate timer 
      when 16#4030# to 16#403F# => ratetimerwr <= wr;
        
      -- control io
      when 16#4040# => controlportwr <= wr;
      
      -- nsf storage rom bank offset configuration
      when 16#4050# to 16#405F# => bkswwr <= wr;
        
      -- N163 externsions: data port
      when 16#4800# => n163wr <= wr;
        
      -- nsf storage rom bank configuration
      when 16#5FF0# to 16#5FF3# => bkswwr <= wr;
      
      -- control io
      when 16#5FF4# => controlportwr <= wr;
        
       
      -- rate timer 
      when 16#5FF5# to 16#5FF7# => ratetimerwr <= wr;
        
      -- nsf storage rom bank configuration 
      when 16#5FF8# to 16#5FFF# => bkswwr <= wr;
        
      -- VRC6 expansion: pulse1
      when 16#9000# to 16#9003# => 
        vrc6wr <= wr;
        vrc6addr <= (false, false) & addr(1 downto 0);
      -- VRC6 expansion: pulse2
      when 16#A000# to 16#A002# =>
        vrc6wr <= wr;
        vrc6addr <= (false, true) & addr(1 downto 0);
      -- VRC6 expansion: saw
      when 16#B000# to 16#B002# =>
        vrc6wr <= wr;
        vrc6addr <= (true, false) & addr(1 downto 0);
      
      -- N163 expansion: control port
      when 16#E000# => n163wr <= wr;
      -- N163 expansion: address port
      when 16#F800# => n163wr <= wr;
      when others => null;
    end case;
  end process wrdecode;
  
  vectorramwr <= vectorramwr_arch;
  overlayvectordff : process(clk, res_n) is
  begin
    if res_n = '0' then
      overlayvectors <= true;
    else
      if clk'event and clk = '1' then
        if vectorramwr_arch then
          overlayvectors <= false;
        elsif cpuRES = '1' or cpuIRQ = '0' or cpuNMI = '0' then
          overlayvectors <= true;
        end if;
      end if;
    end if;
  end process overlayvectordff;
END ARCHITECTURE behav;

