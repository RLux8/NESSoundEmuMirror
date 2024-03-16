--
-- VHDL Architecture audiotest_lib.bankswitcher.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 11:23:56 01/29/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ARCHITECTURE behav OF bankswitcher IS
  type maparrayT is array(0 to 7) of integer;
  signal maparray: maparrayT;
  signal bankingen: boolean;
  signal physoffset: boolean_vector(23 downto 0);
  
  constant songROMsize: natural := 2**18 + 2**17;
  constant banksize: natural := 2**12;
BEGIN
  registers : process(clk, res_n) is 
    variable addrint: integer;
    
  begin
    if res_n = '0' then
      maparray <= (0, 1, 2, 3, 4, 5, 6, 7);
      physoffset <= (others => false);
      bankingen <= true;
    else
      if clk'event and clk = '1' then
        if wr then
          addrint := bool_vec2integer(confaddr);
          if addrint > 7 then
            maparray(addrint - 8) <= bool_vec2integer(confdata);
          elsif addrint = 0 then
            physoffset(7 downto 0) <= confdata;
          elsif addrint = 1 then
            physoffset(15 downto 8) <= confdata;
          elsif addrint = 2 then
            physoffset(23 downto 16) <= confdata;
          elsif addrint = 4 then
            bankingen <= confdata(0); 
          end if;
          
        end if;
      end if;
    end if;
  end process registers;
  
  
  mapper : process(all) is
    variable physaddrraw: integer;
    variable offsetphy: integer;
  begin
    if bankingen then
      physaddrraw := maparray(bool_vec2integer(virtaddr(14 downto 12)))*banksize + bool_vec2integer(virtaddr(11 downto 0)); 
    else
      physaddrraw := bool_vec2integer(virtaddr(14 downto 0));
    end if;
    
    
    if physaddrraw + bool_vec2integer(physoffset) < 2**24 then
      
      offsetphy := physaddrraw + bool_vec2integer(physoffset);
    else
      offsetphy := physaddrraw + bool_vec2integer(physoffset) - 2**24;
    end if;
    
    
    if offsetphy < songROMsize then
      physaddr <= integer2bool_vec(offsetphy, physaddr'high+1);
    else
      physaddr <= (others => false);
    end if;
  end process mapper;
END ARCHITECTURE behav;

