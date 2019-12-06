LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY regfile IS PORT(
	DATA: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	rd: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	clock,enable : IN STD_LOGIC;
	inst_rs1,inst_rs2: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	out_rs1,out_rs2: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
);
END regfile;

ARCHITECTURE projeto OF regfile IS

--SIGNAL enable: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL 	InX0,OutX0,OutX1,OutX2,OutX3,OutX4,OutX5,OutX6,OutX7,
			OutX8,OutX9,OutX10,OutX11,OutX12,OutX13,OutX14,OutX15,
			OutX16,OutX17,OutX18,OutX19,OutX20,OutX21,OutX22,OutX23,
			OutX24,OutX25,OutX26,OutX27,OutX28,OutX29,OutX30,OutX31: STD_LOGIC_VECTOR(63 DOWNTO 0);

component mux32to1
PORT(
	x0,x1,x2,x3,x4,x5,x6,x7,
	x8,x9,x10,x11,x12,x13,x14,x15,
	x16,x17,x18,x19,x20,x21,x22,x23,
	x24,x25,x26,x27,x28,x29,x30,x31: IN STD_LOGIC_VECTOR (63 DOWNTO 0);
	
	sel : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
	xOut : OUT STD_LOGIC_VECTOR (63 DOWNTO 0));
end component;

component reg32
	PORT ( D  : IN   STD_LOGIC_VECTOR(63 DOWNTO 0) ;
		load, clk: IN STD_LOGIC ;
		Q  : BUFFER STD_LOGIC_VECTOR(63 DOWNTO 0) ) ;
end component;

