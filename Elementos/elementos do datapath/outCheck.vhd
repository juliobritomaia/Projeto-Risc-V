library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity outCheck is port(
	sel,enable: in std_logic;
	IN0 : in std_logic_vector(63 downto 0);
	S : buffer std_logic_vector(63 downto 0)
);
end outCheck;

architecture hardware of outCheck is
signal check : std_logic;
begin
	check <= sel and enable;
	WITH check SELECT
		S <=	IN0 WHEN '1',
				S WHEN OTHERS;
end hardware;