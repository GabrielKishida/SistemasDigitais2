library ieee;
use ieee.numeric_bit.ALL;
use ieee.math_real.ALL;

entity fa_1bit is
  port (
    A,B : in bit;       -- adends
    CIN : in bit;       -- carry-in
    SUM : out bit;      -- sum
    COUT : out bit      -- carry-out
    );
end entity fa_1bit;

architecture wakerly of fa_1bit is
-- Solution Wakerly's Book (4th Edition, page 475)
begin
  SUM <= (A xor B) xor CIN;
  COUT <= (A and B) or (CIN and A) or (CIN and B);
end architecture wakerly;    

entity fa_4bit is
  port (
    A,B : in bit_vector(3 downto 0);    -- adends
    CIN : in bit;                       -- carry-in
    SUM : out bit_vector(3 downto 0);   -- sum
    COUT : out bit                      -- carry-out
    );
end entity fa_4bit;

architecture ripple4 of fa_4bit is
-- Ripple adder solution

  --  Declaration of the 1 bit adder.  
  component fa_1bit
    port (
      A,B : in bit;       -- adends
      CIN : in bit;       -- carry-in
      SUM : out bit;      -- sum
      COUT : out bit      -- carry-out
    );
  end component fa_1bit;

  signal x,y :   bit_vector(3 downto 0);
  signal s :     bit_vector(3 downto 0);
  signal cin0 :  bit;
  signal cin1 :  bit;
  signal cin2 :  bit;
  signal cin3 :  bit;
  signal cout0 : bit;  
  signal cout1 : bit;
  signal cout2 : bit;
  signal cout3 : bit;
  
begin
  
  -- Components instantiation
  ADDER0: entity work.fa_1bit(wakerly) port map (
    A => x(0),
    B => y(0),
    CIN => cin0,
    SUM => s(0),
    COUT => cout0
    );

  ADDER1: entity work.fa_1bit(wakerly) port map (
    A => x(1),
    B => y(1),
    CIN => cout0,
    SUM => s(1),
    COUT => cout1
    );

  ADDER2: entity work.fa_1bit(wakerly) port map (
    A => x(2),
    B => y(2),
    CIN => cout1,
    SUM => s(2),
    COUT => cout2
    );  

  ADDER3: entity work.fa_1bit(wakerly) port map (
    A => x(3),
    B => y(3),
    CIN => cout2,
    SUM => s(3),
    COUT => cout3
    );

  x <= A;
  y <= B;
  cin0 <= CIN;
  SUM <= s;
  COUT <= cout3;
  
end architecture ripple4; 
  
entity fa_8bit is
  port (
    A,B  : in  bit_vector(7 downto 0);
    CIN  : in  bit;
    SUM  : out bit_vector(7 downto 0);
    COUT : out bit
    );
end entity;

architecture ripple8 of fa_8bit is
-- Ripple adder solution

  --  Declaration of the 1-bit adder.  
  component fa_1bit
    port (
      A, B : in  bit;   -- adends
      CIN  : in  bit;   -- carry-in
      SUM  : out bit;   -- sum
      COUT : out bit    -- carry-out
    );
  end component fa_1bit;

  signal x,y :   bit_vector(7 downto 0);
  signal s :     bit_vector(7 downto 0);
  signal cin0 :  bit;
  signal cout0 : bit;  
  signal cout1 : bit;
  signal cout2 : bit;
  signal cout3 : bit;
  signal cout4 : bit;  
  signal cout5 : bit;
  signal cout6 : bit;
  signal cout7 : bit;
  
begin
  
  -- Components instantiation
  ADDER0: entity work.fa_1bit(wakerly) port map (
    A => x(0),
    B => y(0),
    CIN => cin0,
    SUM => s(0),
    COUT => cout0
    );

  ADDER1: entity work.fa_1bit(wakerly) port map (
    A => x(1),
    B => y(1),
    CIN => cout0,
    SUM => s(1),
    COUT => cout1
    );

  ADDER2: entity work.fa_1bit(wakerly) port map (
    A => x(2),
    B => y(2),
    CIN => cout1,
    SUM => s(2),
    COUT => cout2
    );  

  ADDER3: entity work.fa_1bit(wakerly) port map (
    A => x(3),
    B => y(3),
    CIN => cout2,
    SUM => s(3),
    COUT => cout3
    );

  ADDER4: entity work.fa_1bit(wakerly) port map (
    A => x(4),
    B => y(4),
    CIN => cout3,
    SUM => s(4),
    COUT => cout4
    );

  ADDER5: entity work.fa_1bit(wakerly) port map (
    A => x(5),
    B => y(5),
    CIN => cout4,
    SUM => s(5),
    COUT => cout5
    );

  ADDER6: entity work.fa_1bit(wakerly) port map (
    A => x(6),
    B => y(6),
    CIN => cout5,
    SUM => s(6),
    COUT => cout6
    );  

  ADDER7: entity work.fa_1bit(wakerly) port map (
    A => x(7),
    B => y(7),
    CIN => cout6,
    SUM => s(7),
    COUT => cout7
    );

  x <= A;
  y <= B;
  cin0 <= CIN;
  SUM <= s;
  COUT <= cout7;
  
