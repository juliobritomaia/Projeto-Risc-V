library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2to1 is port(
	sel: in std_logic;
	IN0,IN1: in std_logic_vector(7 downto 0);
	S: out std_logic_vector(7 downto 0)
);
end entity;

architecture design of mux2to1 is
begin

	WITH sel SELECT
		S <=	IN1 WHEN '1',
				IN0 WHEN OTHERS;
				
end architecture;