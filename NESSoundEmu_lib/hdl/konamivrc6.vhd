LIBRARY ieee;
USE ieee.std_logic_1164.all;

library audiotest_lib; use audiotest_lib.konamivrc6saw; use audiotest_lib.konamivrc6square; use audiotest_lib.boolstdlogicbusconverter; use audiotest_lib.booleanvectors.all;


entity konamivrc6 is
  port(
    clk, res_n : in std_logic;
    cpuclk : in boolean;
		
    rd : in boolean;
    wr : in boolean;
    addr : in boolean_vector(3 downto 0);
    data : inout std_logic_vector(7 downto 0);
    
    mix : out boolean_vector(5 downto 0)
  );
end konamivrc6;

architecture behav of konamivrc6 is
  signal haltablecpuclk : boolean;
  signal halt: boolean;
  
  signal p1period : boolean_vector(11 downto 0);
  signal p1volume : boolean_nibble;
  signal p1duty : boolean_vector(2 downto 0);
  signal p1dacmode : boolean;
  signal p1enable : boolean;
  
  signal p2period : boolean_vector(11 downto 0);
  signal p2volume : boolean_nibble;
  signal p2duty : boolean_vector(2 downto 0);
  signal p2dacmode : boolean;
  signal p2enable : boolean;
  
  signal sawperiod : boolean_vector(11 downto 0);
  signal sawaval : boolean_vector(5 downto 0);
  signal sawenable : boolean;
  
  signal p1out : boolean_nibble;
  signal p2out : boolean_nibble;
  signal sawout : boolean_vector(4 downto 0);
  
  signal datain : boolean_byte;
  signal dataout : boolean_byte;
begin
  
  
  pulse1 : entity konamivrc6square
    port map (
      clk => clk,
      res_n => res_n,
      
      cpuclk => haltablecpuclk,
      period => p1period,
      volume => p1volume,
      enable => p1enable,
      dacmode => p1dacmode,
      dutycycle => p1duty,
            
      output => p1out
    );
    
  pulse2 : entity konamivrc6square
    port map (
      clk => clk,
      res_n => res_n,
      
      cpuclk => haltablecpuclk,
      period => p2period,
      volume => p2volume,
      enable => p2enable,
      dacmode => p2dacmode,
      dutycycle => p2duty,
            
      output => p2out
    );
    
    
  saw : entity konamivrc6saw
    port map (
      clk => clk,
      res_n => res_n,
      
      cpuclk => haltablecpuclk,
      period => sawperiod,
      a => sawaval,
      enable => sawenable,
            
      output => sawout
    );
    
    
    
   busaccess : entity boolstdlogicbusconverter
    generic map (dataw => 8)
    port map (
      databus => data,
      datafrombus => datain,
      datatobus => dataout,
      putdataonbus => rd
    );

  writeport : process(clk, res_n) is
    variable p1periodreg : boolean_vector(11 downto 0);
    variable p2periodreg : boolean_vector(11 downto 0);
    variable sawperiodreg : boolean_vector(11 downto 0);
    
    variable divideperiodby16 : boolean;
    variable divideperiodby256 : boolean;
  begin
    if res_n = '0' then
      divideperiodby16 := false;
      divideperiodby256 := false;
      
      p1periodreg := (others => false);
      p1volume <= (others => false);
      p1duty <= (others => false);
      p1dacmode <= false;
      p1enable <= false;

      p2periodreg := (others => false);
      p2volume <= (others => false);
      p2duty <= (others => false);
      p2dacmode <= false;
      p2enable <= false;
  
      sawperiodreg := (others => false);
      sawaval <= (others => false);
      sawenable <= false;
  
      halt <= false;
    else
      if clk'event and clk = '1' then
        if wr then
          case bool_vec2integer(addr) is
            -- pulse 1 registers
            when 0 => -- corresponds to $9000
              p1dacmode <= datain(7);
              p1duty <= datain(6 downto 4);
              p1volume <= datain(3 downto 0);
            when 1 => -- corresponds to $9001
              p1periodreg(7 downto 0) := datain;
            when 2 => -- corresponds to $9002
              p1periodreg(11 downto 8) := datain(3 downto 0);
              p1enable <= datain(7);
            when 3 => -- corresponds to $9003
              halt <= datain(0);
              divideperiodby16 := datain(1);
              divideperiodby256 := datain(2);
              
            -- pulse 2 registers  
            when 4 => -- corresponds to $A000
              p2dacmode <= datain(7);
              p2duty <= datain(6 downto 4);
              p2volume <= datain(3 downto 0);
            when 5 => -- corresponds to $A001
              p2periodreg(7 downto 0) := datain;
            when 6 => -- corresponds to $A002
              p2periodreg(11 downto 8) := datain(3 downto 0);
              p2enable <= datain(7);
              
            -- sawtooth registers  
            when 8 => -- corresponds to $B000
              sawaval <= datain(5 downto 0);
            when 9 => -- corresponds to $B001
              sawperiodreg(7 downto 0) := datain;
            when 10 => -- corresponds to $B002
              sawperiodreg(11 downto 8) := datain(3 downto 0);
              sawenable <= datain(7);
             
            when others => null;
          end case;
        end if;
      end if;
    end if;
    
    if not (divideperiodby16 or divideperiodby256) then
      p1period <= p1periodreg;
      p2period <= p2periodreg;
      sawperiod <= sawperiodreg;
    elsif divideperiodby256 then
      p1period <= (false, false, false, false, false, false, false, false) & p1periodreg(11 downto 8);
      p2period <= (false, false, false, false, false, false, false, false) & p2periodreg(11 downto 8);
      sawperiod <= (false, false, false, false, false, false, false, false) &  sawperiodreg(11 downto 8);
    else
      p1period <= (false, false, false, false) & p1periodreg(11 downto 4);
      p2period <= (false, false, false, false) & p2periodreg(11 downto 4);
      sawperiod <= (false, false, false, false) & sawperiodreg(11 downto 4);
    end if;
  end process writeport;
  
  
  haltablecpuclk <= cpuclk when not halt else false;
  mix <= integer2bool_vec(bool_vec2integer(p1out) + bool_vec2integer(p2out) + bool_vec2integer(sawout), 6);
	
end architecture behav;
