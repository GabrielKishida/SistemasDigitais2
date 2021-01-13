library ieee;
use ieee.numeric_bit.ALL;

entity mux_4to1 is
  port (
    SEL : 		in  bit_vector (1 downto 0);    
	A,B,C,D : 	in  bit_vector (63 downto 0);
    Y :   		out bit_vector (63 downto 0)
    );
end entity mux_4to1;

architecture with_select of mux_4to1 is
begin
  with SEL select
    Y <= A when "00",
         B when "01",
         C when "10",
         D when "11";
end architecture with_select;

entity signExtend is
  port (
    i: in 	bit_vector(31 downto 0);
    o: out 	bit_vector(63 downto 0)
  );
end entity;

architecture signExtend_arch of signExtend is

component mux_4to1 is
	port (
    	SEL : 		in  bit_vector (1 downto 0);    
		A,B,C,D : 	in  bit_vector (63 downto 0);
    	Y :   		out bit_vector (63 downto 0)
    );
end component;

signal r_out, ldur_out, stur_out, cbz_out, b_out : bit_vector(63 downto 0);
signal muxsel : bit_vector (1 downto 0);
signal d_opcode: bit_vector (10 downto 0);
signal cbz_opcode: bit_vector(7 downto 0);
signal b_opcode: bit_vector (5 downto 0);
signal d_adr : bit_vector(8 downto 0);
signal cbz_adr: bit_vector (18 downto 0);
signal b_adr : bit_vector (25 downto 0);
begin

	d_opcode <= i(31 downto 21);
	cbz_opcode <= i(31 downto 24);
	b_opcode <= i(31 downto 26);
	
	d_adr <= i(20 downto 12);
	cbz_adr <= i(23 downto 5);
	b_adr <= i(25 downto 0);
	
	process(d_opcode, cbz_opcode, b_opcode) is
	begin
		if		d_opcode = "11111000010" then muxsel <= "00";
		elsif 	d_opcode = "11111000000" then muxsel <= "01";
		elsif   cbz_opcode = "10110100"  then muxsel <= "10";
		elsif 	b_opcode = "000101" 	 then muxsel <= "11";
		end if;
	end process;
	
	process(d_adr) is
	begin
		ldur_out(8 downto 0) <= d_adr;
		stur_out(8 downto 0) <= d_adr;
		if d_adr(8) = '0' then
			FOR j IN 63 downto 9 LOOP
				ldur_out(j) <= '0';
				stur_out(j) <= '0';
			END LOOP;
		else
			FOR j IN 63 downto 9 LOOP
				ldur_out(j) <= '1';
				stur_out(j) <= '1';
			END LOOP;
		end if;
	end process;
	
	process(cbz_adr) is
	begin
		cbz_out(18 downto 0) <= cbz_adr;
		if cbz_adr(18) = '0' then
			FOR j IN 63 downto 19 LOOP
				cbz_out(j) <= '0';
			END LOOP;
		else
			FOR j IN 63 downto 19 LOOP
				cbz_out(j) <= '1';
			END LOOP;
		end if;
	end process;
	
	process(b_adr) is
	begin
		b_out(25 downto 0) <= b_adr;
		if b_adr(25) = '0' then
			FOR j IN 63 downto 26 LOOP
				b_out(j) <= '0';
			END LOOP;
		else
			FOR j IN 63 downto 26 LOOP
				b_out(j) <= '1';
			END LOOP;
		end if;
	end process;		
	
	MUX: mux_4to1 port map(
		SEL => muxsel,
		A => ldur_out,
		B => stur_out,
		C => cbz_out,
		D => b_out,
		Y => o
	);
end architecture signExtend_arch;

