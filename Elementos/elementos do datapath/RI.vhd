library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RI is port(
	enableRI,clk : in std_logic;
	riIN : in std_logic_vector(31 downto 0);
	riOUT : buffer std_logic_vector(31 downto 0)
);
end RI;

architecture hardware of RI is
begin
	process(clk,enableRI,riIN)
	begin
		if(rising_edge(clk)) then
			if(enableRI = '1') then
				riOUT <= riIN;
			else
				riOUT <= riOUT;
			end if;
		end if;
	end process;
end hardware;