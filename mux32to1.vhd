LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux32to1 is
PORT(
	x0,x1,x2,x3,x4,x5,x6,x7,
	x8,x9,x10,x11,x12,x13,x14,x15,
	x16,x17,x18,x19,x20,x21,x22,x23,
	x24,x25,x26,x27,x28,x29,x30,x31: IN STD_LOGIC_VECTOR (63 DOWNTO 0);
	
	sel : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
	xOut : OUT STD_LOGIC_VECTOR (63 DOWNTO 0));

	END mux32to1;
	
	ARCHITECTURE projeto OF mux32to1 IS
	signal AUX : STD_LOGIC_VECTOR(63 DOWNTO 0);
	BEGIN
		WITH SEL SELECT
			AUX <=
						x0		WHEN "00000",
						x1		WHEN "00001",
						x2		WHEN "00010",
						x3		WHEN "00011",
						x4		WHEN "00100",
						x5		WHEN "00101",
						x6		WHEN "00110",
						x7		WHEN "00111",
						x8		WHEN "01000",
						x9		WHEN "01001",
						x10	WHEN "01010",
						x11	WHEN "01011",
						x12 	WHEN "01100",
						x13	WHEN "01101",
						x14	WHEN "01110",
						x15	WHEN "01111",
						x16	WHEN "10000",
						x17	WHEN "10001",
						x18	WHEN "10010",
						x19	WHEN "10011",
						x20	WHEN "10100",
						x21	WHEN "10101",
						x22	WHEN "10110",
						x23	WHEN "10111",
						x24	WHEN "11000",
						x25	WHEN "11001",
						x26	WHEN "11010",
						x27	WHEN "11011",
						x28	WHEN "11100",
						x29	WHEN "11101",
						x30	WHEN "11110",
						x31	WHEN "11111",
						AUX 	WHEN OTHERS;
	xOut <= AUX;
	END projeto;
