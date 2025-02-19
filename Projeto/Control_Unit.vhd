-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Control_Unit is
    port(
        C_OPcode : in std_logic_vector(31 downto 0);
        C_Branch : out std_logic;
        C_MemRead : out std_logic;
        C_MemtoReg : out std_logic;
        C_MemWrite : out std_logic;
        C_ULASrc : out std_logic;
        C_RegWrite : out std_logic;
        C_ULAOp : out std_logic_vector(5 downto 0)
    );
end Control_Unit;

architecture behavior of Control_Unit is
begin
    process (C_OPcode)
begin
    case C_OPcode(6 downto 0) is
        when "0110011" =>  -- R (SLT, SLTu, ADD, SUB, XOR, AND, SLL, OR, SRL, SRA)
            C_ULAOp    <= "000000";
            C_RegWrite <= '1'; 
            C_MemRead  <= '0'; 
            C_MemtoReg <= '0'; 
            C_MemWrite <= '0'; 
            C_ULASrc   <= '0'; 
            C_Branch   <= '0'; 

        when "0000011" =>  -- I (LB, LW, LBU)
            C_ULAOp    <= "000010";
            C_RegWrite <= '1'; 
            C_MemRead  <= '1'; 
            C_MemtoReg <= '1'; 
            C_MemWrite <= '0'; 
            C_ULASrc   <= '1'; 
            C_Branch   <= '0'; 

        when "0100011" =>  -- S (SB, SW)
            C_ULAOp    <= "000011";
            C_RegWrite <= '0'; 
            C_MemRead  <= '0'; 
            C_MemtoReg <= '0'; 
            C_MemWrite <= '1'; 
            C_ULASrc   <= '1'; 
            C_Branch   <= '0'; 

        when "1100011" =>  -- SB (BEQ, BNE)
            C_ULAOp    <= "000100";
            C_RegWrite <= '0'; 
            C_MemRead  <= '0'; 
            C_MemtoReg <= '0'; 
            C_MemWrite <= '0'; 
            C_ULASrc   <= '0'; 
            C_Branch   <= '1'; 

        when "0110111" | "0010111" =>  -- U (AUIPC, LUI)
            C_ULAOp    <= "000101";
            C_RegWrite <= '1'; 
            C_MemRead  <= '0'; 
            C_MemtoReg <= '0'; 
            C_MemWrite <= '0'; 
            C_ULASrc   <= '1'; 
            C_Branch   <= '0'; 

        when "1101111" | "1100111" =>  -- UJ (JAL, JALR)
            C_ULAOp    <= "000110";
            C_RegWrite <= '1';
            C_MemRead  <= '0'; 
            C_MemtoReg <= '0'; 
            C_MemWrite <= '0'; 
            C_ULASrc   <= '1'; 
            C_Branch   <= '1'; 

        when others =>
            C_ULAOp    <= "000000";
            C_RegWrite <= '0';
            C_MemRead  <= '0';
            C_MemtoReg <= '0';
            C_MemWrite <= '0';
            C_ULASrc   <= '0';
            C_Branch   <= '0';
    end case;
end process;
end behavior;
