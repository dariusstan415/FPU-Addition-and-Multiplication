----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2023 02:06:27 PM
-- Design Name: 
-- Module Name: Shift8Bits - Behavioral
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

entity Shift8Bits is
  Port (en: in std_logic;
        Ain: in std_logic_vector(278 downto 0);
        Aout: out std_logic_vector(278 downto 0) );
end Shift8Bits;

architecture Behavioral of Shift8Bits is

begin
    gen_for_loop: for i in 0 to 270 generate
        Aout(i) <= (Ain(i) and (not en)) or (Ain(i+8) and en);
    end generate;
    Aout(271) <= (not en) and Ain(271);
    Aout(272) <= (not en) and Ain(272);
    Aout(273) <= (not en) and Ain(273);
    Aout(274) <= (not en) and Ain(274);
    Aout(275) <= (not en) and Ain(275);
    Aout(276) <= (not en) and Ain(276);
    Aout(277) <= (not en) and Ain(277);
    Aout(278) <= (not en) and Ain(278);
end Behavioral;
