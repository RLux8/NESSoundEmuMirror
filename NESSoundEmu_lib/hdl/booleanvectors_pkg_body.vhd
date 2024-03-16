--
-- VHDL Package Body audiotest_lib.booleanvectors
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 13:59:45 01/17/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE IEEE.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

PACKAGE BODY booleanvectors IS
   pure function bool_vec2std_logic_vector(a: boolean_vector) return std_logic_vector is
      variable result: std_logic_vector(a'high downto a'low);
    begin
      result := (others => '0');
      for n in a'range loop
        if a(n) then
          result(n) := '1';
        else
          result(n) := '0';
        end if;
      end loop;
      return result;
    end function bool_vec2std_logic_vector;
  
    pure function std_logic_vector2bool_vec(a: std_logic_vector) return boolean_vector is
      variable result: boolean_vector(a'range);
    begin
      result := (others => false);
      for n in a'range loop
        if a(n) = '1' then
          result(n) := true;
        else
          result(n) := false;
        end if;
      end loop;
      return result;
    end function std_logic_vector2bool_vec;
    
    pure function bool_vec2integer(a: boolean_vector) return integer is
      variable result: std_logic_vector(a'range);
    begin
      result := (others => '0');
      for n in a'range loop
        if a(n) then
          result(n) := '1';
        else
          result(n) := '0';
        end if;
      end loop;
      return to_integer(unsigned(result));
    end function bool_vec2integer;
    
    
    pure function integer2bool_vec(a: integer; n: positive) return boolean_vector is
      variable result: boolean_vector(n-1 downto 0);
      variable resultprec: std_logic_vector(n-1 downto 0);
    begin
      resultprec := std_logic_vector(to_unsigned(a, n));
      result := (others => false);
      for n in resultprec'range loop
        if resultprec(n) = '1' then
          result(n) := true;
        else
          result(n) := false;
        end if;
      end loop;
      return result;
    end function integer2bool_vec;
    
END booleanvectors;
