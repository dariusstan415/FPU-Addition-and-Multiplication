library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sumator24Bits is
  Port (
        en: in std_logic;
        A: in std_logic_vector(23 downto 0);
        B: in std_logic_vector(23 downto 0);
        carryIn: in std_logic;
        Rez: out std_logic_vector(23 downto 0);
        carryOut: out std_logic );
end Sumator24Bits;

architecture Behavioral of Sumator24Bits is
signal carry1, carry2, carry3, carry4, carry5, carry6: std_logic :='0';
signal sum1, sum2, sum3, sum4, sum5, sum6: std_logic_vector(3 downto 0);

component carryLookaheadAdder is
  Port (cin : in std_logic;
        x : in std_logic_vector(3 downto 0);
        y : in std_logic_vector(3 downto 0);
        sum : out std_logic_vector(3 downto 0);
        cout : out std_logic );
end component;
begin
    add1: carryLookAheadAdder port map( cin => carryIn,
                                        x => A (3 downto 0),
                                        y => B (3 downto 0),
                                        sum => sum1,
                                        cout => carry1);
    add2: carryLookAheadAdder port map( cin => carry1,
                                        x => A(7 downto 4),
                                        y => B(7 downto 4),
                                        sum => sum2,
                                        cout => carry2);
    add3: carryLookAheadAdder port map( cin => carry2,
                                        x => A(11 downto 8),
                                        y => B(11 downto 8),
                                        sum => sum3,
                                        cout => carry3);
    add4: carryLookAheadAdder port map( cin => carry3,
                                        x => A(15 downto 12),
                                        y => B(15 downto 12),
                                        sum => sum4,
                                        cout => carry4);
    add5: carryLookAheadAdder port map( cin => carry4,
                                        x => A(19 downto 16),
                                        y => B(19 downto 16),
                                        sum => sum5,
                                        cout => carry5);
    add6: carryLookAheadAdder port map( cin => carry5,
                                        x => A(23 downto 20),
                                        y => B(23 downto 20),
                                        sum => sum6,
                                        cout => carry6);
   
   carryOut <=(carry6 and en);
   gen_for_loop: for i in 0 to 3 generate
            Rez(i) <= (A(i) and (not en)) or (sum1(i) and en);
   end generate;
   gen_for_loop1: for i in 4 to 7 generate
            Rez(i) <= (A(i) and (not en)) or (sum2(i-4) and en);
   end generate;
   gen_for_loop2: for i in 8 to 11 generate
            Rez(i) <= (A(i) and (not en)) or (sum3(i-8) and en);
   end generate;
   gen_for_loop3: for i in 12 to 15 generate
            Rez(i) <= (A(i) and (not en)) or (sum4(i-12) and en);
   end generate;
   gen_for_loop4: for i in 16 to 19 generate
            Rez(i) <= (A(i) and (not en)) or (sum5(i-16) and en);
   end generate;
   gen_for_loop5: for i in 20 to 23 generate
            Rez(i) <= (A(i) and (not en)) or (sum6(i-20) and en);
   end generate;

end Behavioral;
