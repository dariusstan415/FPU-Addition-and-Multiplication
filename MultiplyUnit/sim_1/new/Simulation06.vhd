
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Simulation06 is
--  Port ( );
end Simulation06;

architecture Behavioral of Simulation06 is
component Multiplier is
    Port ( clk: in std_logic;
           start: in std_logic;
           manA, manB: in std_logic_vector(22 downto 0);
           dNA, dNB: in std_logic;
           rez: out std_logic_vector(47 downto 0);
           done: out std_logic
          );
end component;
component ExonentComp is
  Port (expA: in std_logic_vector(7 downto 0);
        expB: in std_logic_vector(7 downto 0);
        rez: out std_logic_vector(7 downto 0);
        overflow: out std_logic;
        underflow: out std_logic );
end component;
component Normaliser is
  Port (
        sigIn: in std_logic_vector(47 downto 0);
        expIn: in std_logic_vector(7 downto 0);
        sigOut: out std_logic_vector(47 downto 0);
        expOut: out std_logic_vector(7 downto 0);
        doneN, dnor, doneDN: out std_logic
        );
end component;
component Rounding is
  Port (sigIn: in std_logic_vector(47 downto 0);
        sigOut: out std_logic_vector(47 downto 0);
        done: out std_logic
        );
end component;
component FlowUnit is
  Port (expIn: in std_logic_vector(7 downto 0);
        overflowIn: in std_logic;
        underflowIn: in std_logic;
        expOut: out std_logic_vector(7 downto 0);
        overflowOut: out std_logic;
        underflowOut: out std_logic
         );
end component;
component ControlUnit is
  Port (clk: in std_logic;
        en: in std_logic;
        underflow: in std_logic;
        overflow: in std_logic;
        doneM: in std_logic;
        doneN: in std_logic;
        doneDN: in std_logic;
        dNor: in std_logic;
        doneR: in std_logic;
        start: out std_logic;
        expMux: out std_logic;
        manMux: out std_logic_vector(1 downto 0);
        enableW: out std_logic_vector(1 downto 0);
        stateX: out std_logic_vector(3 downto 0)
        );
end component;
---------------------------------------------------------------------------------------------
signal A,B: std_Logic_vector(31 downto 0);
signal doneM: std_logic;
signal dna, dnb: std_logic;
signal rez1: std_logic_vector(47 downto 0);
signal clk: std_logic := '1';
signal start: std_logic;
----------------------------------------------------------------------------------------------
signal manA, manB: std_logic_vector(22 downto 0);
signal  en: std_logic;

begin
    A <= "00000000011101101000010010000000";--17.5
    B <= "00000000001111100010000000000000";--20.625
    dNA <= '1';
    dNB <= '1';
    manA <= A(22 downto 0);
    manB <= B(22 downto 0);
    en <= '1', '0' after 10 ns;
    process
        begin
            while now <= 1000 ns loop
                wait for 2 ns;
                clk <= not clk;
            end loop;
    end process;
---------------------------------------------------------------------------------------------
    
----------------------------------------------------------------------------------------------
    multipy_the_significants: Multiplier port map( clk => clk,
                                                   start => en,
                                                   manA => manA,
                                                   manB => manB,
                                                   dNA => dna,
                                                   dNB => dnb,                                     
                                                   rez => rez1,
                                                   done => doneM );
    
   
end Behavioral;
