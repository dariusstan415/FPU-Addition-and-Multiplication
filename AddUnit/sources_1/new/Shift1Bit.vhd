
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Shift1Bit is
  Port (en: in std_logic;
        Ain: in std_logic_vector(278 downto 0);
        Aout: out std_logic_vector(278 downto 0) );
end Shift1Bit;

architecture Behavioral of Shift1Bit is

begin
    gen_for_loop: for i in 0 to 277 generate
        Aout(i) <= (Ain(i) and (not en)) or (Ain(i+1) and en);
    end generate;
    Aout(278) <= Ain(278) and (not en);
    
end Behavioral;
