library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

entity alu1 is port (

IN2,IN1 : in std_logic_vector (63 downto 0);
sel : in std_logic_vector (4 downto 0);
S: out std_logic_vector(63 downto 0)
);

end entity;

architecture hardware of alu1 is 

signal ext32 : std_logic_vector(31 downto 0);
signal aux64 : std_logic_vector(63 downto 0);
signal aux2_64 : std_logic_vector(63 downto 0);

begin
	process(sel, ext32, aux64, aux2_64, IN1, IN2)
	begin
		if IN2(31) = '1' then
			ext32 <= "11111111111111111111111111111111";
		else
			ext32 <= "00000000000000000000000000000000";
		end if;
		case sel is
			when "00000" =>
				S <= ext32 & IN2(31 DOWNTO 12) & "000000000000"; --lui/auipc
				
			when "00001" =>
				S <= std_logic_vector(signed(ext32 & ext32(31 DOWNTO 11) & IN1(30 DOWNTO 20)) + (signed(IN2))); --lb/lh/lw/ld/addi/jalr
				
			when "00010" =>
				S <= std_logic_vector(unsigned(ext32 & ext32(31 DOWNTO 11) & IN1(30 DOWNTO 20)) + (unsigned(IN2))); --lbu/lhu/lwu
				
			when "00011" =>
				aux64(31 downto 0) <= std_logic_vector(signed(ext32(31 DOWNTO 11) & IN1(30 DOWNTO 20)) + (signed(IN2(31 downto 0))));
				if aux2_64(31) = '1' then
					ext32 <= "11111111111111111111111111111111";
				else
					ext32 <= "00000000000000000000000000000000"; -- addiw
				end if;
				S <= ext32 & aux2_64(31 downto 0);
				
			when "00100" =>
				aux64 <= ext32 & ext32(31 downto 11) & IN1(30 downto 20);
				if (unsigned(IN2) < unsigned(aux64)) then
					S <= "1111111111111111111111111111111111111111111111111111111111111111";
				else	
					S <= "0000000000000000000000000000000000000000000000000000000000000000";
				end if; --sltiu
				
			when "00101" =>
				S <= (ext32 & ext32(31 DOWNTO 11) & IN1(30 DOWNTO 20)) XOR IN2; --xori
				
			when "00110" =>
				S <= (ext32 & ext32(31 DOWNTO 11) & IN1(30 DOWNTO 20)) OR IN2;  --ori
				
			when "00111" =>
				S <= (ext32 & ext32(31 DOWNTO 11) & IN1(30 DOWNTO 20)) AND IN2; --andi
				
			when "01000" =>
				S <= std_logic_vector(shift_left(unsigned(IN2), to_integer(unsigned(IN1(25 downto 20))))); --slli
				
			when "01001" =>
				aux64 <= std_logic_vector(shift_left(unsigned(IN2), to_integer(unsigned(IN1(25 downto 0)))));
				if aux64(31) = '1' then
					ext32 <= "11111111111111111111111111111111";
				else
					ext32 <= "00000000000000000000000000000000";
				end if;
				S <= ext32 & aux64(31 downto 0); --slliw
				
			when "01010" =>
				S <= std_logic_vector(shift_right(unsigned(IN2), to_integer(unsigned(IN1(25 downto 0)))));--srli
				
			when "01011" =>
				aux64 <= std_logic_vector(shift_right(unsigned(IN2), to_integer(unsigned(IN1(25 downto 0)))));
				if aux64(31) = '1' then
					ext32 <= "11111111111111111111111111111111";
				else
					ext32 <= "00000000000000000000000000000000";
				end if;
				S <= ext32 & aux64(31 downto 0); --srliw
				
			when "01100" =>
				if IN2(63) = '1' then
					aux2_64 <= "1111111111111111111111111111111111111111111111111111111111111111";
				else
					aux2_64 <= "0000000000000000000000000000000000000000000000000000000000000000";
				end if;
				aux64 <= std_logic_vector(shift_right(unsigned(IN2), to_integer(unsigned(IN1(25 downto 20)))));
				--aux64(63 downto to_integer(unsigned(IN1(25 downto 20)))) <=  aux2_64(63 downto to_integer(unsigned(IN1(25 downto 0))));
				aux2_64(to_integer(unsigned(IN1(25 downto 20))) downto 0) <= aux64(to_integer(unsigned(IN1(25 downto 20))) downto 0);
				S <= aux2_64; --srai
				
			when "01101" =>
				if IN2(31) = '1' then
					aux2_64 <= "1111111111111111111111111111111111111111111111111111111111111111";
				else
					aux2_64 <= "0000000000000000000000000000000000000000000000000000000000000000";
				end if;
				aux64 <= std_logic_vector(shift_right(unsigned(IN2), to_integer(unsigned(IN1(25 downto 20)))));
				--aux64(63 downto to_integer(unsigned(IN1(25 downto 20)))) <=  aux2_64(63 downto to_integer(unsigned(IN1(25 downto 0))));
				aux2_64(to_integer(unsigned(IN1(25 downto 20))) downto 0) <= aux2_64(to_integer(unsigned(IN1(25 downto 20))) downto 0);
				S <= aux2_64; --sraiw
				
			when "01110" =>
				S <= std_logic_vector(signed(ext32 & ext32(31 DOWNTO 20) & IN1(19 DOWNTO 12) & IN1(20) & IN1(30 DOWNTO 25) & IN1(24 DOWNTO 21) & '0') + signed(IN2)); -- jal
				
			when "01111" =>
				S <= std_logic_vector(signed(ext32 & ext32(31 DOWNTO 11) & IN1(30 DOWNTO 25)  & IN1(11 DOWNTO 8) & IN1(7)) + signed(IN2));  -- sb/sh/sw/sd
				
			when "10000" =>
				S <= std_logic_vector(signed(IN1) + signed(IN2)); --add/addw
				
			when "10001" =>
				S <= std_logic_vector(signed(IN2) - signed(IN1)); --sub/subw
				
			when "10010" =>
				S <= std_logic_vector(shift_left(unsigned(IN2), to_integer(unsigned(IN1(5 downto 0)))));--sll/sllw
				
			when "10011" =>
				if IN2<IN1 then
					S <= "0000000000000000000000000000000000000000000000000000000000000001"; --slt
				else
					S <= "0000000000000000000000000000000000000000000000000000000000000000"; --slt
				end if;
				
			when "10100" =>
				if unsigned(IN2)<unsigned(IN1) then
					S <= "0000000000000000000000000000000000000000000000000000000000000001"; --sltu
				else
					S <= "0000000000000000000000000000000000000000000000000000000000000000"; --sltu
				end if;
				
			when "10101" =>
				S <= IN2 xor (ext32 & ext32(31 downto 12) & IN1(31 downto 20));
				
			when "10110" =>
				S <= std_logic_vector(shift_right(unsigned(IN2), to_integer(unsigned(IN1(5 downto 0))))); -- srl/srlw
				
			when "10111" =>
				if IN2(63) = '1' then
					aux2_64 <= "1111111111111111111111111111111111111111111111111111111111111111";
				else
					aux2_64 <= "0000000000000000000000000000000000000000000000000000000000000000";
				end if;
				aux64 <= std_logic_vector(shift_right(unsigned(IN2), to_integer(unsigned(IN1(5 downto 0)))));
				aux64(63 downto to_integer(unsigned(IN1(5 downto 0)))) <=  aux2_64(63 downto to_integer(unsigned(IN1(5 downto 0))));
				S <= aux64; -- sra/sraw
				
			when "11000" =>
				S <= IN2 or IN1; --or
				
			when "11001" =>
				S <= IN2 and IN1; -- and
				
			when "11010" =>
				if IN2 < (ext32 & ext32(31 DOWNTO 11) & IN1(30 DOWNTO 20)) then
					S <= ext32 & ext32(31 DOWNTO 1) & '1'; --slti
				else
					S <= ext32 & ext32(31 DOWNTO 1) & '0'; --slti
				end if;
				
			when others =>
				S <= ext32 & ext32;
				
		end case;
	end process;
end architecture;
