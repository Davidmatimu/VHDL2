library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity regMem_tb is
end regMem_tb;

architecture behav of regMem_tb is
--  Declaration of the component that will be instantiated.
component regMem
port (	reg1: 		in std_logic_vector(1 downto 0);
		reg2:       in std_logic_vector(1 downto 0);
		dstReg:		in std_logic_vector(1 downto 0);
		
		writeEn:	in std_logic;
		writeData:	in std_logic_vector(7 downto 0);
		clock:		in std_logic;
		
		reg1Data:	out std_logic_vector(7 downto 0);
		reg2Data:	out std_logic_vector(7 downto 0)		
);
end component;
