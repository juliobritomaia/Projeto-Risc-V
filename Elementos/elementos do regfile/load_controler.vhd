library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity load_controler is port(
	address: in std_logic_vector(4 downto 0);
	enable: in std_logic;
	load: out std_logic_vector(31 downto 0)
);
end entity;

architecture projeto of load_controler is

signal valor : std_logic_vector(31 downto 0) := "00000000000000000000000000000001";

begin
	load <= 	std_logic_vector(shift_left(unsigned(valor),to_integer(unsigned(address)))) when enable = '1' else
				valor;
end projeto;
