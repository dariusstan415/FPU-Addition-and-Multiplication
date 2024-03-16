----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 11:02:22 PM
-- Design Name: 
-- Module Name: SpecialValSingular - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SpecialValSingular is
  Port (A : in std_logic_vector(31 downto 0);
        code : out std_logic_vector(4 downto 0) );
end SpecialValSingular;

architecture Behavioral of SpecialValSingular is
component EQCheck32Bits is
  Port (u : in std_logic_vector(31 downto 0);
        v: in std_logic_vector(31 downto 0);
        t: out std_logic );
end component;

component EQCheck8Bits is
  Port (u : in std_logic_vector(7 downto 0);
        v: in std_logic_vector(7 downto 0);
        t: out std_logic );
end component;

signal pinf, minf, pzero, mzero, zero, nanex, nanman, nan, dnorex, dnorman, dnor : std_logic := '0';
signal AuxA : std_logic_vector(31 downto 0);
signal codeAuxzero,codeAuxpinf,codeAuxminf,codeAuxdnor,codeAuxnan: std_logic_vector(2 downto 0) := "000";
begin
    c1: EQCheck32Bits port map (A,"00000000000000000000000000000000",pzero); -- +0
    c2: EQCheck32Bits port map (A,"10000000000000000000000000000000",mzero); -- -0
    zero <= mzero or pzero;
    
    c3: EQCheck32Bits port map (A,"01111111100000000000000000000000",pinf); -- +inf
    c4: EQCheck32Bits port map (A,"11111111100000000000000000000000",minf); -- -inf
    
    c5: EQCheck8Bits port map (A(30 downto 23), "00000000", dnorex); --denormalised exp
    AuxA <= A(22 downto 0) & "000000000";
    c6: EQCheck32Bits port map (AuxA, "00000000000000000000000000000000",dnorman); --denormalized mantinsa
    dnor <= dnorex and (not dnorman);
    
    c7: EQCheck8Bits port map (A(30 downto 23), "11111111", nanex); --nan exp
    
    c8: EQCheck32Bits port map (AuxA, "00000000000000000000000000000000",nanman); --nan mantissa
    nan <= nanex and (not nanman);
    
    code <= zero & pinf & minf & dnor & nan;
  
    
    
    
    
    
    
     
    
    
    

end Behavioral;