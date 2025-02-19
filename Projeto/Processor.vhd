-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

------------------------------------Entradas & Saidas-----------------------------------
architecture test of testbench is
    constant clock_duration : time := 2 ns;
    signal A1_PC : std_logic_vector(31 downto 0);
    signal A1_PC4 : std_logic_vector(31 downto 0);
    signal A2_PC : std_logic_vector(31 downto 0);
    signal A2_Imm : std_logic_vector(31 downto 0);
    signal A2_PCI : std_logic_vector(31 downto 0);
    signal C_OPcode : std_logic_vector(31 downto 0);
    signal C_Branch : std_logic;
    signal C_MemRead : std_logic;
    signal C_MemtoReg : std_logic;
    signal C_MemWrite : std_logic;
    signal C_ULASrc : std_logic;
    signal C_RegWrite : std_logic;
    signal C_ULAOp : std_logic_vector(5 downto 0);
    signal clck : std_logic;
    signal reset : std_logic;
    signal DM_MemWrite : std_logic;
    signal DM_MemRead : std_logic;
    signal DM_Address : std_logic_vector(31 downto 0);
    signal DM_WriteData : std_logic_vector(31 downto 0);
    signal DM_ReadData : std_logic_vector(31 downto 0);
    signal IG_instruction  :  std_logic_vector(31 downto 0);
    signal IG_imm  : signed(31 downto 0);
    signal IM_ReadAddress : std_logic_vector(31 downto 0);
    signal IM_Instruction : std_logic_vector(31 downto 0);
    signal M1_PC4 : std_logic_vector(31 downto 0);
    signal M1_PCI : std_logic_vector(31 downto 0);
    signal M1_Branch : std_logic;
    signal M1_Zero : std_logic;
    signal M1_NextPC : std_logic_vector(31 downto 0);
    signal M2_ULASrc : std_logic;
    signal M2_ReadData2 : std_logic_vector(31 downto 0);
    signal M2_Imm : signed(31 downto 0);
    signal M2_B : std_logic_vector(31 downto 0);
    signal M3_MemtoReg : std_logic;
    signal M3_ULAresult : std_logic_vector(31 downto 0);
    signal M3_ReadData : std_logic_vector(31 downto 0);
    signal M3_WriteData : std_logic_vector(31 downto 0);
    signal PC_NextPC : std_logic_vector(31 downto 0);
    signal PC_PC : std_logic_vector(31 downto 0);
    signal clk : std_logic;
    signal R_RegWrite : std_logic;
    signal R_ReadRegister1 : std_logic_vector(31 downto 0);
    signal R_ReadRegister2 : std_logic_vector(31 downto 0);
    signal R_WriteRegister : std_logic_vector(31 downto 0);
    signal R_WriteData : std_logic_vector(31 downto 0);
    signal R_ReadData1 : std_logic_vector(31 downto 0);
    signal R_ReadData2 : std_logic_vector(31 downto 0);
    signal SL_Imm : signed(31 downto 0);
    signal SL_ShiftedImm : std_logic_vector(31 downto 0);
    signal UC_instruction    :  std_logic_vector(31 downto 0);
    signal UC_ULAOp     :  std_logic_vector(5 downto 0);
    signal UC_Control : std_logic_vector(3 downto 0);
    signal U_Control : std_logic_vector(3 downto 0);
    signal U_ReadData1 : std_logic_vector(31 downto 0);
    signal U_B : std_logic_vector(31 downto 0);
    signal U_ULAResult : std_logic_vector(31 downto 0);
    signal U_Zero   : std_logic;

    component Adder1
        port(
            A1_PC : in std_logic_vector(31 downto 0);
            A1_PC4 : out std_logic_vector(31 downto 0)
        );
    end component;
    component Adder2
        port(
            A2_PC : in std_logic_vector(31 downto 0);
            A2_Imm : in std_logic_vector(31 downto 0);
            A2_PCI : out std_logic_vector(31 downto 0)
        );
    end component;
    component Mux1
        port(
            M1_PC4 : in std_logic_vector(31 downto 0);
            M1_PCI : in std_logic_vector(31 downto 0);
            M1_Branch : in std_logic;
            M1_Zero : in std_logic;
            M1_NextPC : out std_logic_vector(31 downto 0)
        );
    end component;
    component Mux2
        port(
            M2_ULASrc : in std_logic;
            M2_ReadData2 : in std_logic_vector(31 downto 0);
            M2_Imm : in signed(31 downto 0);
            M2_B : out std_logic_vector(31 downto 0)
        );
    end component;
    component Mux3
        port(
            M3_MemtoReg : in std_logic;
            M3_ULAresult : in std_logic_vector(31 downto 0);
            M3_ReadData : in std_logic_vector(31 downto 0);
            M3_WriteData : out std_logic_vector(31 downto 0)
        );
    end component;
    component Control_Unit
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
    end component;
    component Data_Memory
        port(
            clck : in std_logic;
            reset : in std_logic;
            DM_MemWrite : in std_logic;
            DM_MemRead : in std_logic;
            DM_Address : in std_logic_vector(31 downto 0);
            DM_WriteData : in std_logic_vector(31 downto 0);
            DM_ReadData : out std_logic_vector(31 downto 0)
        );
        end component;
    component Imediate_Generator
        port (
            IG_instruction  : in  std_logic_vector(31 downto 0);
            IG_imm  : out signed(31 downto 0)
        );
    end component;
    component Instruction_Memory
        port(
            reset : in std_logic;
            IM_ReadAddress : in std_logic_vector(31 downto 0);
            IM_Instruction : out std_logic_vector(31 downto 0)
        );
    end component;
    component Program_Counter
        port(
            clck : in std_logic;
            reset : in std_logic;
            PC_NextPC : in std_logic_vector(31 downto 0);
            PC_PC : out std_logic_vector(31 downto 0)
        );
    end component;
    component Registers
        port (
        clk, R_RegWrite : in std_logic;
        R_ReadRegister1, R_ReadRegister2, R_WriteRegister : in std_logic_vector(31 downto 0);
        R_WriteData : in std_logic_vector(31 downto 0);
        R_ReadData1, R_ReadData2 : out std_logic_vector(31 downto 0)
        );
    end component;
    component ShiftLeft1
        port(
            SL_Imm : in signed(31 downto 0);
            SL_ShiftedImm : out std_logic_vector(31 downto 0);
        );
    end component;
    component ULA_Control
        port (
            UC_instruction    : in  std_logic_vector(31 downto 0);
            UC_ULAOp     : in  std_logic_vector(5 downto 0);
            UC_Control : out std_logic_vector(3 downto 0)
        );
    end component;
    component ULA
        port (
            U_Control : in std_logic_vector(3 downto 0);
            U_ReadData1 : in std_logic_vector(31 downto 0);
            U_B : in std_logic_vector(31 downto 0);
            U_ULAResult : out std_logic_vector(31 downto 0);
            U_Zero   : out std_logic
            );
    end component;
    
    begin

        base2: Adder1
             port map (
                A1_PC => PC_PC,
                A1_PC4 => A1_PC4
             );
        base3: Adder2
             port map (
                A2_PC => PC_PC,
                A2_Imm => SL_ShiftedImm,
                A2_PCI => A2_PCI
             );
        base4: Mux1
             port map (
                M1_PC4 => A1_PC4,
                M1_PCI => A2_PCI,
                M1_Branch => C_Branch,
                M1_Zero => U_Zero,
                M1_NextPC => M1_NextPC
             );
        base5: Mux2
             port map (
                M2_ULASrc => C_ULASrc,
                M2_ReadData2 => R_ReadData2,
                M2_Imm => IG_imm,
                M2_B => M2_B
             );
        base6: Mux3
             port map (
                M3_MemtoReg => C_MemtoReg,
                M3_ULAresult => U_ULAResult,
                M3_ReadData => DM_ReadData,
                M3_WriteData =>  M3_WriteData
             );
        base7: Control_Unit
             port map (
                C_OPcode => IM_Instruction,
                C_Branch => C_Branch,
                C_MemRead => C_MemRead,
                C_MemtoReg => C_MemtoReg,
                C_MemWrite => C_MemWrite,
                C_ULASrc => C_ULASrc,
                C_RegWrite => C_RegWrite,
                C_ULAOp => C_ULAOp
             );
        base8: Data_Memory
             port map (
                clck => clck,
                reset => reset,
                DM_MemWrite => C_MemWrite,
                DM_MemRead => C_MemRead,
                DM_Address => U_ULAResult,
                DM_WriteData => R_ReadData2,
                DM_ReadData => DM_ReadData
             );
        base9: Imediate_Generator
             port map  (
                IG_instruction => IM_Instruction,
                IG_imm => IG_imm
             );
        base10: Instruction_Memory
             port map (
                reset => reset,
                IM_ReadAddress => PC_PC,
                IM_Instruction => IM_Instruction
             );
        base11: Program_Counter
             port map (
                clck => clck,
                reset => reset,
                PC_NextPC => M1_NextPC,
                PC_PC => PC_PC
             );
        base12: Registers
             port map  (
                clk => clk,
                R_RegWrite => C_RegWrite,
                R_ReadRegister1 => IM_Instruction,
                R_ReadRegister2 => IM_Instruction,
                R_WriteRegister => IM_Instruction,
                R_WriteData => M3_WriteData,
                R_ReadData1 => R_ReadData1,
                R_ReadData2 => R_ReadData2
             );
        base13: ShiftLeft1
             port map (
                SL_Imm => IG_imm,
                SL_ShiftedImm => SL_ShiftedImm
             );
        base14: ULA_Control
             port map  (
                UC_instruction => IM_Instruction,
                UC_ULAOp => C_ULAOp,
                UC_Control => UC_Control
             );
        base15: ULA
             port map  (
                U_Control => UC_Control,
                U_ReadData1 => R_ReadData1,
                U_B => M2_B,
                U_ULAResult => U_ULAResult,
                U_Zero => U_Zero
             );
