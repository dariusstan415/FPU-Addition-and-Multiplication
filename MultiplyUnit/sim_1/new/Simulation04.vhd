----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/30/2023 03:33:00 PM
-- Design Name: 
-- Module Name: Simulation04 - Behavioral
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

entity Simulation04 is
--  Port ( );
end Simulation04;

architecture Behavioral of Simulation04 is

signal clk,dNA,dNB, done: std_logic:='0';
signal manA,manB: std_logic_vector(22 downto 0):="00000000000000000001100";
signal rez, rez2: std_logic_vector(47 downto 0);
signal start: std_logic;
signal exp2: std_logic_vector(7 downto 0);


component ControlUnitM is
    Port ( en: in std_logic;
           clk: in std_logic;
           Q0 : in STD_LOGIC;
           Done: in STD_LOGIC;
           Add : out STD_LOGIC;
           Write : out STD_LOGIC;
           Shift : out STD_LOGIC);
end component;
component Sumator24Bits is
  Port (en: in std_logic;
        A: in std_logic_vector(23 downto 0);
        B: in std_logic_vector(23 downto 0);
        carryIn: in std_logic;
        Rez: out std_logic_vector(23 downto 0);
        carryOut: out std_logic );
end component;

component Counter is
     Port (clk: in std_logic;
           en: in std_logic;
           rst: in std_logic;
           cnt: out std_logic_vector(4 downto 0);
           done: out std_logic
            );
end component;
-----------------------------------------------
signal M, extA, extB, prez, pprez: std_logic_vector(23 downto 0) := (others => '0');
signal A_Q, ppprez: std_logic_vector(47 downto 0) := (others => '0');
signal shift, add, write, d,cout, pcout: std_logic := '0';
signal notstart: std_logic := '1';
signal cnt: std_logic_vector(4 downto 0):="00000";


begin    
    manB <= "10001101000110000000000";
    manA <= "00011000001101000001000";
    dna <= '1';
    dnb <= '1';
    start<='1', '0' after 3 ns;
    process
        begin
            while now <= 1000 ns loop
                wait for 1 ns;
                clk <= not clk;
            end loop;
    end process;
-------------------------------------------------------------------------------------------------------------------------------------------------    

    extA <= ( dNA) & manA;
    extB <= ( dNB) & manB;
---------------------------------------------------------
    unitcontrol: ControlUnitM port map(en => start, clk => clk, Q0 => A_Q(0), Add => add, Write => write, Shift => shift, Done => d);
    sumator: Sumator24Bits port map(en => add, A=>A_Q(47 downto 24),B=>M, carryIn => '0', rez => prez, carryOut => cout);
    ccnntt: Counter port map(clk => clk, en => shift, rst => (start), cnt => cnt, done => d);
    process(start,shift,add,write,d, clk)
        begin
            if start = '1' and rising_edge(clk) then
                A_Q <= "000000000000000000000000"& extB;
                M <= extA;
            else
                if add = '1' then
                    pprez <= prez;
                    pcout <= cout;
                elsif write = '1' then
                    A_Q(47 downto 24) <= pprez;
                elsif shift = '1' then
                        ppprez <= pcout & A_Q(47 downto 1);
                else pcout <= '0';
                end if;
                    
                if rising_edge(clk) then
                    if shift = '1' then
                        A_Q <= ppprez;
                    end if;
                end if;
                
            end if;
            
                rez <= A_Q;
            
        end process;
        Done <= d;
  
end Behavioral;
