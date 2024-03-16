--
-- VHDL Architecture audiotest_lib.testsoundctrl1.behav
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 16:43:04 12/18/23
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all;
library ieee; use ieee.numeric_std.all; use ieee.std_logic_1164.all;

ARCHITECTURE behav OF testsoundctrl1 IS
BEGIN
  process(clk, res_n) is
    type stateT is (INIT, RUNNING);
    variable state: stateT;
    
    constant N: natural := 16;
    subtype sawaccumT is natural range 0 to 2**N; 
    variable saw: sawaccumT;
    
    subtype dacvolumeT is natural range 0 to 127; 
    variable bothvolumes: dacvolumeT;
    variable allzeros: std_logic_vector(l_data_tx'high - mix'high - 1 downto 0);
    
  begin
    if res_n = '0' then
      state := INIT;
      leftadcvol <= std_logic_vector(to_unsigned(63, 6));
      rightadcvol <= std_logic_vector(to_unsigned(63, 6));
      bothvolumes := 0;
      update <= '0';
      allzeros := (others => '0');
      resetCPU <= false;
      runCPU <= true;
    else
      if clk'event and clk = '1' then
        if state = INIT then
          if ready = '1' then
            state := RUNNING;
          end if;
        elsif state = RUNNING then
          --runCPU <= true;
        end if;
      end if;
    end if;
    l_data_tx <= std_logic_vector(bool_vec2std_logic_vector(mix) & allzeros);
    r_data_tx <= std_logic_vector(bool_vec2std_logic_vector(mix) & allzeros);
    leftdacvol <= std_logic_vector(to_unsigned(bothvolumes, 7));
    rightdacvol <= std_logic_vector(to_unsigned(bothvolumes, 7));
    
  end process;
  runCPU <= true;
END ARCHITECTURE behav;



