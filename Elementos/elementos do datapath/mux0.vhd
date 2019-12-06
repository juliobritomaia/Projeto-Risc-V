library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux0 is port(
	sel: in std_logic_vector(1 downto 0);
	IN0 : in std_logic_vector(63 downto 0);
	IN1 : in std_logic_vector(63 downto 0);
	IN2 : in std_logic_vector(63 downto 0);
	S : buffer std_logic_vector(63 downto 0)
);
end mux0;

architecture hardware of mux0 is
begin
	WITH sel SELECT
		S <=	IN2 WHEN "10", --ALU
				IN1 WHEN "01", -- MEMORIA DE DADOS
				IN0 WHEN OTHERS; -- PC
end hardware;