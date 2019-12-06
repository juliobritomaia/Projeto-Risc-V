library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inCheck is port(
	sel,enable: in std_logic;
	IN0,IN1 : in std_logic_vector(63 downto 0);
	S : out std_logic_vector(63 downto 0)
);
end inCheck;

architecture hardware of inCheck is
signal check : std_logic;
begin
	check <= sel and enable;
	WITH check SELECT
		S <=	IN1 WHEN '1',
				IN0 WHEN OTHERS;
end hardware;