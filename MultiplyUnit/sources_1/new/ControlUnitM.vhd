----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/30/2023 10:57:22 AM
-- Design Name: 
-- Module Name: ControlUnitM - Behavioral
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

entity ControlUnitM is
    Port ( en: in std_logic;
           clk: in std_logic;
           Q0 : in STD_LOGIC;
           Done: in STD_LOGIC;
           Add : out STD_LOGIC;
           Write : out STD_LOGIC;
           Shift : out STD_LOGIC);
end ControlUnitM;

architecture Behavioral of ControlUnitM is
signal a,w,s: std_logic:='0';


signal doublecheck: std_logic := '0';
type state is (Start, Finish, ShiftS, AddS, WriteS, WaitS);
signal current_state, next_state: state;
begin
    process(clk, en)
    begin
        if en = '1' then
            current_state <= Start;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;
    
    process(current_state, next_state, done, Q0)
    begin
        case current_state is
        when Start =>
                      if Q0 = '1' then next_state <= AddS;
                      else next_state <= ShiftS;
                      end if;
        when AddS => a <= '1'; s <= '0'; w <= '0';
                     next_state <= WriteS;
        when WriteS => a <= '0'; w <= '1'; s <= '0';
                       next_state <= ShiftS;
        when ShiftS => a <= '0'; w <= '0'; s <= '1';
                       next_state <= WaitS;
                       
        when WaitS => a <= '0'; w <= '0'; s <= '0';
                      if done = '1' then next_State <= Finish;
                      else next_state <= Start;
                      end if;
        when others  => a<='0'; w <='0';s<='0';
        end case;
    end process;
    Add <= a;
    Write <= w;
    Shift <= s;
end Behavioral;
