library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--OBSERVAÇÃO, PARA OS DADOS DESALINHADOS A MEMORIA ESTÁ ARMAZENANDO/LENDO DADOS APENAS NA MESMA LINHA
--PARA CORRIGIR ISSO SERÁ NECESSÁRIO CRIAR UM "ADDRESS AUXILIAR" E ADICINAR EM CADA CONDIÇÃO UMA SOMA DE
--address+POSIÇÕES DO DESALINHAMENTO

--comportamento "unsafe" por causa do rw_aux, verificar os ifs

entity memoria is port(
	rw,clk: in std_logic;
	largura: in std_logic_vector(2 downto 0);
	address: in std_logic_vector(13 downto 0);
	datain: in std_logic_vector(63 downto 0);
	dataout: out std_logic_vector(63 downto 0)
);
end entity;

architecture hardware of memoria is
signal data0,data1,data2,data3,data4,data5,data6,data7,
		 out0,out1,out2,out3,out4,out5,out6,out7,
		 rw_aux: std_logic_vector(7 downto 0);
signal address0,address1,address2,address3,address4,address5,address6,address7,address_aux: std_logic_vector(10 downto 0);
signal ext32,uns,zeros: std_logic_vector(31 downto 0);

component UnidadeDeMemoria
port (
	address		: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
	clock		: IN STD_LOGIC  := '1';
	data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	wren		: IN STD_LOGIC ;
	q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
end component;

begin

uns <= "11111111111111111111111111111111";
zeros <= "00000000000000000000000000000000";
address_aux <= std_logic_vector(unsigned(address(13 downto 3)) + 1);

-- process dos endereços e rw'
process(address,largura,rw,address_aux,clk)
	begin
		address0 <= address(13 downto 3);
		address1 <= address(13 downto 3);
		address2 <= address(13 downto 3);
		address3 <= address(13 downto 3);
		address4 <= address(13 downto 3);
		address5 <= address(13 downto 3);
		address6 <= address(13 downto 3);
		address7 <= address(13 downto 3);
		rw_aux <= "00000000";
		--instruções de store
		if(rw = '1') then
			-- store alinhado
			if(address(2 downto 0) = "000") then
				--store byte
				if(largura = "000") then
					rw_aux <= "00000001";
				end if;
				--store halfword
				if(largura = "001") then
					rw_aux <= "00000011";
				end if;
				--store word
				if(largura = "010") then
					rw_aux <= "00001111";
				end if;
				--store doubleword
				if(largura = "011") then
					rw_aux <= "11111111";
				end if;
			
			-- store desalinhado 1 byte
			elsif(address(2 downto 0) = "001") then
				--store byte
				if(largura = "000") then
					rw_aux <= "00000010";
				end if;
				--store halfword
				if(largura = "001") then
					rw_aux <= "00000110";
				end if;
				--store word
				if(largura = "010") then
					rw_aux <= "00011110";
				end if;
				--store doubleword
				if(largura = "011") then
					rw_aux <= "11111111";
					address0 <= address_aux;
				end if;
				
			-- store desalinhado 2 bytes
			elsif(address(2 downto 0) = "010") then
				--store byte
				if(largura = "000") then
					rw_aux <= "00000100";
				end if;
				--store halfword
				if(largura = "001") then
					rw_aux <= "00001100";
				end if;
				--store word
				if(largura = "010") then
					rw_aux <= "00111100";
				end if;
				--store doubleword
				if(largura = "011") then
					rw_aux <= "11111111";
					address0 <= address_aux;
					address1 <= address_aux;
				end if;	
				
			-- store desalinhado 3 bytes
			elsif(address(2 downto 0) = "011") then
				--store byte
				if(largura = "000") then
					rw_aux <= "00001000";
				end if;
				--store halfword
				if(largura = "001") then
					rw_aux <= "00011000";
				end if;
				--store word
				if(largura = "010") then
					rw_aux <= "01111000";
				end if;
				--store doubleword
				if(largura = "011") then
					rw_aux <= "11111111";
					address0 <= address_aux;
					address1 <= address_aux;
					address2 <= address_aux;
				end if;	
			
			-- store desalinhado 4 bytes
			elsif(address(2 downto 0) = "100") then
				--store byte
				if(largura = "000") then
					rw_aux <= "00010000";
				end if;
				--store halfword
				if(largura = "001") then
					rw_aux <= "00110000";
				end if;
				--store word
				if(largura = "010") then
					rw_aux <= "11110000";
				end if;
				--store doubleword
				if(largura = "011") then
					rw_aux <= "11111111";
					address0 <= address_aux;
					address1 <= address_aux;
					address2 <= address_aux;
					address3 <= address_aux;
				end if;	
			
			-- store desalinhado 5 bytes
			elsif(address(2 downto 0) = "101") then
				--store byte
				if(largura = "000") then
					rw_aux <= "00100000";
				end if;
				--store halfword
				if(largura = "001") then
					rw_aux <= "01100000";
				end if;
				--store word
				if(largura = "010") then
					rw_aux <= "11100001";
					address0 <= address_aux;
				end if;
				--store doubleword
				if(largura = "011") then
					rw_aux <= "11111111";
					address0 <= address_aux;
					address1 <= address_aux;
					address2 <= address_aux;
					address3 <= address_aux;
					address4 <= address_aux;
				end if;	
				
			-- store desalinhado 6 bytes
			elsif(address(2 downto 0) = "110") then
				--store byte
				if(largura = "000") then
					rw_aux <= "01000000";
				end if;
				--store halfword
				if(largura = "001") then
					rw_aux <= "11000000";
				end if;
				--store word
				if(largura = "010") then
					rw_aux <= "11000011";
					address0 <= address_aux;
					address1 <= address_aux;
				end if;
				--store doubleword
				if(largura = "011") then
					rw_aux <= "11111111";
					address0 <= address_aux;
					address1 <= address_aux;
					address2 <= address_aux;
					address3 <= address_aux;
					address4 <= address_aux;
					address5 <= address_aux;
				end if;	
				
			-- store desalinhado 7 bytes
			elsif(address(2 downto 0) = "111") then
				--store byte
				if(largura = "000") then
					rw_aux <= "10000000";
				end if;
				--store halfword
				if(largura = "001") then
					rw_aux <= "10000001";
					address0 <= address_aux;
				end if;
				--store word
				if(largura = "010") then
					rw_aux <= "10000111";
					address0 <= address_aux;
					address1 <= address_aux;
					address2 <= address_aux;
				end if;
				--store doubleword
				if(largura = "011") then
					rw_aux <= "11111111";
					address0 <= address_aux;
					address1 <= address_aux;
					address2 <= address_aux;
					address3 <= address_aux;
					address4 <= address_aux;
					address5 <= address_aux;
					address6 <= address_aux;
				end if;	
			
			end if;
			
		--instruções load
		elsif(rw = '0') then
			
			--load alinhado
			if (address(2 downto 0) = "000") then
				--load byte
				if(largura = "000") then
				end if;
				--load halfword
				if(largura = "001") then
				end if;
				--load word
				if(largura = "010") then
				end if;
				--load byte unsigned
				if(largura = "100") then
				end if;
				--load halfword unsigned
				if(largura = "101") then
				end if;
				--load word unsigned
				if(largura = "110") then
				end if;
				--load doubleword
				if(largura = "011") then
				end if;
				
			--load desalinhado 1 byte
			elsif (address(2 downto 0) = "001") then
				--load byte
				if(largura = "000") then
				end if;
				--load halfword
				if(largura = "001") then
				end if;
				--load word
				if(largura = "010") then
				end if;
				--load byte unsigned
				if(largura = "100") then
				end if;
				--load halfword unsigned
				if(largura = "101") then
				end if;
				--load word unsigned
				if(largura = "110") then
				end if;
				--load doubleword
				if(largura = "011") then
					address0 <= address_aux;
				end if;
				
			--load desalinhado 2 bytes
			elsif (address(2 downto 0) = "010") then
				--load byte
				if(largura = "000") then
				end if;
				--load halfword
				if(largura = "001") then
				end if;
				--load word
				if(largura = "010") then
				end if;
				--load byte unsigned
				if(largura = "100") then
				end if;
				--load halfword unsigned
				if(largura = "101") then
				end if;
				--load word unsigned
				if(largura = "110") then
				end if;
				--load doubleword
				if(largura = "011") then
					address0 <= address_aux;
					address1 <= address_aux;
				end if;
			
			--load desalinhado 3 bytes
			elsif (address(2 downto 0) = "011") then
				--load byte
				if(largura = "000") then
				end if;
				--load halfword
				if(largura = "001") then
				end if;
				--load word
				if(largura = "010") then
				end if;
				--load byte unsigned
				if(largura = "100") then
				end if;
				--load halfword unsigned
				if(largura = "101") then
				end if;
				--load word unsigned
				if(largura = "110") then
				end if;
				--load doubleword
				if(largura = "011") then
					address0 <= address_aux;
					address1 <= address_aux;
					address2 <= address_aux;
				end if;
			
			--load desalinhado 4 bytes
			elsif (address(2 downto 0) = "100") then
				--load byte
				if(largura = "000") then
				end if;
				--load halfword
				if(largura = "001") then
				end if;
				--load word
				if(largura = "010") then
				end if;
				--load byte unsigned
				if(largura = "100") then
				end if;
				--load halfword unsigned
				if(largura = "101") then
				end if;
				--load word unsigned
				if(largura = "110") then
				end if;
				--load doubleword
				if(largura = "011") then
					address0 <= address_aux;
					address1 <= address_aux;
					address2 <= address_aux;
					address3 <= address_aux;
				end if;
			
			--load desalinhado 5 bytes
			elsif (address(2 downto 0) = "101") then
				--load byte
				if(largura = "000") then
				end if;
				--load halfword
				if(largura = "001") then
				end if;
				--load word
				if(largura = "010") then
					address0 <= address_aux;
				end if;
				--load byte unsigned
				if(largura = "100") then
				end if;
				--load halfword unsigned
				if(largura = "101") then
				end if;
				--load word unsigned
				if(largura = "110") then
					address0 <= address_aux;
				end if;
				--load doubleword
				if(largura = "011") then
					address0 <= address_aux;
					address1 <= address_aux;
					address2 <= address_aux;
					address3 <= address_aux;
					address4 <= address_aux;
				end if;

			--load desalinhado 6 bytes
			elsif (address(2 downto 0) = "110") then
				--load byte
				if(largura = "000") then
				end if;
				--load halfword
				if(largura = "001") then
				end if;
				--load word
				if(largura = "010") then
					address0 <= address_aux;
					address1 <= address_aux;
				end if;
				--load byte unsigned
				if(largura = "100") then
				end if;
				--load halfword unsigned
				if(largura = "101") then
				end if;
				--load word unsigned
				if(largura = "110") then
					address0 <= address_aux;
					address1 <= address_aux;
				end if;
				--load doubleword
				if(largura = "011") then
					address0 <= address_aux;
					address1 <= address_aux;
					address2 <= address_aux;
					address3 <= address_aux;
					address4 <= address_aux;
					address5 <= address_aux;
				end if;
			
			--load desalinhado 7 bytes
			elsif (address(2 downto 0) = "111") then
				--load byte
				if(largura = "000") then
				end if;
				--load halfword
				if(largura = "001") then
					address0 <= address_aux;
				end if;
				--load word
				if(largura = "010") then
					address0 <= address_aux;
					address1 <= address_aux;
					address2 <= address_aux;
				end if;
				--load byte unsigned
				if(largura = "100") then
				end if;
				--load halfword unsigned
				if(largura = "101") then
				end if;
				--load word unsigned
				if(largura = "110") then
					address0 <= address_aux;
					address1 <= address_aux;
					address2 <= address_aux;
				end if;
				--load doubleword
				if(largura = "011") then
					address0 <= address_aux;
					address1 <= address_aux;
					address2 <= address_aux;
					address3 <= address_aux;
					address4 <= address_aux;
					address5 <= address_aux;
					address6 <= address_aux;
				end if;
			
			end if;
		end if;
end process;		
	

-- process dos dados
process(address,largura,rw,out0,out1,out2,out3,out4,out5,out6,out7,ext32,zeros,uns,datain,clk )
	begin
		data7 <= zeros(7 downto 0);
		data6 <= zeros(7 downto 0);
		data5 <= zeros(7 downto 0);
		data4 <= zeros(7 downto 0);
		data3 <= zeros(7 downto 0);
		data2 <= zeros(7 downto 0);
		data1 <= zeros(7 downto 0);
		data0 <= zeros(7 downto 0);
		ext32 <= zeros;
		dataout <= zeros & zeros;
		--instruções de store
		if(rw = '1') then
			-- store alinhado
			if(address(2 downto 0) = "000") then
				--store byte
				if(largura = "000") then
					data0 <= datain(7 downto 0);
				end if;
				--store halfword
				if(largura = "001") then
					data1 <= datain(15 downto 8);
					data0 <= datain(7 downto 0);
				end if;
				--store word
				if(largura = "010") then
					data3 <= datain(31 downto 24);
					data2 <= datain(23 downto 16);
					data1 <= datain(15 downto 8);
					data0 <= datain(7 downto 0);
				end if;
				--store doubleword
				if(largura = "011") then
					data7 <= datain(63 downto 56);
					data6 <= datain(55 downto 48);
					data5 <= datain(47 downto 40);
					data4 <= datain(39 downto 32);
					data3 <= datain(31 downto 24);
					data2 <= datain(23 downto 16);
					data1 <= datain(15 downto 8);
					data0 <= datain(7 downto 0);
				end if;
			
			-- store desalinhado 1 byte
			elsif(address(2 downto 0) = "001") then
				--store byte
				if(largura = "000") then
					data1 <= datain(7 downto 0);
				end if;
				--store halfword
				if(largura = "001") then
					data2 <= datain(15 downto 8);
					data1 <= datain(7 downto 0);
				end if;
				--store word
				if(largura = "010") then
					data4 <= datain(31 downto 24);
					data3 <= datain(23 downto 16);
					data2 <= datain(15 downto 8);
					data1 <= datain(7 downto 0);
				end if;
				--store doubleword
				if(largura = "011") then
					data0 <= datain(63 downto 56);
					data7 <= datain(55 downto 48);
					data6 <= datain(47 downto 40);
					data5 <= datain(39 downto 32);
					data4 <= datain(31 downto 24);
					data3 <= datain(23 downto 16);
					data2 <= datain(15 downto 8);
					data1 <= datain(7 downto 0);
				end if;
				
			-- store desalinhado 2 bytes
			elsif(address(2 downto 0) = "010") then
				--store byte
				if(largura = "000") then
					data2 <= datain(7 downto 0);
				end if;
				--store halfword
				if(largura = "001") then
					data3 <= datain(15 downto 8);
					data2 <= datain(7 downto 0);
				end if;
				--store word
				if(largura = "010") then
					data5 <= datain(31 downto 24);
					data4 <= datain(23 downto 16);
					data3 <= datain(15 downto 8);
					data2 <= datain(7 downto 0);
				end if;
				--store doubleword
				if(largura = "011") then
					data1 <= datain(63 downto 56);
					data0 <= datain(55 downto 48);
					data7 <= datain(47 downto 40);
					data6 <= datain(39 downto 32);
					data5 <= datain(31 downto 24);
					data4 <= datain(23 downto 16);
					data3 <= datain(15 downto 8);
					data2 <= datain(7 downto 0);
				end if;	
				
			-- store desalinhado 3 bytes
			elsif(address(2 downto 0) = "011") then
				--store byte
				if(largura = "000") then
					data3 <= datain(7 downto 0);
				end if;
				--store halfword
				if(largura = "001") then
					data4 <= datain(15 downto 8);
					data3 <= datain(7 downto 0);
				end if;
				--store word
				if(largura = "010") then
					data6 <= datain(31 downto 24);
					data5 <= datain(23 downto 16);
					data4 <= datain(15 downto 8);
					data3 <= datain(7 downto 0);
				end if;
				--store doubleword
				if(largura = "011") then
					data2 <= datain(63 downto 56);
					data1 <= datain(55 downto 48);
					data0 <= datain(47 downto 40);
					data7 <= datain(39 downto 32);
					data6 <= datain(31 downto 24);
					data5 <= datain(23 downto 16);
					data4 <= datain(15 downto 8);
					data3 <= datain(7 downto 0);
				end if;	
			
			-- store desalinhado 4 bytes
			elsif(address(2 downto 0) = "100") then
				--store byte
				if(largura = "000") then
					data4 <= datain(7 downto 0);
				end if;
				--store halfword
				if(largura = "001") then
					data5 <= datain(15 downto 8);
					data4 <= datain(7 downto 0);
				end if;
				--store word
				if(largura = "010") then
					data7 <= datain(31 downto 24);
					data6 <= datain(23 downto 16);
					data5 <= datain(15 downto 8);
					data4 <= datain(7 downto 0);
				end if;
				--store doubleword
				if(largura = "011") then
					data3 <= datain(63 downto 56);
					data2 <= datain(55 downto 48);
					data1 <= datain(47 downto 40);
					data0	<= datain(39 downto 32);
					data7 <= datain(31 downto 24);
					data6 <= datain(23 downto 16);
					data5 <= datain(15 downto 8);
					data4 <= datain(7 downto 0);
				end if;	
			
			-- store desalinhado 5 bytes
			elsif(address(2 downto 0) = "101") then
				--store byte
				if(largura = "000") then
					data5 <= datain(7 downto 0);
				end if;
				--store halfword
				if(largura = "001") then
					data6 <= datain(15 downto 8);
					data5 <= datain(7 downto 0);
				end if;
				--store word
				if(largura = "010") then
					data0 <= datain(31 downto 24);
					data7 <= datain(23 downto 16);
					data6 <= datain(15 downto 8);
					data5 <= datain(7 downto 0);
				end if;
				--store doubleword
				if(largura = "011") then
					data4 <= datain(63 downto 56);
					data3 <= datain(55 downto 48);
					data2 <= datain(47 downto 40);
					data1	<= datain(39 downto 32);
					data0 <= datain(31 downto 24);
					data7 <= datain(23 downto 16);
					data6 <= datain(15 downto 8);
					data5 <= datain(7 downto 0);
				end if;	
				
			-- store desalinhado 6 bytes
			elsif(address(2 downto 0) = "110") then
				--store byte
				if(largura = "000") then
					data6 <= datain(7 downto 0);
				end if;
				--store halfword
				if(largura = "001") then
					data7 <= datain(15 downto 8);
					data6 <= datain(7 downto 0);
				end if;
				--store word
				if(largura = "010") then
					data1 <= datain(31 downto 24);
					data0 <= datain(23 downto 16);
					data7 <= datain(15 downto 8);
					data6 <= datain(7 downto 0);
				end if;
				--store doubleword
				if(largura = "011") then
					data5 <= datain(63 downto 56);
					data4 <= datain(55 downto 48);
					data3 <= datain(47 downto 40);
					data2	<= datain(39 downto 32);
					data1 <= datain(31 downto 24);
					data0 <= datain(23 downto 16);
					data7 <= datain(15 downto 8);
					data6 <= datain(7 downto 0);
				end if;	
				
			-- store desalinhado 7 bytes
			elsif(address(2 downto 0) = "111") then
				--store byte
				if(largura = "000") then
					data7 <= datain(7 downto 0);
				end if;
				--store halfword
				if(largura = "001") then
					data0 <= datain(15 downto 8);
					data7 <= datain(7 downto 0);
				end if;
				--store word
				if(largura = "010") then
					data2 <= datain(31 downto 24);
					data1 <= datain(23 downto 16);
					data0 <= datain(15 downto 8);
					data7 <= datain(7 downto 0);
				end if;
				--store doubleword
				if(largura = "011") then
					data6 <= datain(63 downto 56);
					data5 <= datain(55 downto 48);
					data4 <= datain(47 downto 40);
					data3	<= datain(39 downto 32);
					data2 <= datain(31 downto 24);
					data1 <= datain(23 downto 16);
					data0 <= datain(15 downto 8);
					data7 <= datain(7 downto 0);
				end if;	
			
			end if;
			
		--instruções load
		elsif(rw = '0') then
			
			--load alinhado
			if (address(2 downto 0) = "000") then
				--load byte
				if(largura = "000") then
					if(out0(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 8) & out0;
				end if;
				--load halfword
				if(largura = "001") then
					if(out1(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 16) & out1 & out0;
				end if;
				--load word
				if(largura = "010") then
					if(out3(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & out3 & out2 & out1 & out0;
				end if;
				--load byte unsigned
				if(largura = "100") then
					dataout <= zeros & zeros(31 downto 8) & out0;
				end if;
				--load halfword unsigned
				if(largura = "101") then
					dataout <= zeros & zeros(31 downto 16) & out1 & out0;
				end if;
				--load word unsigned
				if(largura = "110") then
					dataout <= zeros & out3 & out2 & out1 & out0;
				end if;
				--load doubleword
				if(largura = "011") then
					dataout <= out7 & out6 & out5 & out4 & out3 & out2 & out1 & out0;
				end if;
				
			--load desalinhado 1 byte
			elsif (address(2 downto 0) = "001") then
				--load byte
				if(largura = "000") then
					if(out1(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 8) & out1;
				end if;
				--load halfword
				if(largura = "001") then
					if(out2(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 16) & out2 & out1;
				end if;
				--load word
				if(largura = "010") then
					if(out4(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & out4 & out3 & out2 & out1;
				end if;
				--load byte unsigned
				if(largura = "100") then
					dataout <= zeros & zeros(31 downto 8) & out1;
				end if;
				--load halfword unsigned
				if(largura = "101") then
					dataout <= zeros & zeros(31 downto 16) & out2 & out1;
				end if;
				--load word unsigned
				if(largura = "110") then
					dataout <= zeros & out4 & out3 & out2 & out1;
				end if;
				--load doubleword
				if(largura = "011") then
					dataout <= out0 & out7 & out6 & out5 & out4 & out3 & out2 & out1;
				end if;
				
			--load desalinhado 2 bytes
			elsif (address(2 downto 0) = "010") then
				--load byte
				if(largura = "000") then
					if(out2(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 8) & out2;
				end if;
				--load halfword
				if(largura = "001") then
					if(out3(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 16) & out3 & out2;
				end if;
				--load word
				if(largura = "010") then
					if(out5(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & out5 & out4 & out3 & out2;
				end if;
				--load byte unsigned
				if(largura = "100") then
					dataout <= zeros & zeros(31 downto 8) & out2;
				end if;
				--load halfword unsigned
				if(largura = "101") then
					dataout <= zeros & zeros(31 downto 16) & out3 & out2;
				end if;
				--load word unsigned
				if(largura = "110") then
					dataout <= zeros & out5 & out4 & out3 & out2;
				end if;
				--load doubleword
				if(largura = "011") then
					dataout <= out1 & out0 & out7 & out6 & out5 & out4 & out3 & out2;
				end if;
			
			--load desalinhado 3 bytes
			elsif (address(2 downto 0) = "011") then
				--load byte
				if(largura = "000") then
					if(out3(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 8) & out3;
				end if;
				--load halfword
				if(largura = "001") then
					if(out4(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 16) & out4 & out3;
				end if;
				--load word
				if(largura = "010") then
					if(out6(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & out6 & out5 & out4 & out3;
				end if;
				--load byte unsigned
				if(largura = "100") then
					dataout <= zeros & zeros(31 downto 8) & out3;
				end if;
				--load halfword unsigned
				if(largura = "101") then
					dataout <= zeros & zeros(31 downto 16) & out4 & out3;
				end if;
				--load word unsigned
				if(largura = "110") then
					dataout <= zeros & out6 & out5 & out4 & out3;
				end if;
				--load doubleword
				if(largura = "011") then
					dataout <= out2 & out1 & out0 & out7 & out6 & out5 & out4 & out3;
				end if;
			
			--load desalinhado 4 bytes
			elsif (address(2 downto 0) = "100") then
				--load byte
				if(largura = "000") then
					if(out4(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 8) & out4;
				end if;
				--load halfword
				if(largura = "001") then
					if(out5(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 16) & out5 & out4;
				end if;
				--load word
				if(largura = "010") then
					if(out7(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & out7 & out6 & out5 & out4;
				end if;
				--load byte unsigned
				if(largura = "100") then
					dataout <= zeros & zeros(31 downto 8) & out4;
				end if;
				--load halfword unsigned
				if(largura = "101") then
					dataout <= zeros & zeros(31 downto 16) & out5 & out4;
				end if;
				--load word unsigned
				if(largura = "110") then
					dataout <= zeros & out7 & out6 & out5 & out4;
				end if;
				--load doubleword
				if(largura = "011") then
					dataout <= out3 & out2 & out1 & out0 & out7 & out6 & out5 & out4;
				end if;
			
			--load desalinhado 5 bytes
			elsif (address(2 downto 0) = "101") then
				--load byte
				if(largura = "000") then
					if(out5(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 8) & out5;
				end if;
				--load halfword
				if(largura = "001") then
					if(out6(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 16) & out6 & out5;
				end if;
				--load word
				if(largura = "010") then
					if(out0(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & out0 & out7 & out6 & out5;
				end if;
				--load byte unsigned
				if(largura = "100") then
					dataout <= zeros & zeros(31 downto 8) & out5;
				end if;
				--load halfword unsigned
				if(largura = "101") then
					dataout <= zeros & zeros(31 downto 16) & out6 & out5;
				end if;
				--load word unsigned
				if(largura = "110") then
					dataout <= zeros & out0 & out7 & out6 & out5;
				end if;
				--load doubleword
				if(largura = "011") then
					dataout <= out4 & out3 & out2 & out1 & out0 & out7 & out6 & out5;
				end if;
			
			--load desalinhado 6 bytes
			elsif (address(2 downto 0) = "110") then
				--load byte
				if(largura = "000") then
					if(out6(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 8) & out6;
				end if;
				--load halfword
				if(largura = "001") then
					if(out7(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 16) & out7 & out6;
				end if;
				--load word
				if(largura = "010") then
					if(out1(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & out1 & out0 & out7 & out6;
				end if;
				--load byte unsigned
				if(largura = "100") then
					dataout <= zeros & zeros(31 downto 8) & out6;
				end if;
				--load halfword unsigned
				if(largura = "101") then
					dataout <= zeros & zeros(31 downto 16) & out7 & out6;
				end if;
				--load word unsigned
				if(largura = "110") then
					dataout <= zeros & out1 & out0 & out7 & out6;
				end if;
				--load doubleword
				if(largura = "011") then
					dataout <= out5 & out4 & out3 & out2 & out1 & out0 & out7 & out6;
				end if;
			
			--load desalinhado 7 bytes
			elsif (address(2 downto 0) = "111") then
				--load byte
				if(largura = "000") then
					if(out7(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 8) & out7;
				end if;
				--load halfword
				if(largura = "001") then
					if(out0(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & ext32(31 downto 16) & out0 & out7;
				end if;
				--load word
				if(largura = "010") then
					if(out2(7) = '1') then
						ext32 <= uns;
					else
						ext32 <= zeros;
					end if;
					dataout <= ext32 & out2 & out1 & out0 & out7;
				end if;
				--load byte unsigned
				if(largura = "100") then
					dataout <= zeros & zeros(31 downto 8) & out7;
				end if;
				--load halfword unsigned
				if(largura = "101") then
					dataout <= zeros & zeros(31 downto 16) & out0 & out7;
				end if;
				--load word unsigned
				if(largura = "110") then
					dataout <= zeros & out2 & out1 & out0 & out7;
				end if;
				--load doubleword
				if(largura = "011") then
					dataout <= out6 & out5 & out4 & out3 & out2 & out1 & out0 & out7;
				end if;
			
			end if;
		end if;
end process;

UM0 : UnidadeDeMemoria port map (
	address => address0,
	clock	=> clk,
	data => data0,
	wren => rw_aux(0),
	q => out0
);

UM1 : UnidadeDeMemoria port map (
	address => address1,
	clock	=> clk,
	data => data1,
	wren => rw_aux(1),
	q => out1
);

UM2 : UnidadeDeMemoria port map (
	address => address2,
	clock	=> clk,
	data => data2,
	wren => rw_aux(2),
	q => out2
);

UM3 : UnidadeDeMemoria port map (
	address => address3,
	clock	=> clk,
	data => data3,
	wren => rw_aux(3),
	q => out3
);

UM4 : UnidadeDeMemoria port map (
	address => address4,
	clock	=> clk,
	data => data4,
	wren => rw_aux(4),
	q => out4
);

UM5 : UnidadeDeMemoria port map (
	address => address5,
	clock	=> clk,
	data => data5,
	wren => rw_aux(5),
	q => out5
);

UM6 : UnidadeDeMemoria port map (
	address => address6,
	clock	=> clk,
	data => data6,
	wren => rw_aux(6),
	q => out6
);

UM7 : UnidadeDeMemoria port map (
	address => address7,
	clock	=> clk,
	data => data7,
	wren => rw_aux(7),
	q => out7
);

end hardware;