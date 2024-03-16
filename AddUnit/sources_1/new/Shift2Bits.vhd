----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2023 01:53:49 PM
-- Design Name: 
-- Module Name: Shift2Bits - Behavioral
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

entity Shift2Bits is
  Port (en: in std_logic;
        Ain: in std_logic_vector(278 downto 0);
        Aout: out std_logic_vector(278 downto 0) );
end Shift2Bits;

architecture Behavioral of Shift2Bits is

begin
    gen_for_loop: for i in 0 to 276 generate
        Aout(i) <= (Ain(i) and (not en)) or (Ain(i+2) and en);
    end generate;
    Aout(277) <= (not en) and Ain(277);
    Aout(278) <= (not en) and Ain(278);
end Behavioral;

