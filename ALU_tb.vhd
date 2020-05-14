library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU32_tb is
end ALU32_tb;

architecture behavioral of ALU32_tb is
    component ALU32 is
    port (A : in std_logic_vector (31 downto 0);
	  B : in std_logic_vector (31 downto 0);
          OP: in std_logic_vector (1 downto 0);
          Result: out std_logic_vector (31 downto 0);
	  Equal: out std_logic
	 );
             
end component;

begin

ALU32_tb0: ALU32 port map (A=>A,B=>B,OP=>OP,Result=>Result,Equal=>Equal);

process
    A <= "01000000000011011000111010001001"; --1074630281 in decimal
    B <= "00000000000010010000110100010001"; --593169 in decimal
    OP <= "00";
    assert Result = "01000000000101101001101110011010" report "addition incorrect" severity error; --1075226450 in decimal
    assert Equal = "0" report "equal incorrect" severity error;
    wait for 2 ns;

    A <= "01011010110100101101010010110111"; --1523766455 in decimal
    B <= "00100100100100100100100100100100"; --613566756 in decimal
    OP <= "01";
    assert Result = "00110110010000001000101110010011" report "subtraction incorrect" severity error; --910199699 in decimal
    assert Equal = "0" report "equal incorrect" severity error;
    wait for 2 ns;

    A <= "01110111011101000100010001010101";
    B <= "10100101011010100101011010100101";
    OP <= "10";
    assert Result = "" report "do nothing incorrect" severity error;
    assert Equal = "" report "equal incorrect" severity error;
    wait for 2 ns;

    A <= "01001100011100001111000001111101";
    A <= "01001100011100001111000001111101";
    OP <= "11";
    assert Result = "" report "check equal incorrect" severity error;
    assert Equal = "1" report "equal incorrect" severity error;
    wait for 2 ns;

    A <= "01011010100101010010100110101101"
    B <= "11111101110101000010101001010101"
    OP <= "11";
    assert Result = "" report "check equal incorrect" severity error;
    assert Equal = "0" report "equal incorrect" severity error;
    wait for 2 ns;

wait;
end process;
 
end Behavioral;
