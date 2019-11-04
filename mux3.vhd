library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux3 is port(
	sel: in std_logic;
	IN0 : in std_logic_vector(9 downto 0);
	IN1 : in std_logic_vector(9 downto 0);
	S : buffer std_logic_vector(9 downto 0);
);
end mux3;

architecture hardware of mux3 is
begin
	WITH sel SELECT
		S <=	IN1 WHEN '1',
				IN0 WHEN OTHERS;
end hardware;