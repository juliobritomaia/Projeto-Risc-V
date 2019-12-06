library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity addressControler is port(
	address: in std_logic_vector(13 downto 0);
	S: out std_logic_vector(87 downto 0)
);
end entity;

architecture design of addressControler is

signal pula : std_logic_vector(13 downto 3);

begin
	pula <= std_logic_vector(unsigned(address(13 downto 3))+1);
	WITH sel SELECT
		S <=	IN1 WHEN '1',
				IN0 WHEN OTHERS;
				
end architecture;