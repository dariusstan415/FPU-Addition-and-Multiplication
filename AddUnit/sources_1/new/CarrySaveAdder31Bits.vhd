----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/11/2023 12:14:49 AM
-- Design Name: 
-- Module Name: CarrySaveAdder31Bits - Behavioral
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

entity CarryLookAheadAdder31Bits is
  Port (CarryIn: in std_logic;
        A: in std_logic_vector(30 downto 0);
        B: in std_logic_vector(30 downto 0);
        Rez: out std_logic_vector(30 downto 0);
        CarryOut: out std_logic );
end CarryLookAheadAdder31Bits;

architecture Behavioral of CarryLookAheadAdder31Bits is
component CarryLookAheadAdder9bits is
  Port (CarryIn: in std_logic;
        A: in std_logic_vector(8 downto 0);
        B: in std_logic_vector(8 downto 0);
        Rez: out std_logic_vector(8 downto 0);
        CarryOut: out std_logic );
end component;
component CarryLookAheadAdder is
  Port (cin : in std_logic;
        x : in std_logic_vector(3 downto 0);
        y : in std_logic_vector(3 downto 0);
        sum : out std_logic_vector(3 downto 0);
        cout : out std_logic );
end component;
signal partial1, partial2, partial3: std_logic_vector(8 downto 0);
signal partial4: std_logic_vector(3 downto 0);
signal cout1, cout2, cout3, cout4: std_logic;
begin
    c1: CarryLookAheadAdder9bits port map(CarryIn,A(8 downto 0),B(8 downto 0),partial1,cout1);
    c2: CarryLookAheadAdder9bits port map(cout1,A(17 downto 9),B(17 downto 9),partial2,cout2);
    c3: CarryLookAheadAdder9bits port map(cout2,A(26 downto 18),B(26 downto 18),partial3,cout3);
    c4: CarryLookAheadAdder port map(cout3,A(30 downto 27),B(30 downto 27),partial4,cout4);
    Rez <= partial4 & partial3 & partial2 & partial1;
    CarryOut <= cout4;
    
end Behavioral;
