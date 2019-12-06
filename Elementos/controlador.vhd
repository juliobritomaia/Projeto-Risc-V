library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity controlador is
port(
	opcode :  in std_logic_vector(63 downto 0);
	branch_eq, branch_lt, branch_ltu : in std_logic;
	sel_Mux1, sel_Mux2, sel_Mux3, sel_memo, sel_RegFile, sel_RI : out std_logic;
	sel_PC, sel_Mux0 : out std_logic_vector(1 downto 0);
	sel_Alu : out std_logic_vector(4 downto 0)
);
end controlador; 


architecture ctrl of controlador is 
begin 
process(opcode, branch_eq, branch_lt, branch_ltu)
begin 
	case opcode(6 downto 0) is
		when "0110111" => -- U lui
			sel_RI <= '1';
			sel_Mux1 <= '0'; 
			sel_Alu <= "00000";
			sel_Mux0 <= "10";
			sel_RegFile <= '1';
		when "0010111" => -- U auipc
			sel_Mux2 <= '0';
			sel_Mux1 <= '0';
			sel_Alu <= "00000";
			sel_Mux0 <= "10";
			sel_RegFile <= '1';
			sel_RI <= '1';
		when "1101111" => -- J jal
			sel_Mux0 <= "00";
			sel_RegFile <= '1';
			sel_RI <= '1';
			sel_Mux1 <= '0';
			sel_Mux2 <= '0';	
			sel_Alu <= "01110";
			sel_Mux3 <= '1';
			sel_PC <= "11";
		when "1100111" =>
			if(opcode(14 downto 12) = "000") then
				-- I jalr
				sel_Mux0 <= "00";
				sel_RegFile <= '1';
				sel_RI <= '1';
				sel_Mux1 <= '0';
				sel_Mux2 <= '1';
				sel_Alu <= "00001";
				sel_Mux3 <= '1';
				sel_PC <= "11";
			end if;
		when "1100011" =>
			if(opcode(14 downto 12) = "000") then
				-- B beq
				if branch_eq = '1' then
					sel_RI <= '1';
					sel_Mux3 <= '0';
					sel_PC <= "10";
				end if;
			elsif(opcode(14 downto 12) = "001") then
				-- B bne
				if branch_eq = '0' then
					sel_RI <= '1';
					sel_Mux3 <= '0';
					sel_PC <= "10";
				end if;
			elsif(opcode(14 downto 12) = "100") then
				-- B blt
				if branch_lt = '1' then
					sel_RI <= '1';
					sel_Mux3 <= '0';
					sel_PC <= "10";
				end if;
			elsif(opcode(14 downto 12) = "101") then
				-- B bge
				if branch_lt = '0' then
					sel_RI <= '1';
					sel_Mux3 <= '0';
					sel_PC <= "10";
				end if;
			elsif(opcode(14 downto 12) = "110") then
				-- B bltu
				if branch_ltu = '1' then
					sel_RI <= '1';
					sel_Mux3 <= '0';
					sel_PC <= "10";
				end if;
			elsif(opcode(14 downto 12) = "111") then
				-- B bgeu
				if branch_ltu = '0' then
					sel_RI <= '1';
					sel_Mux3 <= '0';
					sel_PC <= "10";
				end if;
			end if;
		when "0000011" =>
			if(opcode(14 downto 12) = "000") then
				-- I lb
				sel_Alu <= "00001";
				sel_RI <= '1';
				sel_Mux1 <= '0';
				sel_Mux2 <= '1';
				sel_Mux0 <= "10";
				sel_RegFile <= '1';
			elsif(opcode(14 downto 12) = "001") then
				-- I lh
				sel_Alu <= "00001";
				sel_RI <= '1';
				sel_Mux1 <= '0';
				sel_Mux2 <= '1';
				sel_Mux0 <= "10";
				sel_RegFile <= '1';
			elsif(opcode(14 downto 12) = "010") then
				-- I lw
				sel_Alu <= "00001";
				sel_RI <= '1';
				sel_Mux1 <= '0';
				sel_Mux2 <= '1';
				sel_Mux0 <= "10";
				sel_RegFile <= '1';
			elsif(opcode(14 downto 12) = "100") then
				-- I lbu
				sel_Alu <= "00010";
				sel_RI <= '1';
				sel_Mux1 <= '0';
				sel_Mux2 <= '1';
				sel_Mux0 <= "10";
				sel_RegFile <= '1';
			elsif(opcode(14 downto 12) = "101") then
				--	I lhu
				sel_Alu <= "00010";
				sel_RI <= '1';
				sel_Mux1 <= '0';
				sel_Mux2 <= '1';
				sel_Mux0 <= "10";
				sel_RegFile <= '1';
			elsif(opcode(14 downto 12) = "110") then
				-- I lwu
				sel_Alu <= "00010";
				sel_RI <= '1';
				sel_Mux1 <= '0';
				sel_Mux2 <= '1';
				sel_Mux0 <= "10";
				sel_RegFile <= '1';
			elsif(opcode(14 downto 12) = "011") then
				-- I ld
				sel_Alu <= "00001";
				sel_RI <= '1';
				sel_Mux1 <= '0';
				sel_Mux2 <= '1';
				sel_Mux0 <= "10";
				sel_RegFile <= '1';
			end if;
		when "0100011" =>
			if(opcode(14 downto 12) = "000") then
				-- S sb
				sel_Alu <= "01111";
				sel_RI <= '1';
				sel_Mux1 <= '0';
				sel_Mux2 <= '1';
				sel_Mux0 <= "10";
				sel_RegFile <= '1';
			elsif(opcode(14 downto 12) = "001") then
				-- S sh
				sel_Alu <= "01111";
				sel_RI <= '1';
				sel_Mux1 <= '0';
				sel_Mux2 <= '1';
				sel_Mux0 <= "10";
				sel_RegFile <= '1';
			elsif(opcode(14 downto 12) = "010") then
				-- S sw
				sel_Alu <= "01111";
				sel_RI <= '1';
				sel_Mux1 <= '0';
				sel_Mux2 <= '1';
				sel_Mux0 <= "10";
				sel_RegFile <= '1';
			elsif(opcode(14 downto 12) = "011") then
				-- S sd
				sel_Alu <= "01111";
				sel_RI <= '1';
				sel_Mux1 <= '0';
				sel_Mux2 <= '1';
				sel_Mux0 <= "10";
				sel_RegFile <= '1';
			end if;
		when "0010011" =>
			if(opcode(14 downto 12) = "000") then
				if(opcode(31 downto 25) = "0000000") then
					-- R add
					sel_Alu <= "10000";
					sel_Mux1 <= '1';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				elsif(opcode(31 downto 25) = "0100000") then
					-- R sub
					sel_Alu <= "10001";
					sel_Mux1 <= '1';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				else
					-- I addi
					sel_Alu <= "00001";
					sel_Mux1 <= '0';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				end if;
			elsif(opcode(14 downto 12) = "010") then
				if(opcode(31 downto 25) = "0000000") then
					-- R slt
					sel_Alu <= "10011";
					sel_Mux1 <= '1';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				else
					-- I slti
					sel_Alu <= "11010";
					sel_Mux1 <= '0';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				end if;
			elsif(opcode(14 downto 12) = "011") then
				if(opcode(31 downto 25) = "0000000") then
					-- R sltu
					sel_Alu <= "10100";
					sel_Mux1 <= '1';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				else
					-- I sltiu
					sel_Alu <= "00100";
					sel_Mux1 <= '0';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				end if;
			elsif(opcode(14 downto 12) = "100") then
				if(opcode(31 downto 25) = "0000000") then
					-- R xor
					sel_Alu <= "10101";
					sel_Mux1 <= '1';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				else
					-- I xori
					sel_Alu <= "00101";
					sel_Mux1 <= '0';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				end if;
			elsif(opcode(14 downto 12) = "110") then
				if(opcode(31 downto 25) = "0000000") then
					-- R or
					sel_Alu <= "11000";
					sel_Mux1 <= '1';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				else
					-- I ori
					sel_Alu <= "00110";
					sel_Mux1 <= '0';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				end if;
			elsif(opcode(14 downto 12) = "111") then
				if(opcode(31 downto 25) = "0000000") then
					-- R and
					sel_Alu <= "11001";
					sel_Mux1 <= '1';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				else
					-- I andi
					sel_Alu <= "00111";
					sel_Mux1 <= '0';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				end if;
			elsif(opcode(14 downto 12) = "001") then
				if(opcode(31 downto 26) = "000000") then
					-- I slli
					sel_Alu <= "01000";
					sel_Mux1 <= '0';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				elsif(opcode(31 downto 25) = "0000000") then
					-- R sll
					sel_Alu <= "10010";
					sel_Mux1 <= '1';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				end if;
			elsif(opcode(14 downto 12) = "101") then
				if(opcode(31 downto 26) = "000000") then
					-- I srli
					sel_Alu <= "01010";
					sel_Mux1 <= '0';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				elsif(opcode(31 downto 26) = "010000") then
					-- I srai
					sel_Alu <= "01100";
					sel_Mux1 <= '0';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				elsif(opcode(31 downto 25) = "0000000") then
					-- R srl
					sel_Alu <= "10110";
					sel_Mux1 <= '1';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				elsif(opcode(31 downto 25) = "0100000") then
					-- R sra
					sel_Alu <= "10111";
					sel_Mux1 <= '1';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				end if; 	
			end if;
		when "0111011" =>
			if(opcode(14 downto 12) = "000") then
				if(opcode(31 downto 25) = "0000000") then
					-- R addw
					sel_Alu <= "10000";
					sel_Mux1 <= '1';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				elsif(opcode(31 downto 25) = "0100000") then
					-- R subw
					sel_Alu <= "10001";
					sel_Mux1 <= '1';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				end if;
			elsif(opcode(14 downto 12) = "001") then
				if(opcode(31 downto 25) = "0000000") then
					-- R sllw
					sel_Alu <= "10010";
					sel_Mux1 <= '1';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				end if;
			elsif(opcode(14 downto 12) = "101") then
				if(opcode(31 downto 25) = "0000000") then
					-- R srlw
					sel_Alu <= "10110";
					sel_Mux1 <= '1';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				elsif(opcode(31 downto 25) = "0100000") then
					-- R sraw
					sel_Alu <= "10111";
					sel_Mux1 <= '1';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				end if;
			end if; 
		when "0011011" =>
			if(opcode(14 downto 12) = "000") then
				-- I addiw
				sel_Alu <= "00011";
				sel_Mux1 <= '0';
				sel_Mux2 <= '1';
				sel_Mux0 <= "10";
				sel_RI <= '1';
				sel_RegFile <= '1';
			elsif(opcode(14 downto 12) = "001") then
				if(opcode(31 downto 25) = "0000000") then
					-- I slliw
					sel_Alu <= "01001";
					sel_Mux1 <= '0';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
			elsif(opcode(14 downto 12) = "101") then
				if(opcode(31 downto 25) = "0000000") then
					-- I srliw
					sel_Alu <= "01011";
					sel_Mux1 <= '0';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				elsif(opcode(31 downto 25) = "0100000") then
					-- I sraiw
					sel_Alu <= "01101";
					sel_Mux1 <= '0';
					sel_Mux2 <= '1';
					sel_Mux0 <= "10";
					sel_RI <= '1';
					sel_RegFile <= '1';
				end if;
			end if;
		end if;
		when others =>
			
	end case;
	
end process;
end ctrl;