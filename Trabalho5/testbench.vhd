library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end ula_tb;

architecture behavior of ula_tb is
    signal opcode : std_logic_vector(3 downto 0);
    signal A : std_logic_vector(31 downto 0);
    signal B : std_logic_vector(31 downto 0);
    signal Z : std_logic_vector(31 downto 0);
    signal cond : std_logic;
begin
    base: entity work.ulaRV
        generic map (input_size => 32)
        port map (
            A => A,
            B => B,
            opcode => opcode,
            Z => Z,
            cond => cond
        );

    tests: process
    begin
---------------------------------------------------------------------------

        A <= "00000000000000000000000000000011";
        B <= "00000000000000000000000000000101";
        opcode <= "0000";
        wait for 10 ns;
        report "Teste 1 - Z recebe a soma das entradas A, B: " &
               "A: " & integer'image(to_integer(signed(A))) &
               ", B: " & integer'image(to_integer(signed(B))) &
               ", opcode: " & to_string(std_logic_vector(opcode)) &
               ", Z: " & integer'image(to_integer(signed(Z)));

---------------------------------------------------------------------------

        A <= "00000000000000000000000000001000";
        B <= "00000000000000000000000000000010";
        opcode <= "0001";
        wait for 10 ns;
        report "Teste 2 - Z recebe A - B:" &
               "A: " & integer'image(to_integer(signed(A))) &
               ", B: " & integer'image(to_integer(signed(B))) &
               ", opcode: " & to_string(std_logic_vector(opcode)) &
               ", Z: " & integer'image(to_integer(signed(Z)));

---------------------------------------------------------------------------

        A <= "00000000000000000000000000001111";
        B <= "00000000000000000000000000001010";
        opcode <= "0010";
        wait for 10 ns;
        report "Teste 3 - Z recebe a operacao logica A and B, bit a bit:" &
               "A: " & to_string(std_logic_vector(A)) &
                ", B: " & to_string(std_logic_vector(B)) &
                ", opcode: " & to_string(std_logic_vector(opcode)) &
                ", Z: " & to_string(std_logic_vector(Z));

---------------------------------------------------------------------------

        A <= "00000000000000000000000000001100";
        B <= "00000000000000000000000000000101";
        opcode <= "0011";
        wait for 10 ns;
        report "Teste 4 - Z recebe a operacao logica A or B, bit a bit:" &
               "A: " & to_string(std_logic_vector(A)) &
                ", B: " & to_string(std_logic_vector(B)) &
                ", opcode: " & to_string(std_logic_vector(opcode)) &
                ", Z: " & to_string(std_logic_vector(Z));

---------------------------------------------------------------------------

        A <= "00000000000000000000000000001101";
        B <= "00000000000000000000000000001010";
        opcode <= "0100";
        wait for 10 ns;
        report "Teste 5 - Z recebe a operacao logica A xor B, bit a bit:" &
               "A: " & to_string(std_logic_vector(A)) &
                ", B: " & to_string(std_logic_vector(B)) &
                ", opcode: " & to_string(std_logic_vector(opcode)) &
                ", Z: " & to_string(std_logic_vector(Z));

---------------------------------------------------------------------------

        A <= "00000000000000000000000000000011";
        B <= "00000000000000000000000000000010";
        opcode <= "0101";
        wait for 10 ns;
        report "Teste 6 - Z recebe a entrada A deslocada B bits a esquerda:" &
                "A: " & to_string(std_logic_vector(A)) &
                ", B: " & integer'image(to_integer(unsigned(B))) &
                ", opcode: " & to_string(std_logic_vector(opcode)) &
                ", Z: " & to_string(std_logic_vector(Z));


---------------------------------------------------------------------------

        A <= "00000000000000000000000000001100";
        B <= "00000000000000000000000000000010";
        opcode <= "0110";
        wait for 10 ns;
        report "Teste 7 - Z recebe a entrada A deslocada B bits a direita sem sinal:" &
               "A: " & to_string(std_logic_vector(unsigned(A))) &
                ", B: " & integer'image(to_integer(unsigned(B))) &
                ", opcode: " & to_string(std_logic_vector(opcode)) &
                ", Z: " & to_string(std_logic_vector(Z));

