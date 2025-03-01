library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity XREGS is
  generic (WSIZE : natural := 32);
  port (
  clk, wren : in std_logic;
  rs1, rs2, rd : in std_logic_vector(4 downto 0);
  data : in std_logic_vector(WSIZE-1 downto 0);
  ro1, ro2 : out std_logic_vector(WSIZE-1 downto 0));
end XREGS;


architecture behavior of XREGS is
    type registradores is array (0 to 31) of std_logic_vector(WSIZE-1 downto 0);
    signal regs : registradores := (others => (others => '0')); 
begin
    process (clk, wren, rs1, rs2, rd, data)
    begin
    if rising_edge(clk) then
        if wren = '1' and unsigned(rd) /= 0 then
          regs(to_integer(unsigned(rd))) <= data;
        end if;
        ro1 <= regs(to_integer(unsigned(rs1)));
        ro2 <= regs(to_integer(unsigned(rs2)));
    end if;
    end process;
end behavior;