

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADDFlowUnit is
  Port (expIn: in std_logic_vector(7 downto 0);
        expOut: out std_logic_vector(7 downto 0);
        overflowOut: out std_logic
         );
end ADDFlowUnit;

architecture Behavioral of ADDFlowUnit is

begin
    
    overflowOut <= (expIn(7) and expIn(6) and expIn(5) and expIn(4) and expIn(3) and expIn(2) and expIn(1) and expIn(0));
    expOut <= expIn;
end Behavioral;
