----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/03/2024 04:45:28 PM
-- Design Name: 
-- Module Name: FlowUnit - Behavioral
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

entity FlowUnit is
  Port (expIn: in std_logic_vector(7 downto 0);
        overflowIn: in std_logic;
        underflowIn: in std_logic;
        expOut: out std_logic_vector(7 downto 0);
        overflowOut: out std_logic;
        underflowOut: out std_logic
         );
end FlowUnit;

architecture Behavioral of FlowUnit is

begin
    underflowOut <= underflowIn;
    overflowOut <= overflowIn or (expIn(7) and expIn(6) and expIn(5) and expIn(4) and expIn(3) and expIn(2) and expIn(1) and expIn(0));
    expOut <= expIn;
end Behavioral;
