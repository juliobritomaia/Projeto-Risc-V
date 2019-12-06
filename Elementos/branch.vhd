library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity branch is port (

rs1, rs2	:	in std_logic_vector(63 downto 0);
saida		:	out std_logic_vector(2 downto 0)
);
end entity;

architecture hardware of branch is

begin
	
	process(rs1, rs2)
	begin
		if (signed(rs2) < signed(rs1)) then
			saida (0) <= '1';
		else
			saida (0) <= '0';
		end if;
		
		if (unsigned (rs2) < unsigned(rs1)) then
			saida (1) <= '1';
		else
			saida (1) <= '0';
		end if;
		
		if (signed(rs2) = signed(rs1)) then
			saida (2) <= '1';
		else
			saida (2) <= '0';
		end if;
	end process;
end architecture;
