----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2023 06:28:06 PM
-- Design Name: 
-- Module Name: carryLookaheadAdder - Behavioral
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

entity CarryBlock is
  Generic (data_width: integer := 4);
  Port (c0 : in std_logic;
        x : in std_logic_vector(data_width-1 downto 0);
        y : in std_logic_vector(data_width-1 downto 0);
        c : out std_logic );
end CarryBlock;

architecture Behavioral of CarryBlock is
signal d_width : integer := data_width;
begin
   
    process(d_width, c0, x, y)
    begin
        case d_width is
            when 1 =>
                c <= (x(0) and y(0)) or ((x(0)or y(0))and c0);
            when 2 =>
                c <= (x(1) and y(1)) or ((x(1)or y(1))and ((x(0) and y(0)) or ((x(0)or y(0))and c0)));
            when 3 =>
                c <= (x(2) and y(2)) or ((x(2)or y(2))and ((x(1) and y(1)) or ((x(1)or y(1))and ((x(0) and y(0)) or ((x(0)or y(0))and c0)))));
            when others =>
                c <= (x(3) and y(3)) or ((x(3)or y(3))and ((x(2) and y(2)) or ((x(2)or y(2))and ((x(1) and y(1)) or ((x(1)or y(1))and ((x(0) and y(0)) or ((x(0)or y(0))and c0)))))));
        end case;
    end process;


end Behavioral;
