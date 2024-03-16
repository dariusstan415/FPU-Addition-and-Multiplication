----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2023 11:50:26 AM
-- Design Name: 
-- Module Name: Simulation02 - Behavioral
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

entity Simulation02 is
--  Port ( );
end Simulation02;

architecture Behavioral of Simulation02 is
component Sumator24Bits is
  Port (en: in std_logic;
        A: in std_logic_vector(23 downto 0);
        B: in std_logic_vector(23 downto 0);
        carryIn: in std_logic;
        Rez: out std_logic_vector(23 downto 0);
        carryOut: out std_logic );
end component;
signal rezz: std_logic_vector(24 downto 0);
signal A,B: std_logic_vector(23 downto 0);
signal C: std_logic_vector(3 downto 0):="1000";
begin
    A <= "100011000000000000000000";
    B <= "011101000000000000000000";
    cc: Sumator24Bits port map('1',A, B, '0', rezz(23 downto 0), rezz(24) );
    --C <= C(0) & C(3 downto 1);
end Behavioral;
