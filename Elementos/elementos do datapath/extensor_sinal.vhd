library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity extensor_sinal is port(
	contador: in std_logic_vector(11 downto 0);
	instrucao: in std_logic_vector(31 downto 0);
	
	contador_64: out std_logic_vector(63 downto 0);
	instrucao_64: out std_logic_vector(63 downto 0)
);
end entity;

architecture design of extensor_sinal is

signal opcode : std_logic_vector(6 downto 0);
signal func3 : std_logic_vector(2 downto 0);

signal tipoU : std_logic_vector(31 downto 0);
signal tipoJ : std_logic_vector(20 downto 0);
signal tipoB : std_logic_vector(12 downto 0);
signal tipoS : std_logic_vector(11 downto 0);
signal tipoI : std_logic_vector(11 downto 0);

--subtipos I, --i - 0 --iu - 1
--U-2, J-3, B-4, S-5, R-(nao tem imediato)
signal tipo: integer range 0 to 5;

begin

	opcode <= instrucao(6 downto 0);
	func3 <= instrucao(14 downto 12);
	
	tipoU <= instrucao(31) & instrucao(30 downto 20) & instrucao(19 downto 12) & "000000000000";
	tipoJ <= instrucao(31) & instrucao(19 downto 12) & instrucao(20) & instrucao(30 downto 25) & instrucao(24 downto 21) & '0';
	tipoB <= instrucao(31) & instrucao(7) & instrucao(30 downto 25) & instrucao(11 downto 8) & '0';
	tipoS <= instrucao(31) & instrucao(30 downto 25) & instrucao(11 downto 8) & instrucao(7);
	tipoI <= instrucao(31) & instrucao(30 downto 25) & instrucao(24 downto 21) & instrucao(20);
	
	process(instrucao,opcode,func3)
	begin
		--LUI e AIUPC TIPO U
		if(opcode = "0110111" or opcode = "0010111") then
			tipo <= 2;
		--JAL TIPO J
		elsif(opcode = "1101111") then
			tipo <= 3;
		--BEQ, BNE, BLT, BGE, BLTU, BGEU TIPO B
		elsif(opcode = "1100011") then
			tipo <= 4;
		--SB, SH, SW, SD TIPO S
		elsif(opcode = "0100011") then
			tipo <= 5;
		--SLTIU TIPO I unsigned
		elsif(opcode = "0010011" and func3 = "011") then
			tipo <= 1;
		else
			tipo <= 0;
		end if;
	end process;
	
	instrucao_64 <= 	std_logic_vector(resize(signed(tipoU),instrucao_64'length)) when tipo = 2 else
							std_logic_vector(resize(signed(tipoJ),instrucao_64'length)) when tipo = 3 else
							std_logic_vector(resize(signed(tipoB),instrucao_64'length)) when tipo = 4 else
							std_logic_vector(resize(signed(tipoS),instrucao_64'length)) when tipo = 5 else
							std_logic_vector(resize(unsigned(tipoI),instrucao_64'length)) when tipo = 1 else
							std_logic_vector(resize(signed(tipoI),instrucao_64'length));
							
	contador_64 <=		std_logic_vector(resize(unsigned(contador),contador_64'length));
							
	
end architecture;