---------------------------------------------------------------------------

        A <= "11111111111111111111111111111000";
        B <= "00000000000000000000000000000010";
        opcode <= "0111";
        wait for 10 ns;
        report "Teste 8 - Z recebe a entrada A deslocada B bits a direita com sinal:" &
               "A: " & to_string(std_logic_vector((signed(A)))) &
                ", B: " & integer'image(to_integer(unsigned(B))) &
                ", opcode: " & to_string(std_logic_vector(opcode)) &
                ", Z: " & to_string(std_logic_vector(Z));
               
---------------------------------------------------------------------------

        A <= "00000000000000000000000000000100";
        B <= "00000000000000000000000000001000"; 
        opcode <= "1000"; 
        wait for 10 ns;
        report "Teste 9 - cond = 1 se A < B, com sinal:" &
               "A: " & integer'image(to_integer(signed(A))) &
               ", B: " & integer'image(to_integer(signed(B))) &
               ", opcode: " & to_string(std_logic_vector(opcode)) &
               ", cond: " & std_logic'image(cond);
        A <= "11111111111111111111111111110100";
        B <= "00000000000000000000000000001000";
        opcode <= "1000";
        wait for 10 ns;
        report "Teste 9 - cond = 1 se A < B, com sinal:" &
               "A: " & integer'image(to_integer(signed(A))) &
               ", B: " & integer'image(to_integer(signed(B))) &
               ", opcode: " & to_string(std_logic_vector(opcode)) &
               ", cond: " & std_logic'image(cond);
        A <= "00000000000000000000000000001000";
        B <= "00000000000000000000000000000100"; 
        opcode <= "1000"; 
        wait for 10 ns;
        report "Teste 9 - cond = 1 se A < B, com sinal:" &
               "A: " & integer'image(to_integer(signed(A))) &
               ", B: " & integer'image(to_integer(signed(B))) &
               ", opcode: " & to_string(std_logic_vector(opcode)) &
               ", cond: " & std_logic'image(cond);
        A <= "00000000000000000000000000001000";
        B <= "11111111111111111111111111110100";
        opcode <= "1000";
        wait for 10 ns;
        report "Teste 9 - cond = 1 se A < B, com sinal:" &
               "A: " & integer'image(to_integer(signed(A))) &
               ", B: " & integer'image(to_integer(signed(B))) &
               ", opcode: " & to_string(std_logic_vector(opcode)) &
               ", cond: " & std_logic'image(cond);

---------------------------------------------------------------------------

        A <= "00000000000000000000000000000100";
        B <= "00000000000000000000000000001000";
        opcode <= "1001";
        wait for 10 ns;
          report "Teste 10 - cond = 1 se A < B, sem sinal:" &
          "A: " & integer'image(to_integer(unsigned(A))) &
          ", B: " & integer'image(to_integer(unsigned(B))) &
          ", opcode: " & to_string(std_logic_vector(opcode)) &
          ", cond: " & std_logic'image(cond);
        A <= "00000000000000000000000000001000";
        B <= "00000000000000000000000000000100";
        opcode <= "1001";
        wait for 10 ns;
          report "Teste 10 - cond = 1 se A < B, sem sinal:" &
          "A: " & integer'image(to_integer(unsigned(A))) &
          ", B: " & integer'image(to_integer(unsigned(B))) &
          ", opcode: " & to_string(std_logic_vector(opcode)) &
          ", cond: " & std_logic'image(cond);

---------------------------------------------------------------------------

        A <= "00000000000000000000000000001000";
        B <= "00000000000000000000000000000100";
        opcode <= "1010";
        wait for 10 ns;
          report "Teste 11 - cond = 1 se A >= B, com sinal:" &
          "A: " & integer'image(to_integer(signed(A))) &
          ", B: " & integer'image(to_integer(signed(B))) &
          ", opcode: " & to_string(std_logic_vector(opcode)) &
          ", cond: " & std_logic'image(cond);
        A <= "00000000000000000000000000000100";
        B <= "00000000000000000000000000001000";
        opcode <= "1010";
        wait for 10 ns;
          report "Teste 11 - cond = 1 se A >= B, com sinal:" &
          "A: " & integer'image(to_integer(signed(A))) &
          ", B: " & integer'image(to_integer(signed(B))) &
          ", opcode: " & to_string(std_logic_vector(opcode)) &
          ", cond: " & std_logic'image(cond);
        A <= "11111111111111111111111111111100";
        B <= "11111111111111111111111111111100";
        opcode <= "1010";
        wait for 10 ns;
          report "Teste 11 - cond = 1 se A >= B, com sinal:" &
          "A: " & integer'image(to_integer(signed(A))) &
          ", B: " & integer'image(to_integer(signed(B))) &
          ", opcode: " & to_string(std_logic_vector(opcode)) &
          ", cond: " & std_logic'image(cond);
        A <= "00000000000000000000000000001000";
        B <= "11111111111111111111111111111100";
        opcode <= "1010";
        wait for 10 ns;
          report "Teste 11 - cond = 1 se A >= B, com sinal:" &
          "A: " & integer'image(to_integer(signed(A))) &
          ", B: " & integer'image(to_integer(signed(B))) &
          ", opcode: " & to_string(std_logic_vector(opcode)) &
          ", cond: " & std_logic'image(cond);
        A <= "11111111111111111111111111111100";
        B <= "00000000000000000000000000001000";
        opcode <= "1010";
        wait for 10 ns;
          report "Teste 11 - cond = 1 se A >= B, com sinal:" &
          "A: " & integer'image(to_integer(signed(A))) &
          ", B: " & integer'image(to_integer(signed(B))) &
          ", opcode: " & to_string(std_logic_vector(opcode)) &
          ", cond: " & std_logic'image(cond);

