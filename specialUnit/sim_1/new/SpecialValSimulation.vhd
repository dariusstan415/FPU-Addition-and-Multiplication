----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2023 08:42:27 AM
-- Design Name: 
-- Module Name: SpecialValSimulation - Behavioral
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

entity SpecialValSimulation is
--  Port ( );
end SpecialValSimulation;

architecture Behavioral of SpecialValSimulation is
component SpecialValSingular is
  Port (A : in std_logic_vector(31 downto 0);
        code : out std_logic_vector(4 downto 0) );
end component;

signal nr: std_logic_vector(31 downto 0);
signal c: std_logic_vector(4 downto 0);
begin
    ccc: SpecialValSingular port map (nr,c);
    nr <= "00000000000000000000000000000000", -- zero
          "01111111100000000000000000000000" after 15 ns, -- inf
          "11111111100000000000000000000000" after 30 ns, -- minus inf
          "10000000000000000000000000000000" after 37 ns, -- zero
          "00000000110100000000000000000000" after 45 ns, -- normalised
          "00000000001000000000000000000000" after 60 ns, -- denormalised
          "01111111101000000000000000000000" after 75 ns; -- nan

end Behavioral;
