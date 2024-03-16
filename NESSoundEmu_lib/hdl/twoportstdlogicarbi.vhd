LIBRARY ieee;
USE ieee.std_logic_1164.all;
library audiotest_lib; use audiotest_lib.booleanvectors.all;

ENTITY twoportarbstdlogic IS
   GENERIC( 
      addrw : integer := 16;
      dataw : integer := 8
   );
   PORT( 
      Aaddr        : IN     boolean_vector (addrw-1 DOWNTO 0);
      Adatafromdev : IN     boolean_vector (dataw-1 DOWNTO 0) := (others => false);
      Areqread     : IN     boolean := false;
      Areqwrite    : IN     boolean := false;
      Baddr        : IN     boolean_vector (addrw-1 DOWNTO 0);
      Bdatafromdev : IN     boolean_vector (dataw-1 DOWNTO 0) := (others => false);
      Breqread     : IN     boolean := false;
      Breqwrite    : IN     boolean := false;
      accesswait   : IN     std_logic;
      clk          : IN     std_logic;
      res_n        : IN     std_logic;
      Aackread     : OUT    boolean;
      Aackwrite    : OUT    boolean;
      Adatatodev   : OUT    boolean_vector (dataw-1 DOWNTO 0);
      Backread     : OUT    boolean;
      Bdatatodev   : OUT    boolean_vector (dataw-1 DOWNTO 0);
      addr         : OUT    boolean_vector (addrw-1 DOWNTO 0);
      backwrite    : OUT    boolean;
      rd           : OUT    boolean;
      wr           : OUT    boolean;
      data         : INOUT  std_logic_vector (dataw-1 DOWNTO 0)
   );

-- Declarations

END twoportarbstdlogic ;


ARCHITECTURE behav OF twoportarbstdlogic IS
  type portidT is (NONE, AID, BID);
  signal activePort: portidT;
  type stateT is (WAITINGFORREQ, SETTINGDATA, HANDLINGREQ, COMPLETINGREQ);
  signal currentstate: stateT;
  signal reqisWriteReq: boolean;
  

BEGIN
  accessArbiterfsmtransistion : process(clk, res_n) is
    variable currentstate_int: stateT;
  begin
    if res_n = '0' then
      currentstate_int := WAITINGFORREQ;
    else
      if clk'event and clk = '1' then
        case currentstate_int is
          when WAITINGFORREQ =>
            if (Areqread or Areqwrite) then
              currentstate_int := HANDLINGREQ;
              activePort <= AID;
            end if;
            
            if (Breqread or Breqwrite) then
              currentstate_int := HANDLINGREQ;
              activePort <= BID;
            end if;
            
          
            reqisWriteReq <= Areqwrite or Breqwrite;
            
            if Areqwrite or Breqwrite then
              currentstate_int := SETTINGDATA;
            end if;
          when SETTINGDATA => currentstate_int := HANDLINGREQ;
          when HANDLINGREQ =>
            if accesswait /= '1' then
              currentstate_int := COMPLETINGREQ;
            end if;
          when COMPlETINGREQ => currentstate_int := WAITINGFORREQ;
        end case;
          
      end if;
    end if;
    currentstate <= currentstate_int;
  end process accessArbiterfsmtransistion;
  
  
  registeredoutputs : process(clk, res_n) is
  begin
    if res_n = '0' then
      Adatatodev <= (others => false);
      Bdatatodev <= (others => false); 
    else
      if clk'event and clk = '1' then
        --if currentstate = HANDLINGREQ or currentstate = COMPLETINGREQ then
        if currentstate = HANDLINGREQ then
          case activeport is
            when AID => Adatatodev <= std_logic_vector2bool_vec(data);
            when BID => Bdatatodev <= std_logic_vector2bool_vec(data);
            when NONE => null;
          end case;
        end if;
      end if;
    end if;
  end process registeredoutputs;
  
  unregisterdouts : process(all) is
  begin
    Aackread <= false;
    Aackwrite <= false;
    Backread <= false;
    Backwrite <= false;
    wr <= false;
    rd <= false;
        
    case currentstate is
      when WAITINGFORREQ => 
        Aackread <= false;
        Aackwrite <= false;
        Backread <= false;
        Backwrite <= false;
      
      when SETTINGDATA => null;
      when HANDLINGREQ => 
        if activeport /= NONE then
          wr <= reqisWriteReq;
          rd <= not reqisWriteReq;
        end if;
      when COMPLETINGREQ =>
        wr <= false;
        rd <= false;
        case activeport is
          when AID => Aackread <= Areqread;
                      Aackwrite <= Areqwrite;
          when BID => Backread <= Breqread;
                      Backwrite <= Breqwrite;
          when NONE => null;
        end case;
    end case;
    
    
    if reqisWritereq and ((currentstate = HANDLINGREQ) or (currentstate = SETTINGDATA)) then
      case activeport is
        when AID => data <= bool_vec2std_logic_vector(Adatafromdev);
        when BID => data <= bool_vec2std_logic_vector(Bdatafromdev);
        when NONE => data <= "ZZZZZZZZ";
      end case;
    else
      data <= "ZZZZZZZZ";
    end if;
    
    if activeport = AID then
      addr <= Aaddr;
    else
      addr <= Baddr;
    end if;
  end process unregisterdouts;

END ARCHITECTURE behav;
