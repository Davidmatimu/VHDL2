library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU32 is
    port (A : in std_logic_vector (7 downto 0);
	  B : in std_logic_vector (7 downto 0);
          OP: in std_logic_vector (1 downto 0);
          Result: out std_logic_vector (7 downto 0);
	  Equal: out std_logic);
             
end ALU32;

architecture Behavioral of ALU32 is
begin
process(A, B, OP)
begin

case OP is
when "00" =>Result<= std_logic_vector(unsigned(A(7 downto 0)) + unsigned(B(7 downto 0))); --addition
	    Equal<='0';
when "01" =>Result<= std_logic_vector(unsigned(A(7 downto 0)) - unsigned(B(7 downto 0))); --subtraction
	    Equal<='0';
when "10" =>Result<="00000000"; --Do nothing
	    Equal<='0';
 
when "11" =>Result<="00000000"; -- Set on Equal
	if A = B then
		Equal <= '1';
	else
		Equal <= '0';
end if; 
when others =>  --Do nothing
	
end case;
  
end process;
 
end Behavioral;
