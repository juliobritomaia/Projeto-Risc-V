library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity controlador is
port(
	branch_eq, branch_lt, branch_ltu : in std_logic;
	sel_Mux1, sel_Mux2, sel_Mux3, sel_memo, sel_RegFile, sel_RI : out std_logic;
	sel_PC, sel_Mux0 : out std_logic_vector(1 downto 0);
	sel_Alu : out std_logic_vector(4 downto 0)
); end controlador; 


architecture ctrl of controlador is 
begin 

process(opcode)
begin
	case opcode(7 downto 0) is
		when "0110111" => -- U lui
		when "0010111" => -- U auipc
		when "1101111" => -- J jal
		when "1100111" =>
			if(opcode(14 downto 12) = "000") then
				-- I jalr
			end if;
		when "1100011" =>
			if(opcode(14 downto 12) = "000") then
				-- B beq
			elsif(opcode(14 downto 12) = "001") then
				-- B bne
			elsif(opcode(14 downto 12) = "100") then
				-- B blt
			elsif(opcode(14 downto 12) = "101") then
				-- B bge
			elsif(opcode(14 downto 12) = "110") then
				-- B bltu
			elsif(opcode(14 downto 12) = "111") then
				-- B bgeu
			end if;
		when "0000011" =>
			if(opcode(14 downto 12) = "000") then
				-- I lb
			elsif(opcode(14 downto 12) = "001") then
				-- I lh
			elsif(opcode(14 downto 12) = "010") then
				-- I lw
			elsif(opcode(14 downto 12) = "100") then
				-- I lbu
			elsif(opcode(14 downto 12) = "101") then
				--	I lhu
			elsif(opcode(14 downto 12) = "110") then
				-- I lwu
			elsif(opcode(14 downto 12) = "011") then
				-- I ld
			end if;
		when "0100011" =>
			if(opcode(14 downto 12) = "000") then
				-- S sb
			elsif(opcode(14 downto 12) = "001") then
				-- S sh
			elsif(opcode(14 downto 12) = "010") then
				-- S sw
			elsif(opcode(14 downto 12) = "011") then
				-- S sd
			end if;
		when "0010011" =>
			if(opcode(14 downto 12) = "000") then
				if(opcode(31 downto 25) = "0000000") then
					-- R add
				elsif(opcode(31 downto 25) = "0100000") then
					-- R sub
				else
					-- I addi
				end if;
			elsif(opcode(14 downto 12) = "010") then
				if(opcode(31 downto 25) = "0000000") then
					-- R slt
				else
					-- I slti
				end if;
			elsif(opcode(14 downto 12) = "011") then
				if(opcode(31 downto 25) = "0000000") then
					-- R sltu
				else
					-- I sltiu
				end if;
			elsif(opcode(14 downto 12) = "100") then
				if(opcode(31 downto 25) = "0000000") then
					-- R xor
				else
					-- I xori
				end if;
			elsif(opcode(14 downto 12) = "110") then
				if(opcode(31 downto 25) = "0000000") then
					-- R or
				else
					-- I ori
				end if;
			elsif(opcode(14 downto 12) = "111") then
				if(opcode(31 downto 25) = "0000000") then
					-- R and
				else
					-- I andi
				end if;
			elsif(opcode(14 downto 12) = "001") then
				if(opcode(31 downto 26) = "000000") then
					-- I slli
				elsif(opcode(31 downto 25) = "0000000") then
					-- R sll
				end if;
			elsif(opcode(14 downto 12) = "101") then
				if(opcode(31 downto 26) = "000000") then
					-- I srli
				elsif(opcode(31 downto 26) = "010000") then
					-- I srai
				elsif(opcode(31 downto 25) = "0000000") then
					-- R srl
				elsif(opcode(31 downto 25) = "0100000") then
					-- R sra
				end if; 	
		when "0111011" =>
			if(opcode(14 downto 12) = "000") then
				if(opcode(31 downto 25) = "0000000") then
					-- R addw
				elsif(opcode(31 downto 25) = "0100000")
					-- R subw
				end if;
			elsif(opcode(14 downto 12) = "001") then
				if(opcode(31 downto 25) = "0000000") then
					-- R sllw
				end if;
			elsif(opcode(14 downto 12) = "101") then
				if(opcode(31 downto 25) = "0000000") then
					-- R srlw
				elsif(opcode(31 downto 25) = "0100000") then
					-- R sraw
				end if;
			end if; 
		when "0011011" =>
			if(opcode(14 downto 12) = "000") then
				-- I addiw
			elsif(opcode(14 downto 12) = "001") then
				if(opcode(31 downto 25) = "0000000") then
					-- I slliw
			elsif(opcode(14 downto 12) = "101") then
				if(opcode(31 downto 25) = "0000000") then
					-- I srliw
				elsif(opcode(31 downto 25) = "0100000") then
					-- I sraiw
				end if;
			end if;
	end case;
	
end process;
end ctrl; 
