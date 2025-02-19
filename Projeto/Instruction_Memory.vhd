-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_Memory is
    port(
        reset : in std_logic;
        IM_ReadAddress : in std_logic_vector(31 downto 0);
        IM_Instruction : out std_logic_vector(31 downto 0)
    );
end Instruction_Memory;

architecture behavior of Instruction_Memory is
    type memory_array is array (0 to 63) of std_logic_vector(31 downto 0);
    signal Memory : memory_array := (
        0 =>  "00010000000000000000000010110111",
        1 =>  "00100000000000000000000100010111",
        2 =>  "00000000000000001000000110000011",
        3 =>  "00000000000100001100001000000011",
        4 =>  "00000000000000001010001010000011",
        5 =>  "00000000001100001000000100100011",
        6 =>  "00000000010100001010001000100011",
        7 =>  "00000000010000011000001100110011",
        8 =>  "01000000001100101000001110110011",
        9 =>  "00000000011100110100010000110011",
        10 => "00000000011100110111010010110011",
        11 => "00000000011100110110010100110011",
        12 => "00000000011100110001010110110011",
        13 => "00000000011100110101011000110011",
        14 => "01000000011100110101011010110011",
        15 => "00000000011100110010011100110011",
        16 => "00000000011100110011011110110011",
        17 => "00000000111101110000100001100011",
        18 => "00000000111101110001100001100011",
        19 => "00000000100000000000100001101111",
        20 => "00000000000010000000100011100111",
        21 => "00000000100000000000000001101111",
        22 => "00000000010000000000000001101111",
        others => (others => '0')
    );
begin
    process (reset)
    begin
        if rising_edge(reset) then
            Memory <= (others => (others => '0'));
        end if;
    end process;

    process (IM_ReadAddress)
    begin
        IM_Instruction <= Memory(to_integer(unsigned(IM_ReadAddress))/4);
    end process;
end behavior;
