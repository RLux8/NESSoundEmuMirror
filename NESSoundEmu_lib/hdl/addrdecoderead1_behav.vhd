  --
-- VHDL Architecture audiotest_lib.addrdecoderead.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 11:20:24 01/29/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all;


ARCHITECTURE behav OF addrdecodereadmem IS
  signal memdataout: boolean_byte;
BEGIN
  rddecode: process(all) is
  begin
    case bool_vec2integer(addr) is
      -- low system ram address space
      when 16#0000# to 16#1FFF# =>
        memdataout <= lowsysramdataout;
        
       -- boot ram address space
      when 16#2000# to 16#2FFF# =>
        memdataout <= bootRAMdata;
      
      -- high system ram address space
      when 16#6000# to 16#7FFF# =>
        memdataout <= highsysramdataout;
      
        
      -- nsf storage rom banked access
      when 16#8000# to 16#FFFF# =>
        if bool_vec2integer(addr) > 16#FFF9# and overlayvectors then
          memdataout <= vectorRAMdata;
        else
          memdataout <= songRAMdata;
        end if;
      when others => memdataout <= std_logic_vector2bool_vec(X"55");
    end case;
  end process rddecode;
  
  
  busaccess : entity audiotest_lib.boolstdlogicbusconverter
    generic map (dataw => 8)
    port map (
      databus => data,
      datafrombus => memdatain,
      datatobus => memdataout,
      putdataonbus => rd
    );

  wrdecode : process(all) is
  begin
    lowsysramwr <= false;
    highsysramwr <= false;
    bootRAMwr <= '0';
    
    case bool_vec2integer(addr) is
      -- system ram address space
      when 16#0000# to 16#1FFF# =>
        lowsysramwr <= wr;
         
      -- boot ram address space
      when 16#2000# to 16#3000# =>
        if wr then
          bootRAMwr <= '1';
        else
          bootRAMwr <= '0';
        end if; 

        
      -- high system ram address space
      when 16#6000# to 16#7FFF# =>
        highsysramwr <= wr;

      when others => null;
    end case;
    
  end process wrdecode;
  
  
  memwait : process(clk, res_n) is
    variable waited: boolean;
    constant waitclocks: integer := 2;
    variable waitedclocks: integer range 0 to waitclocks;
  begin
    if res_n = '0' then
      waitedclocks := 0;
    else
      if clk'event and clk = '1' then
        if not (rd or wr) then
          waitedclocks := 0;
        else
          if waitedclocks /= waitclocks then
            waitedclocks := waitedclocks + 1;
          end if;
        end if;
      end if;
    end if;
    
    if (rd or wr) and waitedclocks /= waitclocks then
      accesswait <= '1';
    else
      accesswait <= '0';
    end if;
  end process memwait;
  
  
END ARCHITECTURE behav;


