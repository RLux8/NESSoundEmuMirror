--
-- VHDL Architecture audiotest_lib.namco163tbctrl.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 10:34:16 02/19/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF namco163tbctrl IS
  type stateT is (INIT, SETADDRREGWAV, STORETRIWAVE1, STORETRIWAVE2, STORETRIWAVE3, STORETRIWAVE4, STORETRIWAVE5, STORETRIWAVE6, STORETRIWAVE7, STORETRIWAVE8, SETADDRREGCTRL, SETLF, SETLP, SETMF, SETMP, SETHF, SETHP, SETADDR, SETVOL, ENABLESOUND, DONE);
  signal currentstate: stateT;
  
  signal tristoreprog: integer range 0 to 16;
  signal wrreg: boolean;
BEGIN
  fsm_tr : process(clk, res_n) is
  begin
    if res_n = '0' then
      currentstate <= INIT;
      tristoreprog <= 0;
    else
      if clk'event and clk = '1' then
        if currentstate /= stateT'right and tick then
          currentstate <= stateT'succ(currentstate);
        end if;
      end if;
    end if;
  end process fsm_tr;
  
  wr <= wrreg and tick;
  
  fsm_out: process(currentstate) is
  begin
    wrreg <= false;
    rd <= false;
    addr <= (false, false);
    case currentstate is
      when INIT => data <= (others => '0');
      when SETADDRREGWAV => 
        data <= X"80";
        addr <= (true, true);
        wrreg <= true;
      
      
      when STORETRIWAVE1 =>
        data <= X"10";
        wrreg <= true;
        
      when STORETRIWAVE2 =>
        data <= X"32";
        wrreg <= true;
        
      when STORETRIWAVE3 =>
        data <= X"54";
        wrreg <= true;
        
      when STORETRIWAVE4 =>
        data <= X"76";
        wrreg <= true;
        
      when STORETRIWAVE5 =>
        data <= X"98";
        wrreg <= true;
        
      when STORETRIWAVE6 =>
        data <= X"BA";
        wrreg <= true;
        
      when STORETRIWAVE7 =>
        data <= X"DC";
        wrreg <= true;
        
      when STORETRIWAVE8 =>
        data <= X"FE";
        wrreg <= true;
        
      when SETADDRREGCTRL =>  
        data <= X"F8";
        addr <= (true, true);
        wrreg <= true;
      
      when SETLF => 
        data <= X"55";
       wrreg <= true;
      when SETLP => 
        data <= X"00";
        wrreg <= true;
      when SETMF => 
        data <= X"55";
        wrreg <= true;
      when SETMP => 
        data <= X"00";
        wrreg <= true;
      when SETHF => 
        data <= B"11110000";
        wrreg <= true;
      when SETHP => 
        data <= X"00";
        wrreg <= true;
      when SETADDR => 
        data <= X"00";
        wrreg <= true;
      when SETVOL => 
        data <= X"09";
        wrreg <= true;

      when ENABLESOUND => 
        data <= X"00";
        addr <= (true, false);
        wrreg <= true;
                
      when DONE => null;
    end case;
  end process;
END ARCHITECTURE behav;

