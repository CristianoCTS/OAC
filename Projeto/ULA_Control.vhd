-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_Control is
    port (
        UC_instruction    : in  std_logic_vector(31 downto 0);
        UC_ULAOp     : in  std_logic_vector(5 downto 0);
        UC_Control : out std_logic_vector(3 downto 0)
    );
end ULA_Control;

architecture behavior of ULA_Control is
    begin
        process (UC_ULAOp, UC_instruction)
        begin
            case UC_ULAOp is
                when "000000" =>  -- R (SLT, SLTu, ADD, SUB, XOR, AND, SLL, OR, SRL, SRA)
                    case UC_instruction(14 downto 12) is
                        when "000" =>
                            if UC_instruction(30) = '0' then
                                UC_Control <= "0000";  -- ADD
                            else
                                UC_Control <= "0001";  -- SUB
                            end if;
                        when "111" => UC_Control <= "0010"; -- AND
                        when "110" => UC_Control <= "0011"; -- OR
                        when "100" => UC_Control <= "0100"; -- XOR
                        when "001" => UC_Control <= "0101"; -- SLL
                        when "101" =>
                            if UC_instruction(30) = '0' then
                                UC_Control <= "0110";  -- SRL
                            else
                                UC_Control <= "0111";  -- SRA
                            end if;
                        when "010" => UC_Control <= "1000"; -- SLT
                        when "011" => UC_Control <= "1001"; -- SLTU
                        when others => UC_Control <= "1111";
                    end case;
    
                when "000010" =>  -- I (LB, LW, LBU)
                    UC_Control <= "0000";  -- ADD
    
                when "000011" =>  -- S (SB, SW)
                    UC_Control <= "0000";  -- ADD
    
                when "000100" =>  -- SB (BEQ, BNE)
                    case UC_instruction(14 downto 12) is
                        when "000" => UC_Control <= "1010"; -- BEQ
                        when "001" => UC_Control <= "1011"; -- BNE
                        when others => UC_Control <= "1111"; 
                    end case;
    
                when "000101" =>  -- U (AUIPC, LUI)
                    UC_Control <= "0000";  -- ADD
    
                when "000110" =>  -- UJ (JAL, JALR)
                    UC_Control <= "0000";  -- ADD
    
                when others =>
                    UC_Control <= "1111";
            end case;
        end process;
end behavior;
