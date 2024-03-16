LIBRARY ieee;
USE ieee.std_logic_1164.all;

library audiotest_lib; use audiotest_lib.varfrequencydivider; use audiotest_lib.booleanvectors.all;


entity konamivrc6square is
  port(
    clk, res_n : in std_logic;
    cpuclk : in boolean;
		
    period : in boolean_vector(11 downto 0);
    volume : in boolean_nibble;
    dutycycle : in boolean_vector(2 downto 0);
    dacmode : in boolean;
    enable : in boolean;
		
    output: out boolean_nibble
  );
end konamivrc6square;

architecture behav of konamivrc6square is
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

  envelopegen : process(clk, res_n) is
    variable envelopestep: integer range 0 to 15;
  begin
    if res_n = '0' then
      envelopestep := 15;
    else
      if clk'event and clk = '1' then
        if not enable then
          envelopestep := 15;
        elsif advanceenvelope then
          if envelopestep /= 0 then
            envelopestep := envelopestep - 1;
          else
            envelopestep := 15;
          end if;
        end if;
      end if;
    end if;
		
    outputq <= dacmode or (envelopestep < bool_vec2integer(dutycycle) + 1);
  end process envelopegen;
	
  output <= volume when outputq and enable else (false, false, false, false);
end architecture behav;
