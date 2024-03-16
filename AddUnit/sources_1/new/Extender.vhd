----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2023 11:52:24 PM
-- Design Name: 
-- Module Name: Extender - Behavioral
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

entity Extender is
  Port (dN: in std_logic;
        inA : in std_logic_vector(22 downto 0);
        outA : out std_logic_vector(278 downto 0));
end Extender;

architecture Behavioral of Extender is
signal zeroAux15: std_logic_vector(14 downto 0) :="000000000000000";
signal zeroAux60: std_logic_vector(59 downto 0) :="000000000000000000000000000000000000000000000000000000000000";

begin
    outA <= dN & inA & zeroAux60 & zeroAux60 & zeroAux60 & zeroAux60 & zeroAux15;
end Behavioral;
