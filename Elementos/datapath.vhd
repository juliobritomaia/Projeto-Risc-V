library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity datapath is port (
	wr,clk: in std_logic;
	enableRegfile:	in std_logic;
	selMUX1,selMUX2,selMUX3: in std_logic;
	selPC: in std_logic;
	selRI: in std_logic;
	selMUX0: in std_logic_vector(1 downto 0);
	selAlu: in std_logic_vector(4 downto 0);
	dataIN: in std_logic_vector(63 downto 0);
	dataOUT: out std_logic_vector(63 downto 0);
	branchOUT: out std_logic_vector(2 downto 0)
	
);
end entity;

architecture hardware of datapath is
signal outMemProg: std_logic_vector(31 downto 0);
signal outMemDados: std_logic_vector(63 downto 0);
signal outPC: std_logic_vector(9 downto 0);
signal outRI: std_logic_vector(31 downto 0);
signal outMux3: std_logic_vector(9 downto 0);
signal outMux0,outMux1,outMux2: std_logic_vector(63 downto 0);
signal outRS1, outRS2: std_logic_vector(63 downto 0);
signal outALU: std_logic_vector(63 downto 0);

component memoria port(
	rw,clk: in std_logic;
	largura: in std_logic_vector(2 downto 0);
	address: in std_logic_vector(13 downto 0);
	datain: in std_logic_vector(63 downto 0);
	dataout: out std_logic_vector(63 downto 0)
);
end component;

component RI port(
	enableRI,clk : in std_logic;
	riIN : in std_logic_vector(31 downto 0);
	riOUT : buffer std_logic_vector(31 downto 0)
);
end component;

component regfile port(
	DATA: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	rd: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	clock,enable : IN STD_LOGIC;
	inst_rs1,inst_rs2: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	alu_rs1,alu_rs2: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
);
end component;

component PC port(
	selPC,clk : in std_logic;
	pcIN : in std_logic_vector(9 downto 0);
	pcOUT : buffer std_logic_vector(9 downto 0)
);
end component;

component mux0 port(
	sel: in std_logic_vector(1 downto 0);
	IN0 : in std_logic_vector(9 downto 0);
	IN1 : in std_logic_vector(63 downto 0);
	IN2 : in std_logic_vector(63 downto 0);
	S : buffer std_logic_vector(63 downto 0)
);
end component;

component mux1 port(
	sel: in std_logic;
	IN0 : in std_logic_vector(31 downto 0);
	IN1 : in std_logic_vector(63 downto 0);
	S : buffer std_logic_vector(63 downto 0)
);
end component;

component mux2 port(
	sel: in std_logic;
	IN0 : in std_logic_vector(9 downto 0);
	IN1 : in std_logic_vector(63 downto 0);
	S : buffer std_logic_vector(63 downto 0)
);
end component;

component mux3 port(
	sel: in std_logic;
	IN0 : in std_logic_vector(9 downto 0);
	IN1 : in std_logic_vector(9 downto 0);
	S : buffer std_logic_vector(9 downto 0)
);
end component;

component branch port(
	rs1, rs2	:	in std_logic_vector(63 downto 0);
	saida		:	out std_logic_vector(2 downto 0)
);
end component;

component alu1 port(
	IN2,IN1 : in std_logic_vector (63 downto 0);
	sel : in std_logic_vector (4 downto 0);
	S: out std_logic_vector(63 downto 0)
);
end component;

begin

macroMemoria: memoria port map(
	rw => wr, clk => clk,
	largura => outRI(14 downto 12),
	address => outALU(13 downto 0),
	datain => outRS1,
	dataout => outMemDados
);

RI1 : RI port map (
	enableRI => selRI, clk => clk,
	riIN => outMemProg,
	riOUT => outRI
);

regfile1 : regfile port map (
	DATA => outMUX0,
	rd => outRI(11 downto 7),
	clock => clk, enable => enableRegfile,
	inst_rs1 => outRI(19 downto 16), inst_rs2 => outRI(24 downto 20),
	alu_rs1 => outRS1, alu_rs2 => outRS2
);

PC1 : PC port map (
	selPC => selPC, clk => clk,
	pcIN => outMux3,
	pcOUT => outPC
);

mux3_1 : mux3 port map (
	sel => selMUX3,
	IN0 => outRI,
	IN1 => outALU,
	S => outMux3
);

end architecture;
