----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2023 12:21:32 AM
-- Design Name: 
-- Module Name: Opp2CBig - Behavioral
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

entity Opp2CBig is
  Port (A: in std_logic_vector(279 downto 0);
        minusA: out std_logic_vector(279 downto 0) );
end Opp2CBig;

architecture Behavioral of Opp2CBig is
signal minusAaux: std_logic_vector(279 downto 0);
signal zero: std_logic_vector(91 downto 0):=X"00000000000000000000000";
signal zero1,zeroo: std_logic_vector(92 downto 0);

signal partial1, partial2, partial3: std_logic_vector(92 downto 0);
signal cout1, cout2, cout3: std_logic;


component CarryLookAheadAdder93Bits is
    Port (CarryIn: in std_logic;
        A: in std_logic_vector(92 downto 0);
        B: in std_logic_vector(92 downto 0);
        Rez: out std_logic_vector(92 downto 0);
        CarryOut: out std_logic );
end component;
begin
    zero1 <= zero & "1";
    zeroo <= zero & "0";
    gen_for_loop: for i in 0 to 279 generate
        minusAaux(i) <= not A(i);
    end generate;
    c1: CarryLookAheadAdder93bits port map('0',minusAaux(92 downto 0),zero1,partial1,cout1);
    c2: CarryLookAheadAdder93bits port map(cout1,minusAaux(185 downto 93),zeroo,partial2,cout2);
    c3: CarryLookAheadAdder93bits port map(cout2,minusAaux(278 downto 186),zeroo,partial3,cout3);
    minusA(279) <= minusAaux(279) xor '0' xor cout3;
    minusA(278 downto 0) <= partial3 & partial2 & partial1;
end Behavioral;
