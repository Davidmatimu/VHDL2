library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity reg_tb is
end reg_tb;

architecture behav of reg_tb is
--  Declaration of the component that will be instantiated.
component regfile
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
R1 : regfile
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

--RS1,RS2,WS,WE,clk,WD,RS1D,RS2D
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=

(("00","00","00",'0','0',"00101101","00000000","00000000"), -- Clock not enabled so do nothing
("00","00","00",'0','1',"00101101","00000000","00000000"), -- Write not enabled so do nothing
("00","00","00",'1','0',"00101101","00000000","00000000"), -- Clock not enabled so do nothing
("00","00","00",'1','1',"00101101","00101101","00101101"), -- WE '1' so WS'00 means write data ro RS1'00 and RS2'00
("11","00","10",'1','0',"10100001","00000000","00101101"), -- Clock not enabled so do nothing
("01","10","10",'1','1',"10100001","00000000","10100001"), -- WE '1' and WS'10 so write data to RS1'10 and RS2'10
("10","00","01",'1','0',"00101101","10100001","00101101"), -- Clock not enabled so do nothing
("01","11","01",'1','1',"00000001","00000001","00000000"), -- WE '1' and WS'01 so write data to RS1'01 and RS2'01
("11","01","11",'1','0',"00101101","00000000","00000001"), -- Clock not enabled so do nothing
("00","10","11",'1','1',"11101101","00101101","10100001"), -- WE '1' and WS'11 so write data to RS1'11 and RS2'11
("01","00","00",'1','0',"10100101","00000001","00101101"), -- Clock not enabled so do nothing
("01","00","00",'1','1',"10100101","00000001","10100101"), -- WE '1' and WS'00 so overwrite data at RS1'00 and RS2'00
 
 -- WE '0' for this block so just read will be performed here
("00","11","00",'0','0',"11111111","10100101","11101101"), -- Clock not enabled so do nothing
("00","11","00",'0','1',"11111111","10100101","11101101"), -- Read RS1'00 and RS2'11
("01","10","00",'0','0',"11111111","00000001","10100001"), -- Clock not enabled so do nothing
("01","10","01",'0','1',"11111111","00000001","10100001"), -- Read RS1'01 and RS2'10
("10","01","00",'0','0',"11111111","10100001","00000001"), -- Clock not enabled so do nothing
("10","01","10",'0','1',"11111111","10100001","00000001"), -- Read RS1'10 and RS2'01
("11","00","00",'0','0',"11111111","11101101","10100101"), -- Clock not enabled so do nothing
("11","00","11",'0','1',"11111111","11101101","10100101")  -- Read RS1'11 and RS2'00
);

begin
--  Check each pattern.
for n in patterns'range loop
--  Set the inputs.
RS1 <= patterns(n).RS1;
RS2 <= patterns(n).RS2;
WS <= patterns(n).WS;

CLK <= patterns(n).CLK;
WE <= patterns(n).WE;
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
