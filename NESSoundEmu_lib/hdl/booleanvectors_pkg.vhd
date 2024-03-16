--
-- VHDL Package Header audiotest_lib.booleanvectors
--
-- Created:
--          by - redacted.redacted (pc025)
--          at - 14:00:53 01/17/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;


PACKAGE booleanvectors IS
  --type boolean_vector is array(natural range <>) of boolean;
  subtype boolean_nibble is boolean_vector(3 downto 0);
  subtype boolean_byte  is boolean_vector(7 downto 0);
  subtype boolean_halfword is boolean_vector(15 downto 0);
  subtype boolean_word is boolean_vector(31 downto 0);
  pure function bool_vec2std_logic_vector(a: boolean_vector) return std_logic_vector;
  pure function std_logic_vector2bool_vec(a: std_logic_vector) return boolean_vector;
  pure function bool_vec2integer(a: boolean_vector) return integer;
  pure function integer2bool_vec(a: integer; n:positive) return boolean_vector;
END booleanvectors;
