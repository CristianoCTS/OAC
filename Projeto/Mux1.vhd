-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mux1 is
    port(
        M1_PC4 : in std_logic_vector(31 downto 0);
        M1_PCI : in std_logic_vector(31 downto 0);
        M1_Branch : in std_logic;
        M1_Zero : in std_logic;
        M1_NextPC : out std_logic_vector(31 downto 0)
    );
end Mux1;

architecture behavior of Mux1 is
begin
    process (M1_PC4, M1_PCI, M1_Branch, M1_Zero)
    begin
        if (M1_Zero = '1' and M1_Branch = '1') then
            M1_NextPC <= M1_PCI;
        else
            M1_NextPC <= M1_PC4;
        end if;
    end process;
end behavior;
