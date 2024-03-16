

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADDRounding is
  Port (en: in std_logic;
        sigIn: in std_logic_vector(279 downto 0);
        sigOut: out std_logic_vector(279 downto 0);
        done: out std_logic
        );
end ADDRounding;

architecture Behavioral of ADDRounding is
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
    c: Sumator24Bits port map(en => '1', A => sigIn(278 downto 255), B => (OTHERS => '0'), carryIn => sigIn(254),
                     Rez => SigOut(278 downto 255), carryOut => SigOut(279));
    SigOut(254 downto 0) <= (OTHERS => '0');
    done <= en and (not sigIn(254));
end Behavioral;
