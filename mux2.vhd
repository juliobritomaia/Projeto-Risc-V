library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2 is port(
	sel: in std_logic;
	IN0 : in std_logic_vector(9 downto 0);
	IN1 : in std_logic_vector(63 downto 0);
	S : buffer std_logic_vector(63 downto 0);
);
end mux2;

architecture hardware of mux2 is
begin
	WITH sel SELECT
		S <=	IN1 WHEN '1',
				"00000000000000000000000000000000" & "0000000000000000000000" & IN0 WHEN OTHERS;
end hardware;