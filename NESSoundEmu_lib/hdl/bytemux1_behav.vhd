--
-- VHDL Architecture audiotest_lib.bytemux1.behav
--
-- Created:
--          by - redacted.redacted (pc023)
--          at - 16:51:24 01/30/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF bytemux1 IS
BEGIN
   process(addr, qw) is
  begin
    address <= bool_vec2std_logic_vector(addr(18 downto 3));
    case bool_vec2integer(addr(2 downto 0)) is 
      when 0 => q <= std_logic_vector2bool_vec(qw(7 downto 0));
      when 1 => q <= std_logic_vector2bool_vec(qw(15 downto 8));
      when 2 => q <= std_logic_vector2bool_vec(qw(23 downto 16));
      when 3 => q <= std_logic_vector2bool_vec(qw(31 downto 24));
      when 4 => q <= std_logic_vector2bool_vec(qw(39 downto 32));
      when 5 => q <= std_logic_vector2bool_vec(qw(47 downto 40));
      when 6 => q <= std_logic_vector2bool_vec(qw(55 downto 48));
      when 7 => q <= std_logic_vector2bool_vec(qw(63 downto 56));
      when others => null;
    end case;
  end process;
END ARCHITECTURE behav;

