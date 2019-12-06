LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY regfile IS PORT(
	DATA: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	rd: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	clk,enable : IN STD_LOGIC;
	inst_rs1,inst_rs2: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	out_rs1,out_rs2: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
);
END regfile;

architecture projeto of regfile is

signal saida_reg: std_logic_vector(2047 downto 0);
signal load_reg: std_logic_vector(31 downto 0);

signal zero64: std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";

component reg64 port (
	D  : IN   STD_LOGIC_VECTOR(63 DOWNTO 0) ;
	load, clk: IN STD_LOGIC ;
	Q  : BUFFER STD_LOGIC_VECTOR(63 DOWNTO 0)
);
end component;

component load_controler port (
	address: in std_logic_vector(4 downto 0);
	enable: in std_logic;
	load: out std_logic_vector(31 downto 0)
);
end component;

component banco_muxes port (
		entrada  : in std_logic_vector(2047 DOWNTO 0) ;
		address  : in std_logic_vector(4 DOWNTO 0) ;
		saida  : BUFFER STD_LOGIC_VECTOR(63 DOWNTO 0)
);
end component;

begin

regx0: reg64 port map (D => zero64, load => load_reg(0), clk => clk, Q  => saida_reg(63 downto 0) );
regx1: reg64 port map (D => DATA, load => load_reg(1), clk => clk, Q  => saida_reg(127 downto 64) );
regx2: reg64 port map (D => DATA, load => load_reg(2), clk => clk, Q  => saida_reg(191 downto 128) );
regx3: reg64 port map (D => DATA, load => load_reg(3), clk => clk, Q  => saida_reg(255 downto 192) );
regx4: reg64 port map (D => DATA, load => load_reg(4), clk => clk, Q  => saida_reg(319 downto 256) );
regx5: reg64 port map (D => DATA, load => load_reg(5), clk => clk, Q  => saida_reg(383 downto 320) );
regx6: reg64 port map (D => DATA, load => load_reg(6), clk => clk, Q  => saida_reg(447 downto 384) );
regx7: reg64 port map (D => DATA, load => load_reg(7), clk => clk, Q  => saida_reg(511 downto 448) );
regx8: reg64 port map (D => DATA, load => load_reg(8), clk => clk, Q  => saida_reg(575 downto 512) );
regx9: reg64 port map (D => DATA, load => load_reg(9), clk => clk, Q  => saida_reg(639 downto 576) );
regx10: reg64 port map (D => DATA, load => load_reg(10), clk => clk, Q  => saida_reg(703 downto 640) );
regx11: reg64 port map (D => DATA, load => load_reg(11), clk => clk, Q  => saida_reg(767 downto 704) );
regx12: reg64 port map (D => DATA, load => load_reg(12), clk => clk, Q  => saida_reg(831 downto 768) );
regx13: reg64 port map (D => DATA, load => load_reg(13), clk => clk, Q  => saida_reg(895 downto 832) );
regx14: reg64 port map (D => DATA, load => load_reg(14), clk => clk, Q  => saida_reg(959 downto 896) );
regx15: reg64 port map (D => DATA, load => load_reg(15), clk => clk, Q  => saida_reg(1023 downto 960) );
regx16: reg64 port map (D => DATA, load => load_reg(16), clk => clk, Q  => saida_reg(1087 downto 1024) );
regx17: reg64 port map (D => DATA, load => load_reg(17), clk => clk, Q  => saida_reg(1151 downto 1088) );
regx18: reg64 port map (D => DATA, load => load_reg(18), clk => clk, Q  => saida_reg(1215 downto 1152) );
regx19: reg64 port map (D => DATA, load => load_reg(19), clk => clk, Q  => saida_reg(1279 downto 1216) );
regx20: reg64 port map (D => DATA, load => load_reg(20), clk => clk, Q  => saida_reg(1343 downto 1280) );
regx21: reg64 port map (D => DATA, load => load_reg(21), clk => clk, Q  => saida_reg(1407 downto 1344) );
regx22: reg64 port map (D => DATA, load => load_reg(22), clk => clk, Q  => saida_reg(1471 downto 1408) );
regx23: reg64 port map (D => DATA, load => load_reg(23), clk => clk, Q  => saida_reg(1535 downto 1472) );
regx24: reg64 port map (D => DATA, load => load_reg(24), clk => clk, Q  => saida_reg(1599 downto 1536) );
regx25: reg64 port map (D => DATA, load => load_reg(25), clk => clk, Q  => saida_reg(1663 downto 1600) );
regx26: reg64 port map (D => DATA, load => load_reg(26), clk => clk, Q  => saida_reg(1727 downto 1664) );
regx27: reg64 port map (D => DATA, load => load_reg(27), clk => clk, Q  => saida_reg(1791 downto 1728) );
regx28: reg64 port map (D => DATA, load => load_reg(28), clk => clk, Q  => saida_reg(1855 downto 1792) );
regx29: reg64 port map (D => DATA, load => load_reg(29), clk => clk, Q  => saida_reg(1919 downto 1856) );
regx30: reg64 port map (D => DATA, load => load_reg(30), clk => clk, Q  => saida_reg(1983 downto 1920) );
regx31: reg64 port map (D => DATA, load => load_reg(31), clk => clk, Q  => saida_reg(2047 downto 1984) );

controlador_loads: load_controler port map (	address => rd, enable => enable, load => load_reg);

muxes_rs1: banco_muxes port map (entrada => saida_reg, address => inst_rs1, saida => out_rs1);
muxes_rs2: banco_muxes port map (entrada => saida_reg, address => inst_rs2, saida => out_rs2);

end projeto ;