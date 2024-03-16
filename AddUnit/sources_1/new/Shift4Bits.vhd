


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shift4Bits is
  Port (en: in std_logic;
        Ain: in std_logic_vector(278 downto 0);
        Aout: out std_logic_vector(278 downto 0) );
end Shift4Bits;

architecture Behavioral of Shift4Bits is

begin
    gen_for_loop: for i in 0 to 274 generate
        Aout(i) <= (Ain(i) and (not en)) or (Ain(i+4) and en);
    end generate;
    Aout(275) <= (not en) and Ain(275);
    Aout(276) <= (not en) and Ain(276);
    Aout(277) <= (not en) and Ain(277);
    Aout(278) <= (not en) and Ain(278);
end Behavioral;