library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is port(
	selPC : in std_logic_vector(1 downto 0);
	clk : in std_logic;
	pcIN : in std_logic_vector(11 downto 0);
	pcOUT : buffer std_logic_vector(11 downto 0)
);
end PC;

architecture hardware of PC is
begin
	process(clk,selPC,pcIN)
	begin
		if(rising_edge(clk)) then
			if(selPC = "11") then
				pcOUT <= pcIN;
			elsif(selPC = "10") then
				pcOUT <= std_logic_vector(signed(pcOUT)+signed(pcIN));
			elsif(selPC = "01") then
				pcOUT <= std_logic_vector(signed(pcOUT)+1);
			else
				pcOUT <= pcOUT;
			end if;
		end if;
	end process;
end hardware;