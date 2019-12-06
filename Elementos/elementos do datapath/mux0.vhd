library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux0 is port(
	sel: in std_logic_vector(1 downto 0);
	IN0 : in std_logic_vector(11 downto 0);
	IN1 : in std_logic_vector(63 downto 0);
	IN2 : in std_logic_vector(63 downto 0);
	S : buffer std_logic_vector(63 downto 0)
);
end mux0;

architecture hardware of mux0 is
signal extensao : std_logic_vector(31 downto 0);
begin
	WITH IN0(11) SELECT
		extensao <=	"11111111111111111111111111111111" WHEN '1',
						"00000000000000000000000000000000" WHEN OTHERS;
	WITH sel SELECT
		S <=	IN2 WHEN "10", --ALU
				IN1 WHEN "01", --
				extensao & extensao(31 downto 12) & IN0 WHEN OTHERS; --
end hardware;