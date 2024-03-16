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

entity Simulation8 is
--  Port ( );
end Simulation8;

architecture Behavioral of Simulation8 is
component MultiplicationComponent is
  Port (A: in std_logic_vector(31 downto 0);
        B: in std_logic_vector(31 downto 0);
        dNA: in std_logic;
        dNB: in std_logic;
        clk: in std_logic;
        en: in std_logic;
        REZ: out std_logic_vector(31 downto 0);
        done: out std_logic
         );
end component;
signal A,B,REZ: std_logic_vector(31 downto 0);
signal clk,en: std_logic:='1';
signal dNA,dNB: std_logic;
signal READY: std_logic;
begin
    A<="11000100011101101010000011110000", "00111110110101000000010011101010" after 300 ns;
    B<="01000100010111011111111111111000", "01000100101111010000001111100000" after 300 ns;
    dNA<='1';
    dNB<='1';
    
    en <= '1', '0' after 10 ns, '1' after 300 ns, '0' after 310 ns;
        process
            begin
                while now <= 2000 ns loop
                    wait for 1 ns;
                    clk <= not clk;
                end loop;
        end process;
--------------------------------------------
    compcomp: MultiplicationComponent port map( A => A,
                                                B => B,
                                                dNA => dNA,
                                                dNB => dNB,
                                                clk => clk,
                                                en => en,
                                                REZ => REZ,
                                                done => READY);
end Behavioral;