BEGIN
RegX0: reg32 port map(D => InX0, load => enable and ( not(rd(4)) and not(rd(3)) and not(rd(2)) and not(rd(1)) and not(rd(0)) ), clk => clock, Q => OutX0);
RegX1: reg32 port map(D => DATA, load => enable and ( not(rd(4)) and not(rd(3)) and not(rd(2)) and not(rd(1)) and (rd(0)) ), clk => clock, Q => OutX1);
RegX2: reg32 port map(D => DATA, load => enable and ( not(rd(4)) and not(rd(3)) and not(rd(2)) and (rd(1)) and not(rd(0)) ), clk => clock, Q => OutX2);
RegX3: reg32 port map(D => DATA, load => enable and ( not(rd(4)) and not(rd(3)) and not(rd(2)) and (rd(1)) and (rd(0)) ), clk => clock, Q => OutX3);
RegX4: reg32 port map(D => DATA, load => enable and ( not(rd(4)) and not(rd(3)) and (rd(2)) and not(rd(1)) and not(rd(0)) ), clk => clock, Q => OutX4);
RegX5: reg32 port map(D => DATA, load => enable and ( not(rd(4)) and not(rd(3)) and (rd(2)) and not(rd(1)) and (rd(0)) ), clk => clock, Q => OutX5);
RegX6: reg32 port map(D => DATA, load => enable and ( not(rd(4)) and not(rd(3)) and (rd(2)) and (rd(1)) and not(rd(0)) ), clk => clock, Q => OutX6);
RegX7: reg32 port map(D => DATA, load => enable and ( not(rd(4)) and not(rd(3)) and (rd(2)) and (rd(1)) and (rd(0)) ), clk => clock, Q => OutX7);
RegX8: reg32 port map(D => DATA, load => enable and ( not(rd(4)) and (rd(3)) and not(rd(2)) and not(rd(1)) and not(rd(0)) ), clk => clock, Q => OutX8);
RegX9: reg32 port map(D => DATA, load => enable and ( not(rd(4)) and (rd(3)) and not(rd(2)) and not(rd(1)) and (rd(0)) ), clk => clock, Q => OutX9);
RegX10: reg32 port map(D => DATA, load => enable and ( not(rd(4)) and (rd(3)) and not(rd(2)) and (rd(1)) and not(rd(0)) ), clk => clock, Q => OutX10);
RegX11: reg32 port map(D => DATA, load => enable and ( not(rd(4)) and (rd(3)) and not(rd(2)) and (rd(1)) and (rd(0)) ), clk => clock, Q => OutX11);
RegX12: reg32 port map(D => DATA, load => enable and ( not(rd(4)) and (rd(3)) and (rd(2)) and not(rd(1)) and not(rd(0)) ), clk => clock, Q => OutX12);
RegX13: reg32 port map(D => DATA, load => enable and ( not(rd(4)) and (rd(3)) and (rd(2)) and not(rd(1)) and (rd(0)) ), clk => clock, Q => OutX13);
RegX14: reg32 port map(D => DATA, load => enable and ( not(rd(4)) and (rd(3)) and (rd(2)) and (rd(1)) and not(rd(0)) ), clk => clock, Q => OutX14);
RegX15: reg32 port map(D => DATA, load => enable and ( not(rd(4)) and (rd(3)) and (rd(2)) and (rd(1)) and (rd(0)) ), clk => clock, Q => OutX15);
RegX16: reg32 port map(D => DATA, load => enable and ( (rd(4)) and not(rd(3)) and not(rd(2)) and not(rd(1)) and not(rd(0)) ), clk => clock, Q => OutX16);
RegX17: reg32 port map(D => DATA, load => enable and ( (rd(4)) and not(rd(3)) and not(rd(2)) and not(rd(1)) and (rd(0)) ), clk => clock, Q => OutX17);
RegX18: reg32 port map(D => DATA, load => enable and ( (rd(4)) and not(rd(3)) and not(rd(2)) and (rd(1)) and not(rd(0)) ), clk => clock, Q => OutX18);
RegX19: reg32 port map(D => DATA, load => enable and ( (rd(4)) and not(rd(3)) and not(rd(2)) and (rd(1)) and (rd(0)) ), clk => clock, Q => OutX19);
RegX20: reg32 port map(D => DATA, load => enable and ( (rd(4)) and not(rd(3)) and (rd(2)) and not(rd(1)) and not(rd(0)) ), clk => clock, Q => OutX20);
RegX21: reg32 port map(D => DATA, load => enable and ( (rd(4)) and not(rd(3)) and (rd(2)) and not(rd(1)) and (rd(0)) ), clk => clock, Q => OutX21);
RegX22: reg32 port map(D => DATA, load => enable and ( (rd(4)) and not(rd(3)) and (rd(2)) and (rd(1)) and not(rd(0)) ), clk => clock, Q => OutX22);
RegX23: reg32 port map(D => DATA, load => enable and ( (rd(4)) and not(rd(3)) and (rd(2)) and (rd(1)) and (rd(0)) ), clk => clock, Q => OutX23);
RegX24: reg32 port map(D => DATA, load => enable and ( (rd(4)) and (rd(3)) and not(rd(2)) and not(rd(1)) and not(rd(0)) ), clk => clock, Q => OutX24);
RegX25: reg32 port map(D => DATA, load => enable and ( (rd(4)) and (rd(3)) and not(rd(2)) and not(rd(1)) and (rd(0)) ), clk => clock, Q => OutX25);
RegX26: reg32 port map(D => DATA, load => enable and ( (rd(4)) and (rd(3)) and not(rd(2)) and (rd(1)) and not(rd(0)) ), clk => clock, Q => OutX26);
RegX27: reg32 port map(D => DATA, load => enable and ( (rd(4)) and (rd(3)) and not(rd(2)) and (rd(1)) and (rd(0)) ), clk => clock, Q => OutX27);
RegX28: reg32 port map(D => DATA, load => enable and ( (rd(4)) and (rd(3)) and (rd(2)) and not(rd(1)) and not(rd(0)) ), clk => clock, Q => OutX28);
RegX29: reg32 port map(D => DATA, load => enable and ( (rd(4)) and (rd(3)) and (rd(2)) and not(rd(1)) and (rd(0)) ), clk => clock, Q => OutX29);
RegX30: reg32 port map(D => DATA, load => enable and ( (rd(4)) and (rd(3)) and (rd(2)) and (rd(1)) and not(rd(0)) ), clk => clock, Q => OutX30);
RegX31: reg32 port map(D => DATA, load => enable and ( (rd(4)) and (rd(3)) and (rd(2)) and (rd(1)) and (rd(0)) ), clk => clock, Q => OutX31);

