-- Aluno: Gabriel Kishida
-- NUSP : 11257647
-- PCS3225 Sistemas Digitais 2
-- Algoritmo de Fibonacci em Assembly
-------

library ieee;
use ieee.numeric_bit.all;

entity rom is
   port (
      -- 4 bits de endereço:
      addr: in bit_vector(3 downto 0);
      -- 32 bits de tamanho de palavra de dados:
      data: out bit_vector(31 downto 0)
   );
end rom;

architecture rom_arch of rom is
  type mem_tipo is array (0 to 15) of bit_vector(31 downto 0);
  constant mem: mem_tipo :=
    ( 0 =>  "11111000010000000000001111100000", -- LDUR X0,[X31,0]
      1 =>  "11111000010000001000001111100001", -- LDUR X1,[X31,8]  
      2 =>  "11111000010000010000001111100010", -- LDUR X2,[X31,16] 
      3 =>  "11111000010000011000001111100011", -- LDUR X2,[X31,24] 
      4 =>  "10001011000000000000000000100101", -- ADD X5,X1,X0 :L0
      5 =>  "10001011000111110000000000100000", -- ADD X0,X1,X31
      6 =>  "10001011000111110000000010100001", -- ADD X1,X5,X31
      7 =>  "11001011000000110000000001000010", -- SUB X2,X2,X3
      8 =>  "10110100000000000000000001000010", -- CBZ X2,L1
      9 =>  "00010111111111111111111111111011", -- B L0
      10 => "11111000000000100000001111100001", -- STUR X1,[X31,32] :L1
      11 => "00010100000000000000000000000000", -- B L2: L2
      12 => "00000000000000000000000000000000",
      13 => "00000000000000000000000000000000",
      14 => "00000000000000000000000000000000",
      15 => "00000000000000000000000000000000");
  
begin
   data <= mem(to_integer(unsigned(addr)));
end rom_arch;
