----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2023 06:06:10 PM
-- Design Name: 
-- Module Name: CarryLookAheadAdder9bits - Behavioral
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

entity CarryLookAheadAdder9bits is
  Port (CarryIn: in std_logic;
        A: in std_logic_vector(8 downto 0);
        B: in std_logic_vector(8 downto 0);
        Rez: out std_logic_vector(8 downto 0);
        CarryOut: out std_logic );
end CarryLookAheadAdder9bits;

architecture Behavioral of CarryLookAheadAdder9bits is
component carryLookaheadAdder is
  Port (cin : in std_logic;
        x : in std_logic_vector(3 downto 0);
        y : in std_logic_vector(3 downto 0);
        sum : out std_logic_vector(3 downto 0);
        cout : out std_logic );
end component;

signal carry1, carry2, r : std_logic :='0';
signal rez1, rez2: std_logic_vector(3 downto 0);
begin
    comp1: carryLookaheadAdder port map(CarryIn, A(3 downto 0), B(3 downto 0), rez1, carry1);
    comp2: carryLookaheadAdder port map(carry1, A(7 downto 4), B(7 downto 4), rez2, carry2);
    r <= A(8) xor B(8) xor carry2;
    CarryOut <= (B(8) and (A(8) xor carry2)) or (A(8) and carry2);
    Rez <= r & rez2 & rez1;
    
end Behavioral;
