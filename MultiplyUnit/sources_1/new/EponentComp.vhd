
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ExonentComp is
  Port (expA: in std_logic_vector(7 downto 0);
        expB: in std_logic_vector(7 downto 0);
        rez: out std_logic_vector(7 downto 0);
        overflow: out std_logic;
        underflow: out std_logic );
end ExonentComp;

architecture Behavioral of ExonentComp is
signal extA, extB, extRez1, extRez2: std_logic_vector(8 downto 0);
signal bias: std_logic_vector(8 downto 0):= "110000001";
--------------------------------------------------------
signal carryout1, carryout2: std_logic;
--------------------------------------------------------
component CarryLookAheadAdder9bits is
  Port (CarryIn: in std_logic;
        A: in std_logic_vector(8 downto 0);
        B: in std_logic_vector(8 downto 0);
        Rez: out std_logic_vector(8 downto 0);
        CarryOut: out std_logic );
end component;
--------------------------------------------------------
begin
    extA <= "0" & expA;
    extB <= "0" & expB;
------------------------------------------------------------------------------------------------------------------------------------------------------
    Aminnus127: CarryLookAheadAdder9bits port map('0',extA, bias,extRez1,carryOut1);
    plusB: CarryLookAheadAdder9bits port map('0',extB, extRez1,extRez2, carryOut2);
------------------------------------------------------------------------------------------------------------------------------------------------------
    overflow <= ((extRez2(8)) and (not extRez1(8))) or ((not extRez2(8)) and
                  extRez2(7) and extRez2(6) and extRez2(5) and extRez2(4) and extRez2(3) and extRez2(2) and extRez2(1) and extRez2(0));
    underflow <= (extRez2(8) and extRez1(8));
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    rez <= extRez2(7 downto 0);
end Behavioral;
