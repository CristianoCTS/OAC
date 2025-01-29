library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture behavior of testbench is
  signal instr : std_logic_vector(31 downto 0);
  signal imm32 : signed(31 downto 0);

begin

  base: entity work.genImm32
    port map (
      instr => instr,
      imm32 => imm32);
  tests: process
    variable expected : signed(31 downto 0);
  begin

	-- R
    instr <= std_logic_vector(x"000002B3");
    wait for 10 ns;
    expected := x"00000000";
    if imm32 = expected then
    	report "R SUCCESS: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    else
    	report "R FAILURE: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    end if;
    
	-- I
    instr <= x"01002283";
    wait for 10 ns;
    expected := x"00000010";
    if imm32 = expected then
    	report "I (lw) SUCCESS: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    else
    	report "I (lw) FAILURE: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    end if;
    instr <= x"F9C00313";
    wait for 10 ns;
    expected := x"FFFFFF9C";
    if imm32 = expected then
        report "I (addi) SUCCESS: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    else
        report "I (addi) FAILURE: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    end if;
    instr <= x"FFF2C293";
    wait for 10 ns;
    expected := x"FFFFFFFF";
    if imm32 = expected then
        report "I (xori) SUCCESS: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    else
        report "I (xori) FAILURE: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    end if;
    instr <= x"16200313";
    wait for 10 ns;
    expected := x"00000162";
    if imm32 = expected then
        report "I (addi) SUCCESS: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    else
        report "I (addi) FAILURE: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    end if;
    instr <= x"01800067";
    wait for 10 ns;
    expected := x"00000018";
    if imm32 = expected then
        report "I (jalr) SUCCESS: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    else
        report "I (jalr) FAILURE: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    end if;
    instr <= x"40A3D313";
    wait for 10 ns;
    expected := x"0000000A";
    if imm32 = expected then
        report "I (srai) SUCCESS: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    else
        report "I (srai) FAILURE: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    end if;

    -- S
    instr <= x"02542E23";
    wait for 10 ns;
    expected := x"0000003C";
    if imm32 = expected then
        report "S SUCCESS: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    else
        report "S FAILURE: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    end if;

    -- SB
    instr <= x"FE5290E3";
    wait for 10 ns;
    expected := x"FFFFFFE0";
    if imm32 = expected then
        report "SB SUCCESS: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    else
        report "SB FAILURE: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    end if;

    -- U
    instr <= x"00002437";
    wait for 10 ns;
    expected := x"00002000";
    if imm32 = expected then
        report "U SUCCESS: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    else
        report "U FAILURE: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    end if;

    -- UJ
    instr <= x"00C000EF";
    wait for 10 ns;
    expected := x"0000000C";
    if imm32 = expected then
        report "UJ SUCCESS: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    else
        report "UJ FAILURE: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    end if;
    
    -- OTHERS
    instr <= x"00C002ED";
    wait for 10 ns;
    expected := x"00000001";
    if imm32 = expected then
        report "OTHERS SUCCESS: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    else
        report "OTHERS FAILURE: " & " sent:" & to_string(instr) & " / expected:" & to_string(expected) & " / received: " & to_string(std_logic_vector(imm32));
    end if;
    wait;
  end process;

end behavior;

