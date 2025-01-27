library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ulaRV is
generic (input_size : natural := 32);
    port (
        opcode : in std_logic_vector(3 downto 0);
        A : in std_logic_vector(input_size-1 downto 0);
        B : in std_logic_vector(input_size-1 downto 0);
        Z : out std_logic_vector(input_size-1 downto 0);
        cond   : out std_logic);
end ulaRV;

architecture behavior of ulaRV is
begin
    process (A, B, opcode)
    begin
        case opcode is
            when "0000" => Z <= std_logic_vector(signed(A) + signed(B));
            when "0001" => Z <= std_logic_vector(signed(A) - signed(B));
            when "0010" => Z <= A and B;
            when "0011" => Z <= A or B; 
            when "0100" => Z <= A xor B;
            when "0101" => Z <= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B))));
            when "0110" => Z <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B))));
            when "0111" => Z <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(B))));
            when "1000" => cond <= '1' when signed(A) < signed(B) else '0';
            when "1001" => cond <= '1' when unsigned(A) < unsigned(B) else '0';
            when "1010" => cond <= '1' when signed(A) >= signed(B) else '0';
            when "1011" => cond <= '1' when unsigned(A) >= unsigned(B) else '0';
            when "1100" => cond <= '1' when A = B else '0';
            when "1101" => cond <= '1' when A /= B else '0';
            when others => 
                Z <= (others => '0');
                cond <= '0';
        end case;
    end process;
end behavior;
