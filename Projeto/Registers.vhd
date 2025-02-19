-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Registers is
  port (
      clck, R_RegWrite : in std_logic;
      R_ReadRegister1, R_ReadRegister2, R_WriteRegister : in std_logic_vector(31 downto 0);
      R_WriteData : in std_logic_vector(31 downto 0);
      R_ReadData1, R_ReadData2 : out std_logic_vector(31 downto 0)
      );
  end Registers;
  
  
  architecture behavior of Registers is
      type registradores is array (0 to 31) of std_logic_vector(31 downto 0);
      signal regs : registradores := (others => (others => '0')); 
  begin
      process (clck, R_RegWrite, R_ReadRegister1(19 downto 15), R_ReadRegister2(24 downto 20), R_WriteRegister(11 downto 7), R_WriteData)
      begin
      if rising_edge(clck) then
          if R_RegWrite = '1' and unsigned(R_WriteRegister(11 downto 7)) /= 0 then
            regs(to_integer(unsigned(R_WriteRegister(11 downto 7)))) <= R_WriteData;
          end if;
          R_ReadData1 <= regs(to_integer(unsigned(R_ReadRegister1(19 downto 15))));
          R_ReadData2 <= regs(to_integer(unsigned(R_ReadRegister2(24 downto 20))));
      end if;
      end process;
  end behavior;
