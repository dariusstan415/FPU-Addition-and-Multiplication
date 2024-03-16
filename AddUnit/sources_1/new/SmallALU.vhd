----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2023 05:21:31 PM
-- Design Name: 
-- Module Name: SmallALU - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SmallALU is
  Port (expA: in std_logic_vector(7 downto 0);
        expB: in std_logic_vector(7 downto 0);
        expDiff: out std_logic_vector(7 downto 0);
        cmpAB: out std_logic  );
end SmallALU;

architecture Behavioral of SmallALU is
component Opp2C is
  Port (A: in std_logic_vector(8 downto 0);
        minusA: out std_logic_vector(8 downto 0) );
end component;

component CarryLookAheadAdder9bits is
  Port (CarryIn: in std_logic;
        A: in std_logic_vector(8 downto 0);
        B: in std_logic_vector(8 downto 0);
        Rez: out std_logic_vector(8 downto 0);
        CarryOut: out std_logic );
end component;

signal mexpB9: std_logic_vector(8 downto 0);
signal overflow: std_logic:='0';
signal expA9, expB9: std_logic_vector(8 downto 0);
signal minusb9: std_logic_vector(8 downto 0);
signal diff9: std_logic_vector(8 downto 0);
signal mdiff9: std_logic_vector(8 downto 0);
signal bs: std_logic := '0';
signal d: std_logic_vector(7 downto 0);
begin
    expB9 <= '0' & expB;
    expA9 <= '0' & expA;
    negare: Opp2C port map(expB9,mexpB9);
    
    scadere: carryLookAheadAdder9Bits port map('0',expA9,mexpB9,diff9,overflow);
    aducereinBinar: Opp2C port map(diff9, mdiff9);
    bs <= diff9(8);
    cmpAB <= not diff9(8);
    expDiff(0) <= ((not bs) and diff9(0)) or (bs and mdiff9(0));
    expDiff(1) <= ((not bs) and diff9(1)) or (bs and mdiff9(1));
    expDiff(2) <= ((not bs) and diff9(2)) or (bs and mdiff9(2));
    expDiff(3) <= ((not bs) and diff9(3)) or (bs and mdiff9(3));
    expDiff(4) <= ((not bs) and diff9(4)) or (bs and mdiff9(4));
    expDiff(5) <= ((not bs) and diff9(5)) or (bs and mdiff9(5));
    expDiff(6) <= ((not bs) and diff9(6)) or (bs and mdiff9(6));
    expDiff(7) <= ((not bs) and diff9(7)) or (bs and mdiff9(7));
    --- cmpAB = 1 = True, A > B
    --- expDiff - valoarea A-B, in modul
    
    
end Behavioral;
