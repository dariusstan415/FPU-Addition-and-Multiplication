
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Multiplier is
    Port ( clk: in std_logic;
           start: in std_logic;
           manA, manB: in std_logic_vector(22 downto 0);
           dNA, dNB: in std_logic;
           rez: out std_logic_vector(47 downto 0);
           done: out std_logic
          );
end Multiplier;

architecture Behavioral of Multiplier is

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
signal A_Q, ppprez: std_logic_vector(47 downto 0) := (others => '1');
signal shift, add, write, d,cout, pcout: std_logic := '0';
signal notstart: std_logic := '1';
signal cnt: std_logic_vector(4 downto 0):="00000";
begin
    extA <= ( dNA) & manA;
    extB <= ( dNB) & manB;
---------------------------------------------------------
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
