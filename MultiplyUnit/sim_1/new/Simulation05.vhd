----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/30/2023 06:00:57 PM
-- Design Name: 
-- Module Name: Simulation05 - Behavioral
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

entity Simulation05 is
--  Port ( );
end Simulation05;

architecture Behavioral of Simulation05 is
component Sumator24Bits is
  Port (
        en: in std_logic;
        A: in std_logic_vector(23 downto 0);
        B: in std_logic_vector(23 downto 0);
        carryIn: in std_logic;
        Rez: out std_logic_vector(23 downto 0);
        carryOut: out std_logic );
end component;

signal clk,c0: std_logic:='0';
signal A,B,Rez: std_logic_vector(23 downto 0);

begin
    process
    begin
        while now <= 1000 ns loop
            wait for 10 ns;
            clk <= not clk;
        end loop;
    end process;
    process(clk,c0)
    begin
        if rising_edge(clk) and c0 = '0' then
            c0 <= '1';
        end if;
    end process;
end Behavioral;
