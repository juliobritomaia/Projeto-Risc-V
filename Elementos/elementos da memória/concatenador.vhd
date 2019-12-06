library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity concatenador is port(
	entrada: in std_logic_vector(63 downto 0);
	address,largura: in std_logic_vector(2 downto 0);
	saida: buffer std_logic_vector(63 downto 0)
);
end entity;

architecture design of concatenador is

signal organizar: std_logic_vector(63 downto 0);

begin
--slv_16 <= std_logic_vector(resize(signed(slv_8), slv_16'length));
organizar <= std_logic_vector(rotate_right(unsigned(entrada),to_integer(unsigned(address))));

saida <= std_logic_vector(resize(signed(organizar(7 downto 0))),saida'length) when (largura = "000") else
			std_logic_vector(resize(signed(organizar(15 downto 0))),saida'length) when (largura = "001") else
			std_logic_vector(resize(signed(organizar(31 downto 0))),saida'length) when (largura = "010") else
			organizar when (largura = "011") else
			std_logic_vector(resize(unsigned(organizar(7 downto 0))),saida'length) when (largura = "100") else
			std_logic_vector(resize(unsigned(organizar(15 downto 0))),saida'length) when (largura = "101") else
			std_logic_vector(resize(unsigned(organizar(31 downto 0))),saida'length) when (largura = "110") else
			saida;
			
end architecture;