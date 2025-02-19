-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
    port (
        U_Control : in std_logic_vector(3 downto 0);
        U_ReadData1 : in std_logic_vector(31 downto 0);
        U_B : in std_logic_vector(31 downto 0);
        U_ULAResult : out std_logic_vector(31 downto 0);
        U_Zero   : out std_logic
        );
end ULA;

architecture behavior of ULA is
begin
    process (U_ReadData1, U_B, U_Control)
    begin
        case U_Control is
            when "0000" => U_ULAResult <= std_logic_vector(signed(U_ReadData1) + signed(U_B)); --ADD  
            when "0001" => U_ULAResult <= std_logic_vector(signed(U_ReadData1) - signed(U_B)); --SUB
            when "0010" => U_ULAResult <= U_ReadData1 and U_B; --AND
            when "0011" => U_ULAResult <= U_ReadData1 or U_B; --OR
            when "0100" => U_ULAResult <= U_ReadData1 xor U_B; --XOR
            when "0101" => U_ULAResult <= std_logic_vector(shift_left(unsigned(U_ReadData1), to_integer(unsigned(U_B)))); --SLL
            when "0110" => U_ULAResult <= std_logic_vector(shift_right(unsigned(U_ReadData1), to_integer(unsigned(U_B)))); --SRL
            when "0111" => U_ULAResult <= std_logic_vector(shift_right(signed(U_ReadData1), to_integer(unsigned(U_B)))); --SRA
            when "1000" => U_ULAResult <= std_logic_vector(signed(x"00000001")) when signed(U_ReadData1) < signed(U_B) else std_logic_vector(signed(x"00000000")); --SLT
            when "1001" => U_ULAResult <= std_logic_vector(signed(x"00000001")) when unsigned(U_ReadData1) < unsigned(U_B) else std_logic_vector(signed(x"00000000")); --SLTU
            when "1010" => U_Zero <= '1' when U_ReadData1 = U_B else '0'; --BEQ
            when "1011" => U_Zero <= '1' when U_ReadData1 /= U_B else '0'; --BNE
            when others => 
                U_ULAResult <= (others => '0');
                U_Zero <= '0';
        end case;
    end process;
end behavior;
