library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity deslocador is port(
	multiplicador: in std_logic_vector(2 downto 0);
	entrada: in std_logic_vector(63 downto 0);
	sel_muxes: out std_logic_vector(6 downto 0);
	saida: out std_logic_vector(119 downto 0)
);
end entity;

architecture design of deslocador is

signal sinal: std_logic_vector(119 downto 0) := "00000000000000000000000000000000000000000000000000000000" & entrada;
signal deslocamento: integer range 0 to 56;

component mult8 port(
	entrada: in std_logic_vector(2 downto 0);
	saida: out integer range 0 to 56
);
end component;

begin

	WITH multiplicador SELECT
		sel_muxes <=	"1111111" WHEN "111",
							"0111111" WHEN "110",
							"0011111" WHEN "101",
							"0001111" WHEN "100",
							"0000111" WHEN "011",
							"0000011" WHEN "010",
							"0000001" WHEN "001",
							"0000000" WHEN OTHERS;
				
mult: mult8 port map(
	entrada => multiplicador,
	saida => deslocamento
);

saida <= std_logic_vector(shift_left(unsigned(sinal),deslocamento));

end architecture;