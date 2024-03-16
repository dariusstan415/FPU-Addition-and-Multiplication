----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2023 06:49:44 PM
-- Design Name: 
-- Module Name: CLA9bitsSim - Behavioral
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

entity CLA9bitsSim is
--  Port ( );
end CLA9bitsSim;

architecture Behavioral of CLA9bitsSim is


component ShiftRightComp is
  Port (nr: in std_logic_vector(7 downto 0);
        input: in std_logic_vector(22 downto 0);
        outer: out std_logic_vector(7 downto 0)
         );
end component;
component CarryLookAheadAdder9bits is
  Port (CarryIn: in std_logic;
        A: in std_logic_vector(8 downto 0);
        B: in std_logic_vector(8 downto 0);
        Rez: out std_logic_vector(8 downto 0);
        CarryOut: out std_logic );
end component;

component Opp2C is
  Port (A: in std_logic_vector(8 downto 0);
        minusA: out std_logic_vector(8 downto 0) );
end component;

component SmallALU is
  Port (expA: in std_logic_vector(7 downto 0);
        expB: in std_logic_vector(7 downto 0);
        expDiff: out std_logic_vector(7 downto 0);
        cmpAB: out std_logic  );
end component;
--signal n1,n2,sum: std_logic_vector(8 downto 0);
--signal cin,cout: std_logic;

--signal nr1,nr2: std_logic_vector(8 downto 0);
--signal cmp: std_logic;
--signal outout: std_logic_vector(15 downto 0);

component Shift1Bit is
  Port (en: in std_logic;
        Ain: in std_logic_vector(8 downto 0);
        Aout: out std_logic_vector(8 downto 0) );
end component;

component ShifterRight is
  Port (nrBits: in std_logic_vector(7 downto 0);
        inA: in std_logic_vector(22 downto 0);
        outA: out std_logic_vector(278 downto 0) );
end component;

signal number_of_bits: std_logic_vector(7 downto 0);
signal input: std_logic_vector(22 downto 0);
signal output: std_logic_vector(278 downto 0);
begin
    --ccc: CarryLookaheadAdder9Bits port map('0',n1,n2,sum,cout);
    --n1 <= "000000111", "010000111" after 15 ns;
    --n2 <= "000001001", "110000101" after 15 ns;
    --c: Opp2C port map(nr, n2m);
    --nr<= "000001100", "010001100" after 15 ns;
    --cc: SmallALU port map("10000011","01111110",nr, cmp);
    --cccc: ShiftRightComp port map(nr1,"00000000000000000000000",nr2);
    --nr1<="11000001";
    --xx: ShifterRight port map("10111111", outout);
    --zzz: Shift1Bit port map('1',"110110000",nr1);
    XYZ: ShifterRight port map(number_of_bits, input, output);
    number_of_bits<="11111111";
    input<="00000000110111101111000";-- 00000100000000110111101100000000000000000000000
    
end Behavioral;
