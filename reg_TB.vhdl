library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity reg_tb is
end reg_tb;

architecture behav of reg_tb is
--  Declaration of the component that will be instantiated.
component regMem
port (		RS1: 		in std_logic_vector(1 downto 0);
		RS2:       	in std_logic_vector(1 downto 0);
		WS:		in std_logic_vector(1 downto 0);
		
		WE:		in std_logic;
		Write_Data:	in std_logic_vector(7 downto 0);
		CLK:		in std_logic;
		
		RS1_data:	out std_logic_vector(7 downto 0);
		RS2_data:	out std_logic_vector(7 downto 0)		
);
end component;

signal RS1,RS2,WS : std_logic_vector(1 downto 0);
signal WE,clock : std_logic;
signal Write_Data,RS1_data,RS2_data : std_logic_vector(7 downto 0);

begin
--  Component instantiation.
R1 : regMem
	port map(
		RS1=>RS1,
		RS2=>RS2,
		WS=>WS,
		WE=>WE,
		Write_data=>Write_data,
		CLK=>CLK,
		RS1_data=>RS1_data,
		RS2_data=>RS2_data
	);
	
--  This process does the real job.
process

type pattern_type is record
RS1: std_logic_vector(1 downto 0);
RS2: std_logic_vector(1 downto 0);
WS : std_logic_vector(1 downto 0);
WE: std_logic;
CLK : std_logic;
Write_Data: std_logic_vector(7 downto 0);
RS1_data: std_logic_vector(7 downto 0);
RS2_data : std_logic_vector(7 downto 0);

end record;

begin
--  Check each pattern.
for n in patterns'range loop
--  Set the inputs.
RS1 <= patterns(n).reg1;
RS2 <= patterns(n).reg2;
WS <= patterns(n).dstReg;

CLK <= patterns(n).clock;
WE <= patterns(n).writeEn;
Write_Data <= patterns(n).Write_Data;


--  Wait for the results.
wait for 1 ns;
--  Check the outputs.
assert RS1_data = patterns(n).RS1_data
report "Register 1 is wrong" severity error;
assert RS2_data = patterns(n).RS2_data
report "Register 2 is wrong" severity error;

end loop;
assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
wait;
end process;
end behav;
