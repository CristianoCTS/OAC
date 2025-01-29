library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity genImm32 is
  port (
    instr  : in  std_logic_vector(31 downto 0);
    imm32  : out signed(31 downto 0)
  );
end genImm32;

architecture behavior of genImm32 is
begin
  process(instr)
    variable imm : signed(31 downto 0);
  begin
    case instr(6 downto 0) is
      when "0110011" => imm32 <= x"00000000"; -- R
      when "0010011"|"0000011"|"1100111" => 
      	if (instr(14 downto 12) = "101") and (instr(30) = '1') then
        	imm32 <= resize(signed(instr(24 downto 20)), 32); -- I*
        else
        	imm32 <= resize(signed(instr(31 downto 20)), 32);-- I
        end if;
      when "0100011" => imm32 <= resize(signed(instr(31 downto 25) & instr(11 downto 7)), 32);-- S
      when "1100011" => imm32 <= resize(signed(instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0'), 32);-- SB
      when "0110111" => imm32 <= shift_left(resize(signed(instr(31 downto 12)), 32), 12);-- U
      when "1101111" => imm32 <= resize(signed(instr(31) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0'), 32);-- UJ
      when others => imm32 <= x"00000001";    
    end case;
  end process;
end behavior;
