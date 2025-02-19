-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ShiftLeft1 is
    port(
        SL_Imm : in signed(31 downto 0);
        SL_ShiftedImm : out std_logic_vector(31 downto 0);
    );
end ShiftLeft1;

architecture behavior of ShiftLeft1 is
    begin
        process (SL_Imm, SL_ShiftedImm)
        begin
        SL_ShiftedImm <= std_logic_vector(shift_left(signed(SL_Imm),1));
        end process;
end behavior;
