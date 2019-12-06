LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

entity banco_muxes is port(
		entrada  : in std_logic_vector(2047 DOWNTO 0) ;
		address  : in std_logic_vector(4 DOWNTO 0) ;
		saida  : BUFFER STD_LOGIC_VECTOR(63 DOWNTO 0)
);
end entity;

architecture projeto of banco_muxes is

signal saida_muxes0 : std_logic_vector(511 downto 0);
signal saida_muxes1 : std_logic_vector(127 downto 0);

component mux4to1_64 port (
	IN0,IN1,IN2,IN3: IN STD_LOGIC_VECTOR (63 DOWNTO 0);
	SEL : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
	S : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
);
end component;

component mux2to1_64 port (
	IN0,IN1 : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
	SEL : IN STD_LOGIC;
	S : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
);
end component;

begin

mux0: mux4to1_64 port map ( IN0 => entrada(63 downto 0), IN1 => entrada(127 downto 64), IN2 => entrada(191 downto 128), IN3 => entrada(255 downto 192), SEL => address(1 downto 0), S => saida_muxes0(63 downto 0) );
mux1: mux4to1_64 port map ( IN0 => entrada(319 downto 256), IN1 => entrada(383 downto 320), IN2 => entrada(447 downto 384), IN3 => entrada(511 downto 448), SEL => address(1 downto 0), S => saida_muxes0(127 downto 64) );
mux2: mux4to1_64 port map ( IN0 => entrada(575 downto 512), IN1 => entrada(639 downto 576), IN2 => entrada(703 downto 640), IN3 => entrada(767 downto 704), SEL => address(1 downto 0), S => saida_muxes0(191 downto 128) );
mux3: mux4to1_64 port map ( IN0 => entrada(831 downto 768), IN1 => entrada(895 downto 832), IN2 => entrada(959 downto 896), IN3 => entrada(1023 downto 960), SEL => address(1 downto 0), S => saida_muxes0(255 downto 192) );
mux4: mux4to1_64 port map ( IN0 => entrada(1087 downto 1024), IN1 => entrada(1151 downto 1088), IN2 => entrada(1215 downto 1152), IN3 => entrada(1279 downto 1216), SEL => address(1 downto 0), S => saida_muxes0(319 downto 256) );
mux5: mux4to1_64 port map ( IN0 => entrada(1343 downto 1280), IN1 => entrada(1407 downto 1344), IN2 => entrada(1471 downto 1408), IN3 => entrada(1535 downto 1472), SEL => address(1 downto 0), S => saida_muxes0(383 downto 320) );
mux6: mux4to1_64 port map ( IN0 => entrada(1599 downto 1536), IN1 => entrada(1663 downto 1600), IN2 => entrada(1727 downto 1664), IN3 => entrada(1791 downto 1728), SEL => address(1 downto 0), S => saida_muxes0(447 downto 384) );
mux7: mux4to1_64 port map ( IN0 => entrada(1855 downto 1792), IN1 => entrada(1919 downto 1856), IN2 => entrada(1983 downto 1920), IN3 => entrada(2047 downto 1984), SEL => address(1 downto 0), S => saida_muxes0(511 downto 448) );

mux8: mux4to1_64 port map ( IN0 => saida_muxes0(63 downto 0), IN1 => saida_muxes0(127 downto 64), IN2 => saida_muxes0(191 downto 128), IN3 => saida_muxes0(255 downto 192), SEL => address(3 downto 2), S => saida_muxes1(63 downto 0) );
mux9: mux4to1_64 port map ( IN0 => saida_muxes0(319 downto 256), IN1 => saida_muxes0(383 downto 320), IN2 => saida_muxes0(447 downto 384), IN3 => saida_muxes0(511 downto 448), SEL => address(3 downto 2), S => saida_muxes1(127 downto 64) );

mux10: mux2to1_64 port map ( IN0 => saida_muxes1(63 downto 0), IN1 => saida_muxes1(127 downto 64), SEL => address(4), S => saida );
	
end projeto ;