library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity deslocador is port(
	multiplicador: in std_logic_vector(2 downto 0);
	entrada: in std_logic_vector(63 downto 0);
	saida: out std_logic_vector(63 downto 0)
);
end entity;

architecture design of deslocador is

signal deslocamento: integer range 0 to 56;

component mult8 port(
	entrada: in std_logic_vector(2 downto 0);
	saida: out integer range 0 to 56
);
end component;

begin
				
mult: mult8 port map(
	entrada => multiplicador,
	saida => deslocamento
);

saida <= std_logic_vector(rotate_left(unsigned(entrada),deslocamento));

end architecture;