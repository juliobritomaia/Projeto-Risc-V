library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity addressSignal is port(
	sel: in std_logic;
	enable: std_logic_vector(1 downto 0);
	address : in std_logic_vector(13 downto 0);
	S : buffer std_logic_vector(13 downto 0)
);
end addressSignal;

architecture hardware of addressSignal is
signal check : std_logic;
begin
	check <= sel and (enable(0) or enable(1));
	WITH check SELECT
		S <=	address WHEN '1',
				S WHEN OTHERS;
end hardware;