library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux0 is port(
	sel: in std_logic_vector(1 downto 0);
	IN0 : in std_logic_vector(9 downto 0);
	IN1 : in std_logic_vector(63 downto 0);
	IN2 : in std_logic_vector(63 downto 0);
	S : buffer std_logic_vector(63 downto 0)
);
end mux0;

architecture hardware of mux0 is
signal extensao : std_logic_vector(31 downto 0);
begin
	WITH IN0(9) SELECT
		extensao <=	"11111111111111111111111111111111" WHEN '1',
						"0" WHEN OTHERS;
	WITH sel SELECT
		S <=	IN2 WHEN "10",
				IN1 WHEN "01",
				extensao & extensao(31 downto 10) & IN0 WHEN OTHERS;
end hardware;