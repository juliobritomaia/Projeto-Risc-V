library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is port(
	sel: in std_logic;
	IN0 : in std_logic_vector(63 downto 0);
	IN1 : in std_logic_vector(63 downto 0);
	S : buffer std_logic_vector(63 downto 0)
);
end mux;

architecture hardware of mux is
begin
	WITH sel SELECT
		S <=	IN1 WHEN '1',
				IN0 WHEN OTHERS;
end hardware;