-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder1 is
    port(
        A1_PC : in std_logic_vector(31 downto 0);
        A1_PC4 : out std_logic_vector(31 downto 0)
        );
end Adder1;

architecture behavior of Adder1 is
    begin
        process (A1_PC, A1_PC4)
        begin
            A1_PC4 <= std_logic_vector(signed(A1_PC) + signed(x"00000004"));
        end process;
end behavior;
