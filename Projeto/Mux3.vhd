-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mux3 is
    port(
        M3_MemtoReg : in std_logic;
        M3_ULAresult : in std_logic_vector(31 downto 0);
        M3_ReadData : in std_logic_vector(31 downto 0);
        M3_PC : in std_logic_vector(31 downto 0);
        M3_Branch : in std_logic;
        M3_WriteData : out std_logic_vector(31 downto 0)
    );
end Mux3;

architecture behavior of Mux3 is
begin
    process (M3_MemtoReg, M3_ULAresult, M3_ReadData, M3_PC, M3_Branch)
    begin
        if (M3_MemtoReg = '1') then
            if (M3_Branch) then
                M3_WriteData <= M3_PC;
            else
                M3_WriteData <= M3_ReadData;
            end if;
        else
            M3_WriteData <= M3_ULAresult;
        end if;
    end process;
end behavior;
