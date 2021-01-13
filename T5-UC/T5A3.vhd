library ieee;
use ieee.numeric_bit.ALL;

entity alucontrol is
  port (
    aluop:   in  bit_vector(1 downto 0);
    opcode:  in  bit_vector(10 downto 0);
    aluCtrl: out bit_vector(3 downto 0)
  );
end entity;

architecture alucontrol_arch of alucontrol is

begin
	process(aluop, opcode) is
	begin
		if    aluop = "00" then aluCtrl <= "0010";
		elsif aluop = "01" then aluCtrl <= "0111";
		elsif aluop = "10" then
			if    opcode = "10001011000" then aluCtrl <= "0010"; -- ADD
			elsif opcode = "11001011000" then aluCtrl <= "0110"; -- SUB
			elsif opcode = "10001010000" then aluCtrl <= "0000"; -- AND
			elsif opcode = "10101010000" then aluCtrl <= "0001"; -- ORR
			end if;
		end if;
	end process;
end architecture;