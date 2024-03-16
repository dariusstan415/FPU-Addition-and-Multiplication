----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/11/2023 12:33:37 AM
-- Design Name: 
-- Module Name: CarryLookAheadAdder93Bits - Behavioral
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

entity CarryLookAheadAdder93Bits is
    Port (CarryIn: in std_logic;
        A: in std_logic_vector(92 downto 0);
        B: in std_logic_vector(92 downto 0);
        Rez: out std_logic_vector(92 downto 0);
        CarryOut: out std_logic );
end CarryLookAheadAdder93Bits;

architecture Behavioral of CarryLookAheadAdder93Bits is
component CarryLookAheadAdder31bits is
  Port (CarryIn: in std_logic;
        A: in std_logic_vector(30 downto 0);
        B: in std_logic_vector(30 downto 0);
        Rez: out std_logic_vector(30 downto 0);
        CarryOut: out std_logic );
end component;
signal partial1, partial2, partial3: std_logic_vector(30 downto 0);
signal cout1, cout2, cout3: std_logic;
begin
    c1: CarryLookAheadAdder31bits port map(CarryIn,A(30 downto 0),B(30 downto 0),partial1,cout1);
    c2: CarryLookAheadAdder31bits port map(cout1,A(61 downto 31),B(61 downto 31),partial2,cout2);
    c3: CarryLookAheadAdder31bits port map(cout2,A(92 downto 62),B(92 downto 62),partial3,cout3);
    Rez <= partial3 & partial2 & partial1;
    CarryOut <= cout3;
end Behavioral;
