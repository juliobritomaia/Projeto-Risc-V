library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity macroMemoria is port(
	dataIN: in std_logic_vector(63 downto 0);
	address: in std_logic_vector(13 downto 0);
	largura: in std_logic_vector(2 downto 0);
	wr,clk: in std_logic;
	dataOUT: out in std_logic_vector(63 downto 0)
);
end entity;

architecture design of macroMemoria is

signal sel_muxes : std_logic_vector(6 downto 0);
signal saida_deslocador : std_logic_vector(119 downto 0);
signal saida_muxes : std_logic_vector(55 downto 0);

signal saida_memorias : std_logic_vector(63 downto 0);

component UnidadeDeMemoria port(
		address		: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
end component;

component deslocador port(
	multiplicador: in std_logic_vector(2 downto 0);
	entrada: in std_logic_vector(63 downto 0);
	sel_muxes: out std_logic_vector(6 downto 0);
	saida: out std_logic_vector(119 downto 0)
);
end component;

component mux2to1 port(
	sel: in std_logic;
	IN0,IN1: in std_logic_vector(7 downto 0);
	S: out std_logic_vector(7 downto 0)
);
end component;

begin
deslocador1: deslocador port map( multiplicador => address(3 downto 0), entrada => dataIN, sel_muxes => sel_muxes, saida => saida_deslocador);

mux0: mux2to1 port map( sel => sel_muxes(0), IN0 => saida_deslocador(7 downto 0), IN1 => saida_deslocador(71 downto 64), S => saida_muxes(7 downto 0) );
mux1: mux2to1 port map( sel => sel_muxes(1), IN0 => saida_deslocador(15 downto 8), IN1 => saida_deslocador(79 downto 72), S => saida_muxes(15 downto 8) );
mux2: mux2to1 port map( sel => sel_muxes(2), IN0 => saida_deslocador(23 downto 16), IN1 => saida_deslocador(87 downto 80), S => saida_muxes(23 downto 16) );
mux3: mux2to1 port map( sel => sel_muxes(3), IN0 => saida_deslocador(31 downto 24), IN1 => saida_deslocador(95 downto 88), S => saida_muxes(31 downto 24) );
mux4: mux2to1 port map( sel => sel_muxes(4), IN0 => saida_deslocador(39 downto 32), IN1 => saida_deslocador(103 downto 96), S => saida_muxes(39 downto 32) );
mux5: mux2to1 port map( sel => sel_muxes(5), IN0 => saida_deslocador(47 downto 40), IN1 => saida_deslocador(111 downto 104), S => saida_muxes(47 downto 40) );
mux6: mux2to1 port map( sel => sel_muxes(6), IN0 => saida_deslocador(55 downto 48), IN1 => saida_deslocador(119 downto 112), S => saida_muxes(55 downto 48) );

memoria0: UnidadeDeMemoria port map( address => , clock => clk, data => saida_muxes(7 downto 0), wren => , q => saida_memorias(7 downto 0) );
memoria1: UnidadeDeMemoria port map( address => , clock => clk, data => saida_muxes(15 downto 8), wren => , q => saida_memorias(15 downto 8) );
memoria2: UnidadeDeMemoria port map( address => , clock => clk, data => saida_muxes(23 downto 16), wren => , q => saida_memorias(23 downto 16) );
memoria3: UnidadeDeMemoria port map( address => , clock => clk, data => saida_muxes(31 downto 24), wren => , q => saida_memorias(31 downto 24) );
memoria4: UnidadeDeMemoria port map( address => , clock => clk, data => saida_muxes(39 downto 32), wren => , q => saida_memorias(39 downto 32) );
memoria5: UnidadeDeMemoria port map( address => , clock => clk, data => saida_muxes(47 downto 40), wren => , q => saida_memorias(47 downto 40) );
memoria6: UnidadeDeMemoria port map( address => , clock => clk, data => saida_muxes(55 downto 48), wren => , q => saida_memorias(55 downto 48) );
memoria7: UnidadeDeMemoria port map( address => , clock => clk, data => saida_deslocador(63 downto 56), wren => , q => saida_memorias(63 downto 56) );

end architecture;