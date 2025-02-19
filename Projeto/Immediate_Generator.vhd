-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Imediate_Generator is
  port (
    IG_instruction  : in  std_logic_vector(31 downto 0);
    IG_imm  : out signed(31 downto 0)
  );
end Imediate_Generator;

architecture behavior of Imediate_Generator is
begin
  process(IG_instruction)
    variable imm : signed(31 downto 0);
  begin
    case IG_instruction(6 downto 0) is
      when "0110011" => IG_imm <= x"00000000"; -- R
      when "0000011" => IG_imm <= resize(signed(IG_instruction(31 downto 20)), 32); --I
      when "0100011" => IG_imm <= resize(signed(IG_instruction(31 downto 25) & IG_instruction(11 downto 7)), 32);-- S
      when "1100011" => IG_imm <= resize(signed(IG_instruction(31) & IG_instruction(7) & IG_instruction(30 downto 25) & IG_instruction(11 downto 8) & '0'), 32);-- SB
      when "0110111"|"0010111" => IG_imm <= shift_left(resize(signed(IG_instruction(31 downto 12)), 32), 12);-- U
      when "1101111"|"1100111" => IG_imm <= resize(signed(IG_instruction(31) & IG_instruction(19 downto 12) & IG_instruction(20) & IG_instruction(30 downto 21) & '0'), 32);-- UJ
      when others => IG_imm <= x"00000001";    
    end case;
  end process;
end behavior;
