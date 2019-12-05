library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux3 is port(
	sel: in std_logic_vector(1 downto 0);
	IN0 : in std_logic_vector(31 downto 0);
	IN1 : in std_logic_vector(63 downto 0);
	S : buffer std_logic_vector(31 downto 0)
);
end mux3;

architecture hardware of mux3 is
signal ext32: std_logic_vector(31 downto 0);
begin
	WITH IN0(31) SELECT
		ext32 <=	"11111111111111111111111111111111" WHEN '1',
					"00000000000000000000000000000000" WHEN OTHERS;

	WITH sel SELECT
		S <=	IN1(31 downto 0) WHEN "11", --jalr/alu
				ext32(10 downto 0) & IN0(31) & IN0(19 downto 12)& IN0(20) & IN0(30 downto 25) & IN0(24 downto 21) & '0' WHEN "01", --jal
				ext32(18 downto 0) & IN0(31) & IN0(7) & IN0(30 downto 25) & IN0(11 downto 8) & '0' WHEN "00", --branchs
				S WHEN OTHERS;
end hardware;