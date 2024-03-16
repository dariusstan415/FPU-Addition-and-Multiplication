
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADDControlUnit is
  Port (clk: in std_logic;
        en: in std_logic;
        overflow: in std_logic;
        doneN: in std_logic;
        doneDN: in std_logic;
        dNor: in std_logic;
        doneR: in std_logic;
        expMux: out std_logic;
        manMux: out std_logic_vector(1 downto 0);
        enableW: out std_logic_vector(1 downto 0);
        stateX: out std_logic_vector(3 downto 0);
        done: out std_logic
        );
end ADDControlUnit;

architecture Behavioral of ADDControlUnit is
type State is (nonState, State1, State2, State3, State4, FinalState1, FinalState4, FinalState3);
signal current_state, next_state: State;
begin
    process(clk, en)
    begin
        if en = '1' then
            current_state <= State1;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;
    
    process(current_state, next_state, doneR, dNor, doneN, overflow)
    begin
        case current_state is
        when State1 => expMux <= '0';
                       manMux <= "00";
                       next_state <= State2;
                       stateX <= "0001";
                       done <= '0';
                       
        when State2 => if overflow = '1' then next_state <= FinalState1;
                       elsif doneDN = '1' then next_state <= FinalState3;
                       elsif dNor = '1' then next_state <= State3;
                       elsif dNor = '0' and doneR = '1' then next_state <= FinalState4;
                       elsif dNor = '0' and doneR = '0' then next_state <= State4;
                       end if;
                       stateX <= "0010";
                       done <= '0';
                       
        when State3 => expMux <= '1';
                       manMux <= "01";
                       next_state <= State2;
                       stateX <= "0011";
                       done <= '0';
                       
        when State4 => expMux <= '1';
                       manMux <= "10";
                       stateX <= "0100";
                       done <= '0';
                       next_state <= State2;
                       
        when FinalState1 => enableW <= "00"; done <= '1'; stateX <= "1001";
        when FinalState3 => enableW <= "10"; done <= '1'; stateX <= "1011";
        when FinalState4 => enableW <= "11"; done <= '1'; stateX <= "1100";
        when others => next_state <= nonState; done <= '0';
        end case;
    end process;
end Behavioral;
