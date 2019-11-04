library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux1 is port(
	sel: in std_logic;
	IN0 : in std_logic_vector(31 downto 0);
	IN1 : in std_logic_vector(63 downto 0);
	S : buffer std_logic_vector(63 downto 0)
);
end mux1;

architecture hardware of mux1 is
signal extensao : std_logic_vector(31 downto 0);
begin
	WITH IN0(31) SELECT
		extensao <=	"11111111111111111111111111111111" WHEN '1',
						"00000000000000000000000000000000" WHEN OTHERS;
	WITH sel SELECT
		S <=	IN1 WHEN '1',
				extensao & IN0 WHEN OTHERS;
end hardware;