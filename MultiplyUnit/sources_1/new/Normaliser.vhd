

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Normaliser is
  Port (
        sigIn: in std_logic_vector(47 downto 0);
        expIn: in std_logic_vector(7 downto 0);
        sigOut: out std_logic_vector(47 downto 0);
        expOut: out std_logic_vector(7 downto 0);
        doneN, dnor, doneDN: out std_logic
        );
end Normaliser;

architecture Behavioral of Normaliser is
component CarryLookAheadAdder9bits is
  Port (CarryIn: in std_logic;
        A: in std_logic_vector(8 downto 0);
        B: in std_logic_vector(8 downto 0);
        Rez: out std_logic_vector(8 downto 0);
        CarryOut: out std_logic );
end component;

signal c1,c3,c4, zero: std_logic:='0';
signal plus, minus, expIno: std_logic_vector(8 downto 0);

signal pluscout1, minuscout1: std_logic;
signal expZero, expUnu: std_logic_vector(7 downto 0);
signal sigZero, shiftedRight, shiftedLeft, sigUnu: std_logic_vector(47 downto 0);
begin


expIno <= '0' & expIn;
    add1: carryLookaheadAdder9bits port map(CarryIn => '0',A => "000000001", B => expIno, Rez => plus, CarryOut => pluscout1);
    add2: carryLookaheadAdder9bits port map(CarryIn => '0',A => "111111111", B => expIno, Rez => minus, CarryOut => minuscout1);
    zero <= (not expIn(7)) and (not expIn(6)) and (expIn(5)) and (not expIn(4)) and (not expIn(3)) and (not expIn(2)) and (not expIn(0)) and (not expIn(1));
    c1 <= (not sigIn(47)) and sigIn(46);
    c3 <= (sigIn(47));
    c4 <= (not sigIn(47)) and (not sigIn(46));
    
    shiftedLeft <= sigIn(46 downto 0) & '0';
    shiftedRight <= '0' & sigIn(47 downto 1);
    sigZero <= "010000000000000000000000000000000000000000000000";
    sigUnu <=  "000000000000000000000000000000000000000000000000";
    
    expZero <= "00000000";
    expUnu <=  "00000001";
    generate_loop: for i in 0 to 47 generate 
        sigOut(i) <= (c3 and shiftedRight(i)) or
                     (c4 and zero and sigIn(i)) or
                     (c4 and (not zero) and shiftedleft(i)) or
                     (c1 and (not zero) and sigIn(i)) or
                     (c1 and zero and sigIn(45) and sigZero(i)) or
                     (c1 and zero and (not sigIn(45)) and sigUnu(i));
    end generate generate_loop;
    
    generate_loop2: for i in 0 to 7 generate
        expOut(i) <= (c3 and plus(i)) or
                     (c4 and zero and expIn(i)) or
                     (c4 and (not zero) and minus(i)) or
                     (c1 and (not zero) and expIn(i)) or
                     (c1 and zero and sigIn(45) and expUnu(i)) or
                     (c1 and zero and (not sigIn(45)) and expZero(i));
    end generate generate_loop2;
    
    doneN <= c3 or (c1 and zero and sigIn(45)) or (c1 and (not zero));
    dNor <= c4 or (c1 and zero and (not sigIn(45)));
    doneDn <= (c1 and zero and (not sigIn(45))) or (c4 and zero);
end Behavioral;
