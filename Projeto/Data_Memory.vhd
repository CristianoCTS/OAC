-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Data_Memory is
    port(
        clck : in std_logic;
        reset : in std_logic;
        DM_MemWrite : in std_logic;
        DM_MemRead : in std_logic;
        DM_Address : in std_logic_vector(31 downto 0);
        DM_WriteData : in std_logic_vector(31 downto 0);
        DM_ReadData : out std_logic_vector(31 downto 0)
    );
end Data_Memory;

architecture behavior of Data_Memory is
    type memory_array is array (0 to 63) of std_logic_vector(31 downto 0);
    signal D_Memory : memory_array := (others => (others => '0'));
begin
    process (clck, DM_Address, DM_WriteData)
    begin
        if rising_edge(clck) then
            if reset = '1' then
                D_Memory <= (others => (others => '0'));
            elsif DM_MemWrite = '1' then
                D_Memory(to_integer(unsigned(DM_Address))) <= DM_WriteData;
            end if;
        end if;
    end process;

    process (DM_MemRead, DM_Address)
    begin
        if DM_MemRead = '1' then
            DM_ReadData <= D_Memory(to_integer(unsigned(DM_Address)));
        else
            DM_ReadData <= x"00000000";
        end if;
    end process;
end behavior;
