----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2023 02:07:17 PM
-- Design Name: 
-- Module Name: Shift16Bits - Behavioral
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

entity Shift16Bits is
  Port (en: in std_logic;
        Ain: in std_logic_vector(278 downto 0);
        Aout: out std_logic_vector(278 downto 0) );
end Shift16Bits;

architecture Behavioral of Shift16Bits is

begin
    gen_for_loop: for i in 0 to 262 generate
        Aout(i) <= (Ain(i) and (not en)) or (Ain(i+16) and en);
    end generate;
    gen2_for_loop: for j in 263 to 278 generate
        Aout(j) <= Ain(j) and (not en);
    end generate;
end Behavioral;
