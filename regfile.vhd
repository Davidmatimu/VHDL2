

library ieee;
use ieee.std_logic_1164.all;

--WS = Register Write
entity regfile is
  port(
    RS1,RS2,WS : in std_logic_vector(1 downto 0);
    Write_Data : in std_logic_vector(7 downto 0);
    CLK : in std_logic;
    WE : in std_logic;
    RS1_data,RS2_data : out std_logic_vector(7 downto 0);
  );
end entity regfile;

--Initialize 4 registers and set each of their values to 0
architecture behavioral of regfile is

signal Reg0,Reg1,Reg2,Reg3 : std_logic_vector(7 downto 0) := "00000000";
  
--The registers are addressed from b’00 to b’11
  begin
    with RS1 select RS1_data <=
      Reg0 when "00",
      Reg1 when "01",
      Reg2 when "10",
      Reg3 when others;
    with RS2 select RS2_data <=
      Reg0 when "00",
      Reg1 when "01",
      Reg2 when "10",
      Reg3 when others;

--The condition will be true only on rising edge of the CLK signal
    process (CLK) is
      begin
        if (CLK'event and CLK='1') then
          if (WE = '1') then
            if (WS = "00") then
              Reg0 <= Write_Data;
            elsif (WS = "01") then
              Reg1 <= Write_Data;
            elsif (WS = "10") then
              Reg2 <= Write_Data;
            elsif (WS = "11") then
              Reg3 <= Write_Data;
            end if;
          end if;
        end if;
      end process;
    end architecture;
