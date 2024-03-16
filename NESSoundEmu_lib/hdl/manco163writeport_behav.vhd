--
-- VHDL Architecture audiotest_lib.manco163writeport.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 14:37:12 02/13/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all;
library ieee; use ieee.numeric_std.all;


ARCHITECTURE behav OF namco163writeport IS
  signal supressingwr: boolean;
BEGIN
  
  readwriteport : process(clk, res_n) is
    constant ramsize: integer := 128;
    variable ramaddr: integer range 0 to ramsize-1;
    variable ramaddr_next: integer range 0 to ramsize-1;
    variable autoincrement: boolean;
    variable rdwrwasactive: boolean;
    variable lastaddr: boolean_vector(addr'range);
    
  begin
    if res_n = '0' then
      enableFSM <= false;
      ramaddr_next := 0;
      rdwrwasactive := false;
      activechannels <= 1;
      lastaddr := (others => false);
    else
      if clk'event and clk = '1' then
        ramaddr := ramaddr_next;
        
        if rdwrwasactive and not (rd or wr) and bool_vec2integer(lastaddr) = 0 and autoincrement then
          if ramaddr /= ramsize - 1 then
            ramaddr_next := ramaddr + 1;
          else
            ramaddr_next := 0;
          end if;
        end if;
        
        if wr then
          case bool_vec2integer(addr) is
            when 0 => -- corresponds to $4800: dataport
              -- wavetable address 7F special: indicates number of active channels - 1
              if ramaddr = 127 then
                activechannels <= to_integer(unsigned(data(6 downto 4))) + 1;
              end if;
            when 2 => -- sound enable port
              enableFSM <= (data(6) = '0');
              
            when 3 => -- address port
              ramaddr := to_integer(unsigned(data(6 downto 0)));
              ramaddr_next := to_integer(unsigned(data(6 downto 0)));
              autoincrement := data(7) = '1';
              
            when others => null;
          end case;
        end if;
        
        
     
        
        rdwrwasactive := (rd or wr);
        
        lastaddr := addr;
      end if;
    end if;
    
    if rd then
      data <= bool_vec2std_logic_vector(wpdataout);
    else
      data <= "ZZZZZZZZ";
    end if;
    
    wpaddr <= integer2bool_vec(ramaddr, 7);
  end process readwriteport;
  
  
  wrsupress : process(clk, res_n) is
      variable supressingwr_int: boolean;
    begin
      if res_n = '0' then
        supressingwr_int := false;
      else
        if clk'event and clk = '1' then
          if wr and not supressingwr_int then
            supressingwr_int := true;
          end if;
          
          if not wr then
            supressingwr_int := false;
            
          end if;
        end if;
      end if;
      supressingwr <= supressingwr_int;
    end process wrsupress;
  
  wpdatain <= std_logic_vector2bool_vec(data);
  wpwren <= wr and bool_vec2integer(addr) = 0 and not supressingwr;
END ARCHITECTURE behav;

