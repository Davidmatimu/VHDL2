library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU32_tb is
end ALU32_tb;

architecture behavioral of ALU32_tb is
    component ALU32 is
    port (Atb : in std_logic_vector (7 downto 0);
	  Btb : in std_logic_vector (7 downto 0);
          OPtb: in std_logic_vector (1 downto 0);
          Resulttb: out std_logic_vector (7 downto 0);
	  Equaltb: out std_logic
	 );
             
end component;

signal Atb, Btb, Restulttb : std_logic_vector(7 downto 0);
signal Equaltb : std_logic;
signal OPtb : std_logic_vector(1 downto 0);

begin

ALU32_tb0: ALU32 port map (Atb=>A,Btb=>B,OPtb=>OP,Resulttb=>Result,Equaltb=>Equal);

process
    type pattern_type is record
        A, B: std_logic_vector(7 downto 0);
        OP : std_logic_vector(1 downto 0);
        Result : std_logic_vector(7 downto 0);
        Equal : std_logic;
    end record;

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
    (("10001001","00010001","00","10011010",'0'),
    ("10110111","00100100","01","10010011",'0'),
    ("01010101","10100101","10","00000000",'0'),
    ("11111101","11111101","11","00000000",'1'),
    ("10101101","01010101","11","00000000",'0'));

begin
    for n in patterns'range loop
        A <= patterns(n).A;
        B <= patterns(n).B;
        OP <= patterns(n).OP;
        Result <= patterns(n).Result;
        Equal <= patterns(n).Equal;
        wait for 1 ns;

        assert Result = patterns(n).Result
        report "bad Result value" severity error;
        assert Equal = patterns(n).Equal
        report "bad Equal value" severity error;
        end loop;
        assert false report "end of test" severity note;

--    wait for 1 ns;
--    Atb <= "10001001"; --137 in decimal
--    Btb <= "00010001"; --17 in decimal
--    OPtb <= "00";
--    assert Resulttb = "10011010" report "addition incorrect" severity error; --154 in decimal
--    assert Equaltb = '0' report "equal incorrect" severity error;
--    wait for 1 ns;

--    Atb <= "10110111"; --183 in decimal
--    Btb <= "00100100"; --36 in decimal
--    OPtb <= "01";
--    assert Resulttb = "10010011" report "subtraction incorrect" severity error; --147 in decimal
--    assert Equaltb = '0' report "equal incorrect" severity error;
--    wait for 1 ns;

--    Atb <= "01010101"; --85 in decimal
--    Btb <= "10100101"; --165 in decimal
--    OPtb <= "10";
--    assert Resulttb = "00000000" report "do nothing incorrect" severity error;
--    assert Equaltb = '0' report "equal incorrect" severity error;
--    wait for 1 ns;

--    Atb <= "11111101"; --253 in decimal
--    Btb <= "11111101"; --253 in decimal
--    OPtb <= "11";
--    assert Resulttb = "00000000" report "check equal incorrect" severity error;
--    assert Equaltb = '1' report "equal incorrect" severity error;
--    wait for 1 ns;

--    Atb <= "10101101"; --173 in decimal
--    Btb <= "01010101"; --85 in decimal
--    OPtb <= "11";
--    assert Resulttb = "00000000" report "check equal incorrect" severity error;
--    assert Equaltb = '0' report "equal incorrect" severity error;
--    wait for 1 ns;

wait;
end process;
 
end Behavioral;
