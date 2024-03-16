

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Rounding is
  Port (en: in std_logic;
        sigIn: in std_logic_vector(47 downto 0);
        sigOut: out std_logic_vector(47 downto 0);
        done: out std_logic
        );
end Rounding;

architecture Behavioral of Rounding is
component Sumator24Bits is
  Port (
        en: in std_logic;
        A: in std_logic_vector(23 downto 0);
        B: in std_logic_vector(23 downto 0);
        carryIn: in std_logic;
        Rez: out std_logic_vector(23 downto 0);
        carryOut: out std_logic );
end component;

begin
    c: Sumator24Bits port map(en => '1', A => sigIn(46 downto 23), B => (OTHERS => '0'), carryIn => sigIn(22),
                     Rez => SigOut(46 downto 23), carryOut => SigOut(47));
    SigOut(22 downto 0) <= (OTHERS => '0');
    done <= en and (not sigIn(22));
end Behavioral;
