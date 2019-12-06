library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity writerControler is port(
	address: in std_logic_vector(2 downto 0);
	largura: in std_logic_vector(2 downto 0);
	wr: in std_logic;
	S: out std_logic_vector(7 downto 0)
);
end entity;

architecture design of writerControler is

signal vetor_wr : std_logic_vector(7 downto 0);

begin
	vetor_wr <=	"00000001" when (wr = '1') and (largura = "000") else
					"00000011" when (wr = '1') and (largura = "001") else
					"00001111" when (wr = '1') and (largura = "010") else
					"11111111" when (wr = '1') and (largura = "011") else
					"00000000";
					
	S <= std_logic_vector(rotate_left(unsigned(vetor_wr),to_integer(unsigned(address))));								
end architecture;