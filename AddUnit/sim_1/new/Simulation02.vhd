----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/14/2024 01:05:26 PM
-- Design Name: 
-- Module Name: Simulation8 - Behavioral
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

entity Simulation02 is
--  Port ( );
end Simulation02;

architecture Behavioral of Simulation02 is
component ADDITION is
 Port (A: in std_logic_vector(31 downto 0);
       B: in std_logic_vector(31 downto 0);
       dNA, dNB: in std_logic;
       clk: in std_logic;
       en: in std_logic;
       REZ: out std_logic_vector(31 downto 0);
       done: out std_logic );
end component;

signal A,B,REZ: std_logic_vector(31 downto 0);
signal clk,en: std_logic:='1';
signal dNA,dNB: std_logic;
signal READY: std_logic;
begin
    A<="01000001011110100000000000000000", "01000001101010100000000000000000" after 49 ns;
    B<="01000001011110100000000000000000", "01000100011100010100000000000000" after 49 ns;
    dNA<='1';
    dNB<='1';
    
    en <= '1', '0' after 10 ns, '1' after 50 ns, '0' after 60 ns;
        process
            begin
                while now <= 2000 ns loop
                    wait for 1 ns;
                    clk <= not clk;
                end loop;
        end process;
--------------------------------------------
    compcomp: ADDITION port map( A => A,
                                 B => B,
                                 dNA => dNA,
                                 dNB => dNB,
                                 clk => clk,
                                 en => en,
                                 REZ => REZ,
                                 done => READY);
end Behavioral;