------------------------------------Entradas & Saidas-----------------------------------

------------------------------------Processos-------------------------------------------
process
    begin
    report "RODANDO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
wait;
end process;

process
    begin
        for i in 0 to 30 loop
            clk <= '0';
            wait for clock_duration/2;
            clk <= '1';
            wait for clock_duration/2;
            case IM_Instruction(6 downto 0) is
                when "0110011" => report "PC :(" & to_string(PC_PC) & ") => instruction(R): (" & to_string(IM_Instruction(31 downto 25)) & " " & to_string(IM_Instruction(24 downto 20)) & " " & to_string(IM_Instruction(19 downto 15)) & " " & to_string(IM_Instruction(14 downto 12)) & " " & to_string(IM_Instruction(11 downto 7)) & " " & to_string(IM_Instruction(6 downto 0)) & ")";
                when "0000011" => report "PC :(" & to_string(PC_PC) & ") => instruction(I): (" & to_string(IM_Instruction(31 downto 20)) & " " & to_string(IM_Instruction(19 downto 15)) & " " & to_string(IM_Instruction(14 downto 12)) & " " & to_string(IM_Instruction(11 downto 7)) & " " & to_string(IM_Instruction(6 downto 0)) & ")";
                when "0100011" =>  report "PC :(" & to_string(PC_PC) & ") => instruction(S): (" & to_string(IM_Instruction(31 downto 25)) & " " & to_string(IM_Instruction(24 downto 20)) & " " & to_string(IM_Instruction(19 downto 15)) & " " & to_string(IM_Instruction(14 downto 12)) & " " & to_string(IM_Instruction(11 downto 7)) & " " & to_string(IM_Instruction(6 downto 0)) & ")";
                when "1100011" => report "PC :(" & to_string(PC_PC) & ") => instruction(SB): (" & to_string(IM_Instruction(31 downto 25)) & " " & to_string(IM_Instruction(24 downto 20)) & " " & to_string(IM_Instruction(19 downto 15)) & " " & to_string(IM_Instruction(14 downto 12)) & " " & to_string(IM_Instruction(11 downto 7)) & " " & to_string(IM_Instruction(6 downto 0)) & ")";
                when "0110111" | "0010111" =>  report "PC :(" & to_string(PC_PC) & ") => instruction(U): (" & to_string(IM_Instruction(31 downto 7)) & " " & to_string(IM_Instruction(6 downto 0)) & ")";
                when "1101111" | "1100111" => report "PC :(" & to_string(PC_PC) & ") => instruction(UJ): (" & to_string(IM_Instruction(31 downto 7)) & " " & to_string(IM_Instruction(6 downto 0)) & ")";
                when others => report "PC :(" & to_string(PC_PC) & ") => invalid instruction: (" & to_string(IM_Instruction) & ")";
            end case;
     end loop;
wait;
end process;
end test;
------------------------------------Processos-------------------------------------------
