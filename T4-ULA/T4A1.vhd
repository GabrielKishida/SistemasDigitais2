library ieee;
use ieee.numeric_bit.ALL;

entity mux_2to1 is
  port (
    SEL : in  bit;    
    A :   in  bit;
    B :   in  bit;
    Y :   out bit
    );
end entity mux_2to1;

architecture with_select of mux_2to1 is
begin
  with SEL select
    Y <= A when '0',
         B when '1',
         '0' when others;
end architecture with_select;

entity mux_4to1 is
  port (
    SEL : 		in  bit_vector (1 downto 0);    
	A,B,C,D : 	in  bit;
    Y :   		out bit
    );
end entity mux_4to1;

architecture with_select of mux_4to1 is
begin
  with SEL select
    Y <= A when "00",
         B when "01",
         C when "10",
         D when "11",
         '0' when others;
end architecture with_select;

entity alu1bit is
	port(
		a, b, less, cin: in bit;
		result, cout, set, overflow: out bit;
		ainvert, binvert: in bit;
		operation : in bit_vector (1 downto 0)
	);
end alu1bit;

architecture alu1bit_arch of alu1bit is
	component fulladder is
	port (
		a, b, cin: in bit;
		s, cout:  out bit
	);
	end component;
	
	component mux_2to1 is
	port (
    	SEL : in  bit;    
    	A :   in  bit;
    	B :   in  bit;
    	Y :   out bit
    );
    end component;
    
    component mux_4to1 is
    port (
    	SEL : 		in  bit_vector (1 downto 0);    
		A,B,C,D : 	in  bit;
    	Y :   		out bit
    );
    end component;
    	
   	signal nota, notb,aprep, bprep : bit;
   	signal andentry, orentry, addentry : bit;
   	signal coutsignal : bit;
begin
	nota <= not(a);
	notb <= not(b);
	MUXAINV : mux_2to1	port map (
		SEL => ainvert,
		A => a ,
		B => nota,
		Y => aprep
	);
	
	MUXBINV : mux_2to1	port map (
		SEL => binvert,
		A => b ,
		B => notb,
		Y => bprep
	);
	
	ADDER : fulladder port map(
		a => aprep,
		b => bprep,
		cin => cin,
		s => addentry,
		cout => coutsignal               
	);
	
	andentry <= aprep and bprep;
	orentry <= aprep or bprep;
	overflow <= cin xor coutsignal;
	cout <= coutsignal;
	set <= addentry;
	
	MUXRESULT: mux_4to1 port map(
		SEL => operation,
		A => andentry,
		B => orentry,
		C => addentry,
		D => less,
		Y => result
	);
	
end alu1bit_arch;