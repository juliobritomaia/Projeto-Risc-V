library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is port (
	wr,clk: in std_logic;
	enableRegfile:	in std_logic;
	selMUX1,selMUX2: in std_logic;
	selRI: in std_logic;
	selPC,selMUX0,selMUX3: in std_logic_vector(1 downto 0);
	selAlu: in std_logic_vector(4 downto 0);
	dataIN: in std_logic_vector(63 downto 0);
	dataOUT: out std_logic_vector(63 downto 0);
	branchOUT: out std_logic_vector(2 downto 0);
	
	enableINcheck, enableOUTcheck: in std_logic;
	outAddress: out std_logic_vector(13 downto 0);
	
	outMemProg: in std_logic_vector(31 downto 0);
	addressMemProg: out std_logic_vector(11 downto 0)
	
);
end entity;

architecture hardware of datapath is
signal outMemDados: std_logic_vector(63 downto 0);
signal outPC: std_logic_vector(11 downto 0);
signal outRI: std_logic_vector(31 downto 0);
signal outMux3: std_logic_vector(31 downto 0);
signal outMux0,outMux1,outMux2: std_logic_vector(63 downto 0);
signal outRS1, outRS2: std_logic_vector(63 downto 0);
signal outALU: std_logic_vector(63 downto 0);

signal comparacao: std_logic_vector(14 downto 0);
signal outCOMPARADOR: std_logic;
signal outANDport: std_logic;
signal outPC_mais4: std_logic_vector(11 downto 0);
signal outINcheck: std_logic_vector(63 downto 0);

component macroMemoria port(
	dataIN: in std_logic_vector(63 downto 0);
	address: in std_logic_vector(13 downto 0);
	largura: in std_logic_vector(2 downto 0);
	wr,clk: in std_logic;
	dataOUT: out std_logic_vector(63 downto 0)
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
	clk,enable : IN STD_LOGIC;
	inst_rs1,inst_rs2: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	out_rs1,out_rs2: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
);
end component;

component PC port(
	selPC : in std_logic_vector(1 downto 0);
	clk : in std_logic;
	pcIN : in std_logic_vector(11 downto 0);
	pcOUT : buffer std_logic_vector(11 downto 0)
);
end component;

component mux0 port(
	sel: in std_logic_vector(1 downto 0);
	IN0 : in std_logic_vector(11 downto 0);
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
	IN0 : in std_logic_vector(11 downto 0);
	IN1 : in std_logic_vector(63 downto 0);
	S : buffer std_logic_vector(63 downto 0)
);
end component;

component mux3 port(
	sel: in std_logic_vector(1 downto 0);
	IN0 : in std_logic_vector(31 downto 0);
	IN1 : in std_logic_vector(63 downto 0);
	S : buffer std_logic_vector(31 downto 0)
);
end component;

component outCheck port(
	sel,enable: in std_logic;
	IN0 : in std_logic_vector(63 downto 0);
	S : buffer std_logic_vector(63 downto 0)
);
end component;

component inCheck port(
	sel,enable: in std_logic;
	IN0,IN1 : in std_logic_vector(63 downto 0);
	S : out std_logic_vector(63 downto 0)
);
end component;

component addressSignal port(
	sel: in std_logic;
	enable: std_logic_vector(1 downto 0);
	address : in std_logic_vector(13 downto 0);
	S : buffer std_logic_vector(13 downto 0)
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

--COMPARADOR DE ENDEREÇOS
comparacao <= "100000000000000";
process(outALU,comparacao)
begin
	if(outALU >= comparacao) then
		outCOMPARADOR <= '1';
	else
		outCOMPARADOR <= '0';
	end if;
end process;

--AND PORT
outANDport <= wr and not(outCOMPARADOR);

--PC+4
outPC_mais4 <= std_logic_vector(signed(outPC) + 1);

--IN CHECK
checkIn: inCheck port map(
	sel => outCOMPARADOR, enable => enableINcheck,
	IN0 => outmemDados,
	IN1 => dataIN,
	S => outINcheck
);
--OUT CHECK
checkOut: outCheck port map(
	sel => outCOMPARADOR, enable => enableOUTcheck,
	IN0 => outRS2,
	S => dataOUT
);
--ADDRESS SIGNAL
addressSignal_1: addressSignal port map(
	sel => outCOMPARADOR,
	enable => enableINcheck & enableOUTcheck,
	address => outALU(13 downto 0),
	S => outAddress
);
--MEMORIA DE PROGRAMA
addressMemProg <= outPC;

memoriaPrograma: macroMemoria port map(
	dataIN => outRS2,
	address => outALU(13 downto 0),
	largura => outRI(14 downto 12),
	wr => outANDport, clk => clk,
	dataOUT => outMemDados
);

RI1 : RI port map (
	enableRI => selRI, clk => clk,
	riIN => outMemProg,
	riOUT => outRI
);

regfile1 : regfile port map (
	DATA => outMUX0,
	rd => outRI(11 downto 7),
	clk => clk, enable => enableRegfile,
	inst_rs1 => outRI(19 downto 15), inst_rs2 => outRI(24 downto 20),
	out_rs1 => outRS1, out_rs2 => outRS2
);

PC1 : PC port map (
	selPC => selPC, clk => clk,
	pcIN => outMux3(11 downto 0),
	pcOUT => outPC
);

mux3_1 : mux3 port map (
	sel => selMUX3,
	IN0 => outRI,
	IN1 => outALU,
	S => outMux3
);

mux2_1 : mux2 port map (
	sel => selMUX2,
	IN0 => outPC,
	IN1 => outRS1,
	S =>	outMux2
);

mux1_1 : mux1 port map (
	sel => selMUX1,
	IN0 => outRI,
	IN1 => outRS2,
	S => outMux1
);

mux0_1 : mux0 port map (
	sel => selMUX0,
	IN0 => outPC_mais4,
	IN1 => outINcheck,
	IN2 => outALU,
	S => outMux0
);

branch1 : branch port map (
	rs1 => outRS1, rs2 => outRS2,
	saida => branchOUT
);

alu1_1 : alu1 port map (
	IN2 => outMux1, IN1 => outMux2,
	sel => selAlu,
	S => outALU
);


end architecture;
