----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2023 11:14:54 AM
-- Design Name: 
-- Module Name: ShifterRight - Behavioral
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

entity ShifterRight is
  Port (dN: in std_logic;
        nrBits: in std_logic_vector(7 downto 0);
        inA: in std_logic_vector(22 downto 0);
        outA: out std_logic_vector(278 downto 0) );
end ShifterRight;

architecture Behavioral of ShifterRight is
component Shift1Bit is
  Port (en: in std_logic;
        Ain: in std_logic_vector(278 downto 0);
        Aout: out std_logic_vector(278 downto 0) );
end component;
component Shift2Bits is
  Port (en: in std_logic;
        Ain: in std_logic_vector(278 downto 0);
        Aout: out std_logic_vector(278 downto 0) );
end component;
component Shift4Bits is
  Port (en: in std_logic;
        Ain: in std_logic_vector(278 downto 0);
        Aout: out std_logic_vector(278 downto 0) );
end component;
component Shift8Bits is
  Port (en: in std_logic;
        Ain: in std_logic_vector(278 downto 0);
        Aout: out std_logic_vector(278 downto 0) );
end component;
component Shift16Bits is
  Port (en: in std_logic;
        Ain: in std_logic_vector(278 downto 0);
        Aout: out std_logic_vector(278 downto 0) );
end component;
component Shift32Bits is
  Port (en: in std_logic;
        Ain: in std_logic_vector(278 downto 0);
        Aout: out std_logic_vector(278 downto 0) );
end component;
component Shift64Bits is
  Port (en: in std_logic;
        Ain: in std_logic_vector(278 downto 0);
        Aout: out std_logic_vector(278 downto 0) );
end component;
component Shift128Bits is
  Port (en: in std_logic;
        Ain: in std_logic_vector(278 downto 0);
        Aout: out std_logic_vector(278 downto 0) );
end component;

signal rA: std_logic_vector(8 downto 0);
signal exp: std_logic_vector(2 downto 0);
signal outA0, outA1, outA2, outA3, outA4, outA5, outA6, outA7, outA8: std_logic_vector(278 downto 0);
signal zeroAux15: std_logic_vector(14 downto 0) :="000000000000000";
signal zeroAux60: std_logic_vector(59 downto 0) :="000000000000000000000000000000000000000000000000000000000000";

begin
    outA0 <= dN & inA & zeroAux60 & zeroAux60 & zeroAux60 & zeroAux60 & zeroAux15;
    s1: Shift1Bit port map(nrBits(0), outA0, outA1);
    s2: Shift2Bits port map(nrBits(1), outA1, outA2);
    s3: Shift4Bits port map(nrBits(2), outA2, outA3);
    s4: Shift8Bits port map(nrBits(3), outA3, outA4);
    s5: Shift16Bits port map(nrBits(4), outA4, outA5);
    s6: Shift32Bits port map(nrBits(5), outA5, outA6);
    s7: Shift64Bits port map(nrBits(6), outA6, outA7);
    s8: Shift128Bits port map(nrBits(7), outA7, outA8);
    outA <= outA8;
    

end Behavioral;
