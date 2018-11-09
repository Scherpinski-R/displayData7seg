library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity nibbleTo7seg is
	Port(
		    i_nibble: in STD_LOGIC_VECTOR(3 downto 0);
		    o_data	: out STD_LOGIC_VECTOR(7 downto 0));

end nibbleTo7seg;

architecture Behavior of nibbleTo7seg is
begin

	o_data	<=	"11111100" when i_nibble="0000" else
		  "01100000" when i_nibble="0001" else
		  "11011010" when i_nibble="0010" else
		  "11110010" when i_nibble="0011" else
		  "01100110" when i_nibble="0100" else
		  "10110110" when i_nibble="0101" else
		  "10111110" when i_nibble="0110" else
		  "11100000" when i_nibble="0111" else
		  "11111110" when i_nibble="1000" else
		  "11100110" when i_nibble="1001" else
		  "11101110" when i_nibble="1010" else
		  "00111110" when i_nibble="1011" else
		  "10011100" when i_nibble="1100" else
		  "01111010" when i_nibble="1101" else
		  "10011110" when i_nibble="1110" else
		  "10001110";
end Behavior;



