-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Program_Counter is
    port(
        clck : in std_logic;
        reset : in std_logic;
        PC_NextPC : in std_logic_vector(31 downto 0);
        PC_PC : out std_logic_vector(31 downto 0)
    );
end Program_Counter;

architecture behavior of Program_Counter is
begin
    process (clck)
    begin
        if rising_edge(clck) then
            if (reset = '1') then
                PC_PC <= (others => '0');
            else
                PC_PC <= PC_NextPC;
            end if;
        end if;
    end process;
end behavior;
