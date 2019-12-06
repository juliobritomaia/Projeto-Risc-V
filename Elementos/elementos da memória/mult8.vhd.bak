library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult8 is port(
	entrada: in std_logic_vector(2 downto 0);
	saida: out integer range 0 to 56
);
end entity;

architecture design of mult8 is

signal aux: std_logic_vector(5 downto 0) := "000" & entrada;

begin
	saida <= to_integer(shift_left(unsigned(aux),3));
end architecture;