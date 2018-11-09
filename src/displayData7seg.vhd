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


	constant NBITS: integer := 2; -- tb only, for real world appl. change for 20(aprox.)
	signal frequencyDivCounter: STD_LOGIC_VECTOR (NBITS-1 downto 0);
	signal clkDiv: STD_LOGIC;

	signal o_nibble7seg0: STD_LOGIC_VECTOR(7 downto 0);
	signal o_nibble7seg1: STD_LOGIC_VECTOR(7 downto 0);
	signal o_nibble7seg2: STD_LOGIC_VECTOR(7 downto 0);
	signal o_nibble7seg3: STD_LOGIC_VECTOR(7 downto 0);

	COMPONENT nibbleTo7seg
		PORT(
			    i_nibble : IN std_logic_vector(3 downto 0);          
			    o_data : OUT std_logic_vector(7 downto 0)
		    );
	END COMPONENT;


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

	process(currentDisplay, o_nibble7seg0, o_nibble7seg1, o_nibble7seg2, o_nibble7seg3) begin
		case currentDisplay is
			when d0 => displaySel <= "1110"; o_display <= o_nibble7seg0; nextDisplay <= d1;
			when d1 => displaySel <= "1101"; o_display <= o_nibble7seg1; nextDisplay <= d2;
			when d2 => displaySel <= "1011"; o_display <= o_nibble7seg2; nextDisplay <= d3;
			when d3 => displaySel <= "0111"; o_display <= o_nibble7seg3; nextDisplay <= d0;
		end case;
	end process;

	Inst_nibbleTo7seg0: nibbleTo7seg PORT MAP(
							 i_nibble => i_data0,
							 o_data => o_nibble7seg0
						 );

	Inst_nibbleTo7seg1: nibbleTo7seg PORT MAP(
							 i_nibble => i_data1,
							 o_data => o_nibble7seg1
						 );

	Inst_nibbleTo7seg2: nibbleTo7seg PORT MAP(
							 i_nibble => i_data2,
							 o_data => o_nibble7seg2
						 );

	Inst_nibbleTo7seg3: nibbleTo7seg PORT MAP(
							 i_nibble => i_data3,
							 o_data => o_nibble7seg3
						 );

end Behavior;
