library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity concatenador is port(
	entrada: in std_logic_vector(63 downto 0);
	address,largura: in std_logic_vector(2 downto 0);
	wr: in std_logic;
	saida: buffer std_logic_vector(63 downto 0)
);
end entity;

architecture design of concatenador is

signal organizar: std_logic_vector(63 downto 0);
signal aux: std_logic_vector(5 downto 0) := "000"&address;
signal multiplicador: integer range 0 to 56;

begin

multiplicador <= to_integer(shift_left(unsigned(aux),3));
organizar <= std_logic_vector(rotate_right(unsigned(entrada),multiplicador));

saida <= std_logic_vector(resize(signed(organizar(7 downto 0)),saida'length)) when (largura = "000") and (wr = '0') else
			std_logic_vector(resize(signed(organizar(15 downto 0)),saida'length)) when (largura = "001") and (wr = '0') else
			std_logic_vector(resize(signed(organizar(31 downto 0)),saida'length)) when (largura = "010") and (wr = '0') else
			organizar when (largura = "011") and (wr = '0') else
			std_logic_vector(resize(unsigned(organizar(7 downto 0)),saida'length)) when (largura = "100") and (wr = '0') else
			std_logic_vector(resize(unsigned(organizar(15 downto 0)),saida'length)) when (largura = "101") and (wr = '0') else
			std_logic_vector(resize(unsigned(organizar(31 downto 0)),saida'length)) when (largura = "110") and (wr = '0') else
			saida;
			
end architecture;