library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is port(
	enablePC,clk : in std_logic;
	pcIN : in std_logic_vector(9 downto 0);
	pcOUT : buffer std_logic_vector(9 downto 0)
);
end PC;

architecture hardware of PC is
begin
	process(clk,enablePC,pcIN)
	begin
		if(rising_edge(clk)) then
			if(enablePC = '0') then
				pcOUT <= std_logic_vector(signed(pcOUT)+1);
			else
				pcOUT <= pcIN;
			end if;
		end if;
	end process;
end hardware;