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
