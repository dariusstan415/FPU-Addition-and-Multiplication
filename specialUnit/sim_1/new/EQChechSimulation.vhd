----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 10:10:25 PM
-- Design Name: 
-- Module Name: EQChechSimulation - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EQChechSimulation is
--  Port ( );
end EQChechSimulation;

architecture Behavioral of EQChechSimulation is
component EQCheck32Bits is
  Port (u : in std_logic_vector(31 downto 0);
        v: in std_logic_vector(31 downto 0);
        t: out std_logic );
end component;
signal x : std_logic_vector(31 downto 0);
signal y : std_logic_vector(31 downto 0);
signal tt : std_logic;
begin
    c: EQCheck32Bits port map (x,y,tt);
    x <= X"00000001", X"01010111" after 12 ns, X"00000001" after 24 ns;
    y <= X"00000000", X"01010111" after 12 ns, X"00000010" after 24 ns, X"00000001" after 36 ns;

end Behavioral;
