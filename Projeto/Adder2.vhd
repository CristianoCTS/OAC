-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder2 is
    port(
        A2_PC : in std_logic_vector(31 downto 0);
        A2_Imm : in std_logic_vector(31 downto 0);
        A2_PCI : out std_logic_vector(31 downto 0)
    );
end Adder2;

architecture behavior of Adder2 is
begin
    process (A2_PC, A2_Imm, A2_PCI)
    begin
        A2_PCI <= std_logic_vector(signed(A2_PC) + signed(A2_Imm));
    end process;
end behavior;
