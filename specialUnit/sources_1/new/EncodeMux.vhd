----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 11:56:42 PM
-- Design Name: 
-- Module Name: EncodeMux - Behavioral
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

entity EncodeMux is
  Port (code: in std_logic_vector(4 downto 0);
        val: out std_logic_vector(31 downto 0);
        en: out std_logic );
end EncodeMux;

architecture Behavioral of EncodeMux is

begin
    process(code)
    begin
        case code is
        when "00000" => en <= '1';
        when "10000" => val <="00000000000000000000000000000000"; en <= '0';
        when "01000" => val <="01111111100000000000000000000000"; en <= '0';
        when "00100" => val <="11111111100000000000000000000000"; en <= '0';
        when "00010" => en <= '1';
        when "00000" => val <="11111111100000000000001110000000"; en <= '0';
        end case;
    end process;

end Behavioral;
