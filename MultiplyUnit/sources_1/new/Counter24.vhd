----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/30/2023 11:59:42 AM
-- Design Name: 
-- Module Name: Counter - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
     Port (clk: in std_logic;
           en: in std_logic;
           rst: in std_logic;
           cnt: out std_logic_vector(4 downto 0);
           done: out std_logic
            );
end Counter;

architecture Behavioral of Counter is

signal counter_reg : std_logic_vector (4 downto 0) := "00000";
begin
    process(clk, rst)
    begin
        if rst = '1' then
            counter_reg <= "00000";
        elsif (clk'event and clk = '1' and en = '1') then
            if counter_reg = "11000" then
                counter_reg <= "00000";
            else
                counter_reg <= counter_reg + 1;
            end if;
        end if;
   end process;
   cnt<=counter_reg;
   done <= counter_reg(4) and counter_reg(3) and (not counter_reg(2)) and (not counter_reg(1)) and (not counter_reg(0));

   end Behavioral;