end architecture ripple8;

entity fa_16bit is
  port (
    A,B  : in  bit_vector(15 downto 0);
    CIN  : in  bit;
    SUM  : out bit_vector(15 downto 0);
    COUT : out bit
    );
end entity;

architecture ripple of fa_16bit is
-- Ripple adder solution

  --  Declaration of the 1-bit adder.  
  component fa_1bit
    port (
      A, B : in  bit;   -- adends
      CIN  : in  bit;   -- carry-in
      SUM  : out bit;   -- sum
      COUT : out bit    -- carry-out
    );
  end component fa_1bit;

  signal x,y :   bit_vector(15 downto 0);
  signal s :     bit_vector(15 downto 0);
  signal cin0 :  bit;
  signal cout0 : bit;  
  signal cout1 : bit;
  signal cout2 : bit;
  signal cout3 : bit;
  signal cout4 : bit;  
  signal cout5 : bit;
  signal cout6 : bit;
  signal cout7 : bit;
  signal cout8 : bit;  
  signal cout9 : bit;
  signal cout10 : bit;
  signal cout11 : bit;
  signal cout12 : bit;  
  signal cout13 : bit;
  signal cout14 : bit;
  signal cout15 : bit;
  
begin
  
  -- Components instantiation
  ADDER0: entity work.fa_1bit(wakerly) port map (
    A => x(0),
    B => y(0),
    CIN => cin0,
    SUM => s(0),
    COUT => cout0
    );

  ADDER1: entity work.fa_1bit(wakerly) port map (
    A => x(1),
    B => y(1),
    CIN => cout0,
    SUM => s(1),
    COUT => cout1
    );

  ADDER2: entity work.fa_1bit(wakerly) port map (
    A => x(2),
    B => y(2),
    CIN => cout1,
    SUM => s(2),
    COUT => cout2
    );  

  ADDER3: entity work.fa_1bit(wakerly) port map (
    A => x(3),
    B => y(3),
    CIN => cout2,
    SUM => s(3),
    COUT => cout3
    );

  ADDER4: entity work.fa_1bit(wakerly) port map (
    A => x(4),
    B => y(4),
    CIN => cout3,
    SUM => s(4),
    COUT => cout4
    );

  ADDER5: entity work.fa_1bit(wakerly) port map (
    A => x(5),
    B => y(5),
    CIN => cout4,
    SUM => s(5),
    COUT => cout5
    );

  ADDER6: entity work.fa_1bit(wakerly) port map (
    A => x(6),
    B => y(6),
    CIN => cout5,
    SUM => s(6),
    COUT => cout6
    );  

  ADDER7: entity work.fa_1bit(wakerly) port map (
    A => x(7),
    B => y(7),
    CIN => cout6,
    SUM => s(7),
    COUT => cout7
    );

  ADDER8: entity work.fa_1bit(wakerly) port map (
    A => x(8),
    B => y(8),
    CIN => cout7,
    SUM => s(8),
    COUT => cout8
    );

  ADDER9: entity work.fa_1bit(wakerly) port map (
    A => x(9),
    B => y(9),
    CIN => cout8,
    SUM => s(9),
    COUT => cout9
    );  

  ADDER10: entity work.fa_1bit(wakerly) port map (
    A => x(10),
    B => y(10),
    CIN => cout9,
    SUM => s(10),
    COUT => cout10
    );

  ADDER11: entity work.fa_1bit(wakerly) port map (
    A => x(11),
    B => y(11),
    CIN => cout10,
    SUM => s(11),
    COUT => cout11
    );

  ADDER12: entity work.fa_1bit(wakerly) port map (
    A => x(12),
    B => y(12),
    CIN => cout11,
    SUM => s(12),
    COUT => cout12
    );

  ADDER13: entity work.fa_1bit(wakerly) port map (
    A => x(13),
    B => y(13),
    CIN => cout12,
    SUM => s(13),
    COUT => cout13
    );  

  ADDER14: entity work.fa_1bit(wakerly) port map (
    A => x(14),
    B => y(14),
    CIN => cout13,
    SUM => s(14),
    COUT => cout14
    );

  ADDER15: entity work.fa_1bit(wakerly) port map (
    A => x(15),
    B => y(15),
    CIN => cout14,
    SUM => s(15),
    COUT => cout15
    );

  x <= A;
  y <= B;
  cin0 <= CIN;
  SUM <= s;
  COUT <= cout15;
  
