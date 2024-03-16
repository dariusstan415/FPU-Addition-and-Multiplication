----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/11/2023 12:07:53 AM
-- Design Name: 
-- Module Name: BigALU - Behavioral
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

entity BigALU is
  Port (manA: in std_logic_vector(278 downto 0);
        manB: in std_logic_vector(278 downto 0);
        signA, signB: in std_logic;
        manRez: out std_logic_vector(278 downto 0);
        carryOut: out std_logic);
end BigALU;

architecture Behavioral of BigALU is
component CarryLookAheadAdder93Bits is
    Port (CarryIn: in std_logic;
        A: in std_logic_vector(92 downto 0);
        B: in std_logic_vector(92 downto 0);
        Rez: out std_logic_vector(92 downto 0);
        CarryOut: out std_logic );
end component;
component Opp2CBig is
  Port (A: in std_logic_vector(279 downto 0);
        minusA: out std_logic_vector(279 downto 0) );
end component;

signal manAext, manBext: std_logic_vector(279 downto 0);
signal minusmanAext, minusmanBext: std_logic_vector(279 downto 0);
signal Aext, Bext: std_logic_vector(279 downto 0):=X"0000000000000000000000000000000000000000000000000000000000000000000000";
signal partial1, partial2, partial3: std_logic_vector(92 downto 0);
signal cout1, cout2, cout3: std_logic;
signal helperA, helperB: std_logic_vector(92 downto 0);
signal leftbit: std_logic:='0';
signal GivenResult, OppGivenResult: std_logic_vector(279 downto 0);
begin
    manAext <= "0" & manA;
    manBext <= "0" & manB;
    n1: Opp2CBig port map(manAext, minusmanAext);
    n2: Opp2CBig port map(manBext, minusmanBext);
    ----------------------------------------------------------------------------------------------
    
    gen_for_loop: for i in 0 to 279 generate
            Bext(i) <= ((not signB) and manBext(i))or (signB and minusmanBext(i));
            Aext(i) <= ((not signA) and manAext(i))or (signA and minusmanAext(i));
    end generate;
    ----------------------------------------------------------------------------------------------
    c1: CarryLookAheadAdder93bits port map('0',Aext(92 downto 0),Bext(92 downto 0),partial1,cout1);
    c2: CarryLookAheadAdder93bits port map(cout1,Aext(185 downto 93),Bext(185 downto 93),partial2,cout2);
    c3: CarryLookAheadAdder93bits port map(cout2,Aext(278 downto 186),Bext(278 downto 186),partial3,cout3);
    leftbit <= Aext(279) xor Bext(279) xor cout3;
    -- asta e ultimul bit care basically e suma dintre ultimii biti ai lui a si b si carry ul trecut.
    --dat fiind ca lucram in comp fara de 2 pe 279 de nr, nu avem cazul de overflow.
    --daca rez e negativ, aflat pozitivul:)
    GivenResult <= leftbit & partial3 & partial2 & partial1; -- aici am suma in comp. fata de 2
    n3: Opp2CBig port map(GivenResult, OppGivenResult); -- opusul lui given result
    CarryOut <= ((not signA) and (not signB) and leftbit) or
                (signA and signB and (not leftbit));
    
    gen_for_loop2: for i in 0 to 278 generate
        manRez(i) <= ((not signA) and (not signB) and GivenResult(i)) or
                     ((signA) and (signB) and OppGivenResult(i)) or
                     ((signA xor signB) and (not leftbit) and GivenResult(i)) or
                     ((signA xor signB) and leftbit and OppGivenResult(i));
    end generate;
    
end Behavioral;
