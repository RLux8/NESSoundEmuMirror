LIBRARY ieee;
USE ieee.std_logic_1164.all;

library audiotest_lib; use audiotest_lib.varfrequencydivider; use audiotest_lib.booleanvectors.all;

entity konamivrc6saw is
  port(
    clk, res_n : in std_logic;
    cpuclk : in boolean;
		
    period : in boolean_vector(11 downto 0);
    a : in boolean_vector(5 downto 0);
    enable : in boolean;
		
    output: out boolean_vector(4 downto 0)
  );
end konamivrc6saw;

architecture behav of konamivrc6saw is
  signal outputq: boolean;
  signal advanceenvelope: boolean;
begin
  frequencydivider : entity varfrequencydivider
    generic map ( MAX => 4095)
    port map(
      clk => clk,
      res_n => res_n,
	     
      tick => cpuclk,
      enable => enable,
      period => period,
	     
      tock => advanceenvelope
    );

  sawaccum : process(clk, res_n) is
    variable sawaccumulator : integer range 0 to 255;
    variable accumulationstep: natural range 0 to 13;
  begin
    if res_n = '0' then
      sawaccumulator := 0;
      accumulationstep := 0;
    else
      if clk'event and clk = '1' then
        if not enable then
          sawaccumulator := 0;
        elsif advanceenvelope then
          if accumulationstep /= 13 then
            accumulationstep := accumulationstep + 1;
          else
            accumulationstep := 0;
            sawaccumulator := 0;
          end if;
          
          if accumulationstep = 0 then
            null;
          elsif accumulationstep mod 2 = 0 then
            sawaccumulator := sawaccumulator + bool_vec2integer(a);
          end if;
        end if;
      end if;
    end if;
		
    --output <= (integer2bool_vec(sawaccumulator, 8)(7 downto 2)) when enable else (false, false, false, false, false);
    if enable then
      output <= (integer2bool_vec(sawaccumulator, 8)(7 downto 3));
    else
      output <= (others => false);
    end if;
  end process sawaccum;
	
end architecture behav;
