--
-- VHDL Architecture audiotest_lib.statusandaddrdec.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 15:42:17 01/23/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all; use audiotest_lib.boolstdlogicbusconverter;
LIBRARY ieee;
USE IEEE.numeric_std.all;

ARCHITECTURE behav OF apustatusandaddrdec IS
  signal statusregwr: boolean;
  signal framectrwr: boolean;
  signal apudataout: boolean_byte;
BEGIN
  addressdecode : process(addr, wr) is 
  begin
    statusregwr <= false;
    framectrwr <= false;
    p1wr <= false;
    p2wr <= false;
    triwr <= false;
    noisewr <= false;
    dmcwr <= false;
    
    if wr then
      case  bool_vec2integer(addr) is
        when 0 to 3 => p1wr <= true;
        when 4 to 7 => p2wr <= true;
        when 8 to 11 => triwr <= true;
        when 12 to 15 => noisewr <= true; 
        when 16 to 19 => dmcwr <= true;
        when 21 => statusregwr <= true;
        when 23 => framectrwr <= true;
        when others => null;
      end case;
    end if;
    addrlow2 <= addr(1 downto 0);
  end process addressdecode;

  
  statusregisterwr : process(clk, res_n) is
    variable enabledcomponents: boolean_vector(4 downto 0);
  begin
    if res_n = '0' then
      enabledcomponents := (false, false, false, false, false);
    else
      if clk'event and clk = '1' then
        if statusregwr then
          enabledcomponents := std_logic_vector2bool_vec(data(4 downto 0));
          dmcclearintflag <= true;
        else
          dmcclearintflag <= false;
        end if;
      end if;
    end if;
    
    p1enabled <= enabledcomponents(0);
    p2enabled <= enabledcomponents(1);
    trienabled <= enabledcomponents(2);
    noiseenabled <= enabledcomponents(3);
    dmcenabled <= enabledcomponents(4);
  end process statusregisterwr;  
  
  
  statusregisterrd : process(all) is 
  begin
    apudataout <= (dmcirq, frameint, false, playingsample, noiseleniszero, triiszero, p2leniszero, p1leniszero);
    frctrclearintflag <= rd;
  end process  statusregisterrd;
  
  framectrcontrolregister : process(clk, res_n) is
  begin
    if res_n = '0' then
      mode <= false;
      genint <= false;
      resctr <= false;
    else
      if clk'event and clk = '1' then
        if framectrwr then
          mode <= data(7) = '1';
          genint <= data(6) = '0';
          resctr <= true;
        else
          resctr <= false;
        end if;
      end if;
    end if;
    irq <= frameint;
  end process framectrcontrolregister;
  

  busaccess : entity boolstdlogicbusconverter
    generic map (dataw => 8)
    port map (
      datafrombus => wrdata,
      datatobus => apudataout,
      databus => data,
      putdataonbus => rd
    );
  
END ARCHITECTURE behav;

