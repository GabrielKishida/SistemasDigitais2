library ieee;
use ieee.numeric_bit.ALL;

entity ram is    
	generic (
		addressSize : natural := 4;
		wordSize	: natural := 8
	);
	port(
		ck, wr : in  bit;
		addr   : in  bit_vector (addressSize-1 downto 0);
		data_i : in  bit_vector (wordSize-1    downto 0);
		data_o : out bit_vector (wordSize-1    downto 0)
	);
end ram;

architecture dados of ram is
	constant addressMax : natural := (2**addressSize) - 1; 
	type mem_tipo is array (0 to addressMax) of bit_vector (wordSize-1 downto 0);
	signal memoria: mem_tipo;  
	
	begin
	wrt: process(ck) begin
		if(ck = '1' and ck'event) then
			if(wr = '1') then
				memoria(to_integer(unsigned(addr))) <= data_i;
			end if;
		end if;
	end process;
	data_o <= memoria(to_integer(unsigned(addr)));
end dados;