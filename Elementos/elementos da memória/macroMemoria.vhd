library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity macroMemoria is port(
	dataIN: in std_logic_vector(63 downto 0);
	address: in std_logic_vector(13 downto 0);
	largura: in std_logic_vector(2 downto 0);
	wr,clk: in std_logic;
	dataOUT: out std_logic_vector(63 downto 0)
);
end entity;

architecture design of macroMemoria is

signal saida_deslocador : std_logic_vector(63 downto 0);
signal saida_memorias : std_logic_vector(63 downto 0);
signal saidaAddress : std_logic_vector(87 downto 0);
signal saidaWR: std_logic_vector(7 downto 0);

component deslocador port(
	multiplicador: in std_logic_vector(2 downto 0);
	entrada: in std_logic_vector(63 downto 0);
	saida: out std_logic_vector(63 downto 0)
);
end component;

component addressControler port(
	address: in std_logic_vector(13 downto 0);
	S: out std_logic_vector(87 downto 0)
);
end component;

component writerControler port(
	address: in std_logic_vector(2 downto 0);
	largura: in std_logic_vector(2 downto 0);
	wr: in std_logic;
	S: out std_logic_vector(7 downto 0)
);
end component;

component UnidadeDeMemoria port(
		address		: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
end component;

component concatenador port(
	entrada: in std_logic_vector(63 downto 0);
	address,largura: in std_logic_vector(2 downto 0);
	wr: in std_logic;
	saida: buffer std_logic_vector(63 downto 0)
);
end component;


begin

deslocador1: deslocador port map( multiplicador => address(2 downto 0), entrada => dataIN, saida => saida_deslocador);

controlador_endereco: addressControler port map( address => address, S => saidaAddress );

controlador_escrita: writerControler port map( address => address(2 downto 0), largura => largura, wr => wr, S => saidaWR);

memoria0: UnidadeDeMemoria port map( address => saidaAddress(10 downto 0), clock => clk, data => saida_deslocador(7 downto 0), wren => saidaWR(0), q => saida_memorias(7 downto 0) );
memoria1: UnidadeDeMemoria port map( address => saidaAddress(21 downto 11), clock => clk, data => saida_deslocador(15 downto 8), wren => saidaWR(1), q => saida_memorias(15 downto 8) );
memoria2: UnidadeDeMemoria port map( address => saidaAddress(32 downto 22), clock => clk, data => saida_deslocador(23 downto 16), wren => saidaWR(2), q => saida_memorias(23 downto 16) );
memoria3: UnidadeDeMemoria port map( address => saidaAddress(43 downto 33), clock => clk, data => saida_deslocador(31 downto 24), wren => saidaWR(3), q => saida_memorias(31 downto 24) );
memoria4: UnidadeDeMemoria port map( address => saidaAddress(54 downto 44), clock => clk, data => saida_deslocador(39 downto 32), wren => saidaWR(4), q => saida_memorias(39 downto 32) );
memoria5: UnidadeDeMemoria port map( address => saidaAddress(65 downto 55), clock => clk, data => saida_deslocador(47 downto 40), wren => saidaWR(5), q => saida_memorias(47 downto 40) );
memoria6: UnidadeDeMemoria port map( address => saidaAddress(76 downto 66), clock => clk, data => saida_deslocador(55 downto 48), wren => saidaWR(6), q => saida_memorias(55 downto 48) );
memoria7: UnidadeDeMemoria port map( address => saidaAddress(87 downto 77), clock => clk, data => saida_deslocador(63 downto 56), wren => saidaWR(7), q => saida_memorias(63 downto 56) );

concatenador1: concatenador port map( entrada => saida_memorias, address => address(2 downto 0), largura => largura, wr => wr, saida => dataOUT);
end architecture;