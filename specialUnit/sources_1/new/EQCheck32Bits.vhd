----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 09:59:25 PM
-- Design Name: 
-- Module Name: EQCheck32Bits - Behavioral
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

entity EQCheck32Bits is
  Port (u : in std_logic_vector(31 downto 0);
        v: in std_logic_vector(31 downto 0);
        t: out std_logic );
end EQCheck32Bits;

architecture Behavioral of EQCheck32Bits is

component EQCheck8Bits is
  Port (u : in std_logic_vector(7 downto 0);
        v: in std_logic_vector(7 downto 0);
        t: out std_logic );
end component;
signal aux : std_logic_vector(3 downto 0) := "0000";
begin
    c1: EQCheck8Bits port map (u(31 downto 24), v(31 downto 24), aux(3));
    c2: EQCheck8Bits port map (u(23 downto 16), v(23 downto 16), aux(2));
    c3: EQCheck8Bits port map (u(15 downto 8), v(15 downto 8), aux(1));
    c4: EQCheck8Bits port map (u(7 downto 0), v(7 downto 0), aux(0));
    --process(aux)
    --begin
        t <= aux(0) and aux(1) and aux(2) and aux(3);
    --end process;

end Behavioral;
