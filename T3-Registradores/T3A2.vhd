library ieee;
use ieee.numeric_bit.ALL;
use ieee.math_real.ALL;

entity regfile is 
	generic(
		regn: natural := 32;
		wordSize: natural := 64
	);
	port(
		clock :	 	in  bit;
		reset : 	in  bit;
		regWrite : 	in  bit;
		rr1, rr2, wr: in bit_vector(natural(ceil(log2(real(regn)))) -1 downto 0);
		d	  : in  bit_vector(wordSize-1 downto 0);
		q1, q2: out bit_vector(wordSize-1 downto 0)
	);
end regfile;

architecture dados of regfile is	
	type   reg_array is array (0 to regn-1) of bit_vector (wordSize-1 downto 0);
	signal registradores: reg_array;
		begin
		wrt: process(clock,reset) begin
			if reset = '1' then
				regfor: FOR i IN 0 to regn-1 LOOP
					bitfor: FOR j IN 0 to wordSize-1 LOOP
					  registradores(i)(j) <= '0';
					END LOOP bitfor;
				END LOOP regfor;
			elsif clock = '1' and clock'event then
				if regWrite = '1' then
					if to_integer(unsigned(wr)) < 31 then
						registradores(to_integer(unsigned(wr))) <= d;
					end if;
				end if;
			end if;
		end process;	
	q1 <= registradores(to_integer(unsigned(rr1)));
	q2 <= registradores(to_integer(unsigned(rr2)));
end dados;