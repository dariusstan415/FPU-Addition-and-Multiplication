----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 09:39:20 PM
-- Design Name: 
-- Module Name: EQCheck8Bits - Behavioral
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

entity EQCheck8Bits is
  Port (u : in std_logic_vector(7 downto 0);
        v: in std_logic_vector(7 downto 0);
        t: out std_logic );
end EQCheck8Bits;

architecture Behavioral of EQCheck8Bits is
signal aux : std_logic_vector(7 downto 0) := X"00";
signal rez : std_logic:='0';
begin
        aux(0) <= u(0) xor v(0);
        aux(1) <= u(1) xor v(1);
        aux(2) <= u(2) xor v(2);
        aux(3) <= u(3) xor v(3);
        aux(4) <= u(4) xor v(4);
        aux(5) <= u(5) xor v(5);
        aux(6) <= u(6) xor v(6);
        aux(7) <= u(7) xor v(7);
        rez <= aux(0) or aux(1) or aux(2) or aux(3) or aux(4) or aux(5) or aux(6) or aux(7);
        t <= not rez;
   
        

end Behavioral;
