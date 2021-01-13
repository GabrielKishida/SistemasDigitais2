library ieee;
use ieee.numeric_bit.ALL;
use std.textio.all;

entity rom_arquivo_generica is    
	generic (
		addressSize : natural := 4;
		wordSize	: natural := 8;
		datFileName : string  := "rom.dat"
	);
	port(
		addr : in  bit_vector (addressSize-1 downto 0);
		data : out bit_vector (wordSize-1    downto 0)
	);
end rom_arquivo_generica;

architecture dados of rom_arquivo_generica is
	constant addressMax : natural := (2**addressSize) - 1; 
	type mem_tipo is array (0 to addressMax) of bit_vector (wordSize-1 downto 0);
	impure function init(mif_file_name : in string) return mem_tipo is
    	file mif_file : text open read_mode is mif_file_name;
    	variable mif_line : line;
    	variable temp_bv : bit_vector(wordSize-1 downto 0);
    	variable temp_mem : mem_tipo;
	begin
    	for i in mem_tipo'range loop
        	readline(mif_file, mif_line);
        	read(mif_line, temp_bv);
        	temp_mem(i) := temp_bv;
    end loop;
    return temp_mem;
end function;

constant mem : mem_tipo := init(datFileName);
begin
	data <= mem(to_integer(unsigned(addr)));
end dados;