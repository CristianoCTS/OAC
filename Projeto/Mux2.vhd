-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mux2 is
    port(
        M2_ULASrc : in std_logic;
        M2_ReadData2 : in std_logic_vector(31 downto 0);
        M2_Imm : in signed(31 downto 0);
        M2_B : out std_logic_vector(31 downto 0)
    );
end Mux2;

architecture behavior of Mux2 is
begin
    process (M2_ULASrc, M2_ReadData2, M2_Imm)
    begin
        if (M2_ULASrc = '1') then
            M2_B <= std_logic_vector(signed(M2_Imm));
        else
            M2_B <= M2_ReadData2;
        end if;
    end process;
end behavior;