---------------------------------------------------------------------------

        A <= "00000000000000000000000000001000";
        B <= "00000000000000000000000000000100";
        opcode <= "1011";
        wait for 10 ns;
          report "Teste 12 - cond = 1 se A >= B, sem sinal:" &
          "A: " & integer'image(to_integer(unsigned(A))) &
          ", B: " & integer'image(to_integer(unsigned(B))) &
          ", opcode: " & to_string(std_logic_vector(opcode)) &
          ", cond: " & std_logic'image(cond);
        A <= "00000000000000000000000000001000";
        B <= "00000000000000000000000000001000";
        opcode <= "1011";
        wait for 10 ns;
          report "Teste 12 - cond = 1 se A >= B, sem sinal:" &
          "A: " & integer'image(to_integer(unsigned(A))) &
          ", B: " & integer'image(to_integer(unsigned(B))) &
          ", opcode: " & to_string(std_logic_vector(opcode)) &
          ", cond: " & std_logic'image(cond);
        A <= "00000000000000000000000000000100";
        B <= "00000000000000000000000000001000";
        opcode <= "1011";
        wait for 10 ns;
          report "Teste 12 - cond = 1 se A >= B, sem sinal:" &
          "A: " & integer'image(to_integer(unsigned(A))) &
          ", B: " & integer'image(to_integer(unsigned(B))) &
          ", opcode: " & to_string(std_logic_vector(opcode)) &
          ", cond: " & std_logic'image(cond);

---------------------------------------------------------------------------

        A <= "00000000000000000000000000000100";
        B <= "00000000000000000000000000000100";
        opcode <= "1100";
        wait for 10 ns;
          report "Teste 13 - cond = 1 se A == B:" &
          "A: " & integer'image(to_integer(signed(A))) &
          ", B: " & integer'image(to_integer(signed(B))) &
          ", opcode: " & to_string(std_logic_vector(opcode)) &
          ", cond: " & std_logic'image(cond);
        A <= "00000000000000000000000000001000";
        B <= "00000000000000000000000000000100";
        opcode <= "1100";
        wait for 10 ns;
          report "Teste 13 - cond = 1 se A == B:" &
          "A: " & integer'image(to_integer(signed(A))) &
          ", B: " & integer'image(to_integer(signed(B))) &
          ", opcode: " & to_string(std_logic_vector(opcode)) &
          ", cond: " & std_logic'image(cond);

---------------------------------------------------------------------------

        A <= "00000000000000000000000000001000";
        B <= "00000000000000000000000000000100";
        opcode <= "1101";
        wait for 10 ns;
          report "Teste 14 - cond = 1 se A != B:" &
          "A: " & integer'image(to_integer(signed(A))) &
          ", B: " & integer'image(to_integer(signed(B))) &
          ", opcode: " & to_string(std_logic_vector(opcode)) &
          ", cond: " & std_logic'image(cond);
        A <= "00000000000000000000000000000100";
        B <= "00000000000000000000000000000100";
        opcode <= "1101";
        wait for 10 ns;
          report "Teste 14 - cond = 1 se A != B:" &
          "A: " & integer'image(to_integer(signed(A))) &
          ", B: " & integer'image(to_integer(signed(B))) &
          ", opcode: " & to_string(std_logic_vector(opcode)) &
          ", cond: " & std_logic'image(cond);

---------------------------------------------------------------------------

        wait;
    end process;
end behavior;
