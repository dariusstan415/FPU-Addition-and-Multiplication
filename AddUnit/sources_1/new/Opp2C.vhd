
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Opp2C is
  Port (
        A: in std_logic_vector(8 downto 0);
        minusA: out std_logic_vector(8 downto 0) );
end Opp2C;

architecture Behavioral of Opp2C is
component CarryLookAheadAdder9bits is
  Port (CarryIn: in std_logic;
        A: in std_logic_vector(8 downto 0);
        B: in std_logic_vector(8 downto 0);
        Rez: out std_logic_vector(8 downto 0);
        CarryOut: out std_logic );
end component;

component carryLookaheadAdder is
  Port (cin : in std_logic;
        x : in std_logic_vector(3 downto 0);
        y : in std_logic_vector(3 downto 0);
        sum : out std_logic_vector(3 downto 0);
        cout : out std_logic );
end component;
signal minusAAux: std_logic_vector(8 downto 0);
signal c: std_logic;
begin
    minusAAux(0) <= not A(0);
    minusAAux(1) <= not A(1);
    minusAAux(2) <= not A(2);
    minusAAux(3) <= not A(3);
    minusAAux(4) <= not A(4);
    minusAAux(5) <= not A(5);
    minusAAux(6) <= not A(6);
    minusAAux(7) <= not A(7);
    minusAAux(8) <= not A(8);
    add1: CarryLookAheadAdder9bits port map('0', minusAAux,"000000001",minusA,c);
    
end Behavioral;
