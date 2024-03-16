--
-- VHDL Architecture audiotest_lib.framecounter.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 16:36:17 01/23/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF framecounter IS
  signal intactivate: boolean;
BEGIN
   framectr : process(clk, res_n) is
    --variable apuclkcounter: natural range 0 to 20783; -- use PAL divider ratios
    --constant Step1val: natural := 4156;
    --constant Step2val: natural := 8313;
    --constant Step3val: natural := 12469;
    --constant Step4val: natural := 16626;
    --constant Step5val: natural := 20782;
    variable apuclkcounter: natural range 0 to 20783;
    constant Step1val: natural := 3728;
    constant Step2val: natural := 7456;
    constant Step3val: natural := 11185;
    constant Step4val: natural := 14914;
    constant Step5val: natural := 18641;
    
  begin
    if res_n = '0' then
      apuclkcounter := 0;
    else
      if clk'event and clk = '1' then
        
        qfclk <= false;
        hfclk <= false;
        fclk <= false;
        
        intactivate <= false;
        if resctr then
          apuclkcounter := 0;
          if mode then
            hfclk <= true;
            qfclk <= true;
          end if;
        end if;
        if apuclk then
          if mode then -- 5 step mode
            if apuclkcounter = Step5val then
              intactivate <= true;
              hfclk <= true;
              qfclk <= true;
              fclk <= true;
            end if;
          else -- 4 step mode
            if apuclkcounter = Step4val then
              hfclk <= true;
              qfclk <= true;
              fclk <= true;
              intactivate <= genint;
            end if;
          end if;
          
          if apuclkcounter = Step1val or apuclkcounter = Step3val then
            qfclk <= true;
          end if;
          
          
          if apuclkcounter = Step2val then
            hfclk <= true;
            qfclk <= true;
          end if;
          
          
          if (mode and apuclkcounter = Step5val) or (not mode and apuclkcounter = Step4val) then
            apuclkcounter := 0;
          else
            apuclkcounter := apuclkcounter + 1;
          end if;
        end if;
      end if;
    end if;
  end process framectr;
  
  
  intflag : process(clk, res_n) is
    variable intactive: boolean;
    variable last_intactivate: boolean;
  begin
    if res_n = '0' then
      last_intactivate := false;
      frameint <= false;
    else
      if clk'event and clk = '1' then
        if clearintflag then
          frameint <= false;
        end if;
        
        if intactivate and not last_intactivate then
          frameint <= true;
        end if;
        
        last_intactivate := intactivate;
      end if;
    end if;
  end process intflag;
END ARCHITECTURE behav;

