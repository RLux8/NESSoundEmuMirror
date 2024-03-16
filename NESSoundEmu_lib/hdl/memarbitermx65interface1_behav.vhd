--
-- VHDL Architecture audiotest_lib.memarbitermx65interface1.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 12:59:00 02/05/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ARCHITECTURE behav OF memarbitermx65interface IS
BEGIN
  process(clk, res_n) is 
    variable lastaddr: std_logic_vector(ADDRW - 1 downto 0);
    variable lastdata: std_logic_vector(DATAW - 1 downto 0);
    variable waitingforread: boolean;
    variable waitingforwrite: boolean;
    variable lastmode: std_logic;
  begin
    if res_n = '0' then
      lastaddr := (others => '0');
      lastdata := (others => '0');
      lastmode := '1';
    else
      if clk'event and clk = '1' then
        --check for a memory request
        if (lastaddr /= cpu_addr or lastmode /= rw or (rw = '0' and lastmode = '0' and  lastdata /= cpu_data_out)) and not (waitingforwrite or waitingforread) then
          if rw = '0' then -- 0 is a write
            waitingforwrite := true;
          else
            waitingforread := true;
          end if;
          
          lastaddr := cpu_addr;
          lastmode := rw;
          lastdata := cpu_data_out;
        end if;
        
        
        if waitingforwrite and cpuportackwrite then
          waitingforwrite := false;
        end if;
        
        if waitingforread and cpuportackread then
          cpu_data_in <= bool_vec2std_logic_vector(cpuportdatatodev);
          waitingforread := false;
        end if;
        
        
      end if;
    end if;
  
  
  cpuportreqread <= waitingforread;
  cpuportreqwrite <= waitingforwrite;
  cpuportdatafromdev <= std_logic_vector2bool_vec(cpu_data_out);
  cpuportaddr <= std_logic_vector2bool_vec(cpu_addr);
  
  if tickCPU and not (waitingforread or waitingforwrite) then
    tick <= '1';
  else
    tick <= '0';
  end if;
  end process;
  
END ARCHITECTURE behav;