Mux_rs1: mux32to1 port map (
	x0 => OutX0, x1 => OutX1, x2 => OutX2, x3 => OutX3, x4 => OutX4, x5 => OutX5, x6 => OutX6, x7 => OutX7,
	x8 => OutX8, x9 => OutX9, x10 => OutX10, x11 => OutX11, x12 => OutX12, x13 => OutX13, x14 => OutX14, x15 => OutX15,
	x16 => OutX16, x17 => OutX17, x18 => OutX18, x19 => OutX19, x20 => OutX20, x21 => OutX21, x22 => OutX22, x23 => OutX23,
	x24 => OutX24, x25 => OutX25, x26 => OutX26, x27 => OutX27, x28 => OutX28, x29 => OutX29, x30 => OutX30, x31 => OutX31,
	sel  => inst_rs1,
	xOut  => out_rs1
);

Mux_rs2: mux32to1 port map (
	x0 => OutX0, x1 => OutX1, x2 => OutX2, x3 => OutX3, x4 => OutX4, x5 => OutX5, x6 => OutX6, x7 => OutX7,
	x8 => OutX8, x9 => OutX9, x10 => OutX10, x11 => OutX11, x12 => OutX12, x13 => OutX13, x14 => OutX14, x15 => OutX15,
	x16 => OutX16, x17 => OutX17, x18 => OutX18, x19 => OutX19, x20 => OutX20, x21 => OutX21, x22 => OutX22, x23 => OutX23,
	x24 => OutX24, x25 => OutX25, x26 => OutX26, x27 => OutX27, x28 => OutX28, x29 => OutX29, x30 => OutX30, x31 => OutX31,
	sel  => inst_rs2,
	xOut  => out_rs2
);
InX0 <= "0000000000000000000000000000000000000000000000000000000000000000";
--	WITH rd SELECT
--	enable <=
--					"00000000000000000000000000000001" when "00000",
--					"00000000000000000000000000000010" when "00001",
--					"00000000000000000000000000000100" when "00010",
--					"00000000000000000000000000001000" when "00011",
--					"00000000000000000000000000010000" when "00100",
--					"00000000000000000000000000100000" when "00101",
--					"00000000000000000000000001000000" when "00110",
--					"00000000000000000000000010000000" when "00111",
--					"00000000000000000000000100000000" when "01000",
--					"00000000000000000000001000000000" when "01001",
--					"00000000000000000000010000000000" when "01010",
--					"00000000000000000000100000000000" when "01011",
--					"00000000000000000001000000000000" when "01100",
--					"00000000000000000010000000000000" when "01101",
--					"00000000000000000100000000000000" when "01110",
--					"00000000000000001000000000000000" when "01111",
--					"00000000000000010000000000000000" when "10000",
--					"00000000000000100000000000000000" when "10001",
--					"00000000000001000000000000000000" when "10010",
--					"00000000000010000000000000000000" when "10011",
--					"00000000000100000000000000000000" when "10100",
--					"00000000001000000000000000000000" when "10101",
--					"00000000010000000000000000000000" when "10110",
--					"00000000100000000000000000000000" when "10111",
--					"00000001000000000000000000000000" when "11000",
--					"00000010000000000000000000000000" when "11001",
--					"00000100000000000000000000000000" when "11010",
--					"00001000000000000000000000000000" when "11011",
--					"00010000000000000000000000000000" when "11100",
--					"00100000000000000000000000000000" when "11101",
--					"01000000000000000000000000000000" when "11110",
--					"10000000000000000000000000000000" when "11111",
--					"00000000000000000000000000000000" when others;
END projeto ;