library ieee;
use ieee.numeric_bit.ALL;

entity fulladder is
  port (
    a, b, cin: in bit;
    s, cout: out bit
  );
end entity;

architecture structural of fulladder is
  signal axorb: bit;
begin
  axorb <= a xor b;
  s <= axorb xor cin;
  cout <= (axorb and cin) or (a and b);
end architecture;

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
		D => b,
		Y => result
	);
	
end alu1bit_arch;

entity alu is
	generic (
		size: natural := 64
	);
	port (
		A,B	: in  bit_vector(size-1 downto 0);
		F	: out  bit_vector(size-1 downto 0);
		S	: in  bit_vector(3 downto 0);
		Z	: out bit;
		Ov	: out bit;
		Co	: out bit
	);
end entity alu;

architecture alu_arch of alu is
	component alu1bit is
	port(
		a, b, less, cin: in bit;
		result, cout, set, overflow: out bit;
		ainvert, binvert: in bit;
		operation : in bit_vector (1 downto 0)
	);
	end component;
	signal carryvector : bit_vector(size downto 0);
	signal lessvector, setvector, overflowvector, result : bit_vector(size-1 downto 0);
	signal singlebitoperation: bit_vector (1 downto 0);
	signal a_inv_signal, b_inv_signal : bit; 
	
begin 
	process (lessvector,setvector)
	begin
   		LESSVECTORFILL: FOR i IN 0 to size-1 LOOP
			if i = 0 then
				lessvector(i) <= setvector(size-1);
			else
				lessvector(i) <= '0';
			end if;
		END LOOP LESSVECTORFILL;
	end process;
	
	PREPAREENTRIES : process(S) is
	begin
		if 		S = "0000" then --AND bit by bit
			singlebitoperation <= "00";
			a_inv_signal <= '0';
			b_inv_signal <= '0';
			carryvector(0) <= '0';
		elsif 	S = "0001" then --OR bit by bit
		    singlebitoperation <= "01";
		    a_inv_signal <= '0';
			b_inv_signal <= '0';
			carryvector(0) <= '0';
		elsif	S = "0010" then	--ADD
			singlebitoperation <= "10";
			a_inv_signal <= '0';
			b_inv_signal <= '0';
			carryvector(0) <= '0';
		elsif	S = "0110" then --SUBTRACT
			singlebitoperation <= "10";
			a_inv_signal <= '0';
			b_inv_signal <= '1';
			carryvector(0) <= '1';
		elsif 	S = "0111" then --SLT
			singlebitoperation <= "11";
			a_inv_signal <= '0';
			b_inv_signal <= '1';
			carryvector(0) <= '1';
		elsif 	S = "1100" then --NOR bit by bit
			singlebitoperation <= "00";
			a_inv_signal <= '1';
			b_inv_signal <= '1';
			carryvector(0) <= '1'; 
		end if;
	end process PREPAREENTRIES;
	
	ALUGEN: FOR i IN size-1 downto 0 GENERATE
		ALURIPPLEi : alu1bit port map(
		A(i),
		B(i),
		lessvector(i),
		carryvector(i),
		result(i),
		carryvector(i+1),
		setvector(i),
		overflowvector(i),
		a_inv_signal,
		b_inv_signal,
		singlebitoperation 
		);
	END GENERATE ALUGEN;
	F <= result;
	Ov <= overflowvector(size-1);
	Z  <= '1' when result =(result'range => '0') else '0';
	Co <= carryvector(size); 
	
end alu_arch;