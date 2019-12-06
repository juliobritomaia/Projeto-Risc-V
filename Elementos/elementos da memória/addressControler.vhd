library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity addressControler is port(
	address: in std_logic_vector(13 downto 0);
	S: out std_logic_vector(87 downto 0)
);
end entity;

architecture design of addressControler is

signal pula : std_logic_vector(10 downto 0);
signal sel_mux : std_logic_vector(6 downto 0);

component mux2to1_11 port(
	sel: in std_logic;
	IN0,IN1: in std_logic_vector(10 downto 0);
	S: out std_logic_vector(10 downto 0)
);
end component;

begin
	pula <= std_logic_vector(unsigned(address(13 downto 3)) + 1);
	
	sel_mux <=	"0000000" when address(2 downto 0) = "000" else
					"0000001" when address(2 downto 0) = "001" else
					"0000011" when address(2 downto 0) = "010" else
					"0000111" when address(2 downto 0) = "011" else
					"0001111" when address(2 downto 0) = "100" else
					"0011111" when address(2 downto 0) = "101" else
					"0111111" when address(2 downto 0) = "101" else
					"1111111";
	
	mux0: mux2to1_11 port map( sel => sel_mux(0), IN0 => address(13 downto 3), IN1 => pula, S => S(10 downto 0) );
	mux1: mux2to1_11 port map( sel => sel_mux(1), IN0 => address(13 downto 3), IN1 => pula, S => S(21 downto 11) );
	mux2: mux2to1_11 port map( sel => sel_mux(2), IN0 => address(13 downto 3), IN1 => pula, S => S(32 downto 22) );
	mux3: mux2to1_11 port map( sel => sel_mux(3), IN0 => address(13 downto 3), IN1 => pula, S => S(43 downto 33) );
	mux4: mux2to1_11 port map( sel => sel_mux(4), IN0 => address(13 downto 3), IN1 => pula, S => S(54 downto 44) );
	mux5: mux2to1_11 port map( sel => sel_mux(5), IN0 => address(13 downto 3), IN1 => pula, S => S(65 downto 55) );
	mux6: mux2to1_11 port map( sel => sel_mux(6), IN0 => address(13 downto 3), IN1 => pula, S => S(76 downto 66) );
	S(87 downto 77) <= address(13 downto 3);
				
end architecture;