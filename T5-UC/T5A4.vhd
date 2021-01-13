library ieee;
use ieee.numeric_bit.ALL;

entity controlunit is
	port(
		reg2loc: out bit;
		uncondbranch: out bit;
		branch : out bit;
		memRead : out bit;
		memToReg: out bit;
		aluOp : out bit_vector(1 downto 0);
		memWrite: out bit;
		aluSrc : out bit;
		regWrite : out bit;
		opcode: in bit_vector(10 downto 0)
	);
end entity;
	
architecture uc_arch of controlunit is
	begin
	CTRL_UNIT: process (opcode) is
	begin
		if opcode = "11111000010" then
			reg2loc 		<= '0';
			uncondbranch 	<= '0';
			branch 			<= '0';
			memRead 		<= '1';
			memToReg		<= '1';
			aluop			<= "00";
			memWrite		<= '0';
			aluSrc			<= '1';
			regWrite		<= '1';
		elsif opcode = "11111000000" then
			reg2loc 		<= '1';
			uncondbranch 	<= '0';
			branch 			<= '0';
			memRead 		<= '0';
			memToReg		<= '0';
			aluop			<= "00";
			memWrite		<= '1';
			aluSrc			<= '1';
			regWrite		<= '0';
		elsif opcode(10 downto 3) = "10110100" then
			reg2loc 		<= '1';
			uncondbranch 	<= '0';
			branch 			<= '1';
			memRead 		<= '0';
			memToReg		<= '0';
			aluop			<= "01";
			memWrite		<= '0';
			aluSrc			<= '0';
			regWrite		<= '0';
		elsif opcode(10 downto 5) = "000101" then
			reg2loc 		<= '1';
			uncondbranch 	<= '1';
			branch 			<= '1';
			memRead 		<= '0';
			memToReg		<= '0';
			aluop			<= "01";
			memWrite		<= '0';
			aluSrc			<= '0';
			regWrite		<= '0';
		elsif opcode = "10001011000" or opcode = "11001011000" or opcode = "10001010000" or opcode = "10101010000" then
			reg2loc 		<= '0';
			uncondbranch 	<= '0';
			branch 			<= '0';
			memRead 		<= '0';
			memToReg		<= '0';
			aluop			<= "10";
			memWrite		<= '0';
			aluSrc			<= '0';
			regWrite		<= '1';
		end if;
	end process;
		
end architecture;