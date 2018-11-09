LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_displayData7seg IS
	END tb_displayData7seg;

ARCHITECTURE behavior OF tb_displayData7seg IS 

    -- Component Declaration for the Unit Under Test (UUT)

	COMPONENT displayData7seg
		PORT(
			    clk : IN  std_logic;
			    rst : IN  std_logic;
			    i_data0 : IN  std_logic_vector(3 downto 0);
			    i_data1 : IN  std_logic_vector(3 downto 0);
			    i_data2 : IN  std_logic_vector(3 downto 0);
			    i_data3 : IN  std_logic_vector(3 downto 0);
			    displaySel : OUT  std_logic_vector(3 downto 0);
			    o_display : OUT  std_logic_vector(7 downto 0)
		    );
	END COMPONENT;


   --Inputs
	signal clk : std_logic := '0';
	signal rst : std_logic := '0';
	signal i_data0 : std_logic_vector(3 downto 0) := (others => '0');
	signal i_data1 : std_logic_vector(3 downto 0) := (others => '0');
	signal i_data2 : std_logic_vector(3 downto 0) := (others => '0');
	signal i_data3 : std_logic_vector(3 downto 0) := (others => '0');

   --Outputs
	signal displaySel : std_logic_vector(3 downto 0);
	signal o_display : std_logic_vector(7 downto 0);

   -- Clock period definitions
	constant clk_period : time := 10 ns;

BEGIN

   -- Instantiate the Unit Under Test (UUT)
	uut: displayData7seg PORT MAP (
					      clk => clk,
					      rst => rst,
					      i_data0 => i_data0,
					      i_data1 => i_data1,
					      i_data2 => i_data2,
					      i_data3 => i_data3,
					      displaySel => displaySel,
					      o_display => o_display
				      );

   -- Clock process definitions
	clk_process :process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;


   -- Stimulus process
	stim_proc: process
	begin		
		-- hold reset state for 100 ns.
		rst <= '1';		
		wait for 100 ns;	
		rst <= '0';

		i_data0 <= "0000";
		i_data1 <= "0010";
		i_data2 <= "0100";
		i_data3 <= "1000";

		wait;
	end process;

END;
