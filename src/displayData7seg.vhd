library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity displayData7seg is
	Port (
		clk: in STD_LOGIC;	
		rst: in STD_LOGIC;
		i_data0: in STD_LOGIC_VECTOR(3 downto 0);	
		i_data1: in STD_LOGIC_VECTOR(3 downto 0);	
		i_data2: in STD_LOGIC_VECTOR(3 downto 0);	
		i_data3: in STD_LOGIC_VECTOR(3 downto 0);	
		displaySel: out STD_LOGIC_VECTOR (3 downto 0);
		o_display: out STD_LOGIC_VECTOR (7 downto 0));
end displayData7seg;

architecture Behavior of displayData7seg is

	type TDisplay is (d0, d1, d2, d3);
	signal currentDisplay, nextDisplay: TDisplay;


	constant NBITS: integer := 20;
	signal frequencyDivCounter: STD_LOGIC_VECTOR (NBITS-1 downto 0);
	signal clkDiv: STD_LOGIC;

	signal o_nibble7seg0: STD_LOGIC_VECTOR(7 downto 0);
	signal o_nibble7seg1: STD_LOGIC_VECTOR(7 downto 0);
	signal o_nibble7seg2: STD_LOGIC_VECTOR(7 downto 0);
	signal o_nibble7seg3: STD_LOGIC_VECTOR(7 downto 0);
begin

	-- Divide clk by 2^(NBITS+1)	
	clkDiv <= frequencyDivCounter(NBITS-1);
	process(clk, rst) begin
		if(rst='1') then
			frequencyDivCounter <= (others=>'0');
		elsif(clk'event and clk='1') then
			frequencyDivCounter <= frequencyDivCounter + 1;
		end if;
	end process;

	process(clkDiv, rst) begin
		if(rst='1') then
			currentDisplay <= d0;
		elsif(clkDiv'event and clkDiv='1') then
			currentDisplay <= nextDisplay;
		end if;

	end process;

	process(currentDisplay) begin
		case currentDisplay is
			when d0 => displaySel <= "1110"; o_display <= o_nibble7seg0; nextDisplay <= d1;
			when d1 => displaySel <= "1101"; o_display <= o_nibble7seg1; nextDisplay <= d2;
			when d2 => displaySel <= "1011"; o_display <= o_nibble7seg2; nextDisplay <= d3;
			when d3 => displaySel <= "0111"; o_display <= o_nibble7seg3; nextDisplay <= d0;
		end case;
	end process;


	-- Add nibble 0..3 to convert i_data to 7seg


end Behavior;