end architecture ripple;

entity mux4_2to1 is
  port (
    SEL : in bit;    
    A :   in bit_vector  (15 downto 0);
    B :   in bit_vector  (15 downto 0);
    Y :   out bit_vector (15 downto 0)
    );
end entity mux4_2to1;

architecture with_select of mux4_2to1 is
begin
  with SEL select
    Y <= A when '0',
         B when '1',
         "0000000000000000" when others;
end architecture with_select;

library ieee;
use ieee.numeric_bit.ALL;
use ieee.math_real.ALL;

entity regfile is 
	generic(
		regn: natural := 32;
		wordSize: natural := 16
	);
	port(
		clock :	 	in  bit;
		reset : 	in  bit;
		regWrite : 	in  bit;
		rr1, rr2, wr: in bit_vector(4 downto 0);
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

library ieee;
use ieee.numeric_bit.ALL;
use ieee.math_real.ALL;

entity calc is
	generic(
		regn: natural := 32;
		wordSize: natural := 16
	); 
	port(
		clock		: in  bit;
		reset		: in  bit;
		instruction	: in  bit_vector(15 downto 0);
		overflow   	: out bit;
		q1			: out bit_vector(15 downto 0)
	);
end calc;

architecture arch_calc of calc is
	component regfile 
	port(
		clock :	 	in  bit;
		reset : 	in  bit;
		regWrite : 	in  bit;
		rr1, rr2, wr: in bit_vector(natural(ceil(log2(real(regn)))) -1 downto 0);
		d	  : in  bit_vector(wordSize-1 downto 0);
		q1, q2: out bit_vector(wordSize-1 downto 0)
	);
	end component regfile;
	
	component fa_16bit
	generic(
      	bits: natural := 16
    ); 
	port(
      	a,b: in  bit_vector(bits-1 downto 0);
      	s:   out bit_vector(bits-1 downto 0);
      	co:  out bit
    );
	end component fa_16bit;
	
	component mux16_2to1 is
  	port (
    SEL : in bit;    
    A :   in bit_vector  (15 downto 0);
    B :   in bit_vector  (15 downto 0);
    Y :   out bit_vector (15 downto 0)
    );
	end component mux16_2to1;
	
	signal opcode : bit;
	signal oper2, oper1, dest: bit_vector(4 downto 0);
	signal dado1, dado2, dadoimediato, imediatonegativo, imediatopositivo, dadoasomar, soma: bit_vector(15 downto 0);  
	
	begin
		opcode <= instruction(15);
		oper2  <= instruction(14 downto 10);
		oper1  <= instruction(9 downto 5);
		dest   <= instruction(4 downto 0);
		
	    imediatonegativo <= "11111111111" & oper2;
	    imediatopositivo <= "00000000000" & oper2;
	    
		MUXPREPAREIMEDIATO: mux16_2to1 port map(
			SEL => oper2(4),
			A   => imediatopositivo,
			B   => imediatonegativo,
			Y   => dadoimediato
		);
		MUXPREPARESOMA: mux16_2to1 port map(
			SEL => opcode,
			A   => dadoimediato,
			B   => dado2,
			Y   => dadoasomar
		);
				
		COMPONENTESOMA: fa_16bit port map(
			a  => dado1,
			b  => dadoasomar,
			s  => soma,
			co => open
		);
		  
		REGISTRADORES: regfile port map (
			clock => clock,
			reset => reset,
			regWrite => '1',
			rr1 => oper1,
			rr2 => oper2,
			wr => dest,
			d => soma,
			q1 => dado1,
			q2 => dado2
		);
		overflow <= (soma(15)xor(dado1(15))) and (soma(15)xor dadoasomar(15));  
		q1 <= dado1;		
		
end arch_calc;