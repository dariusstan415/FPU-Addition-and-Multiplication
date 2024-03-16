
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
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
        stateX: out std_logic_vector(3 downto 0);
        done: out std_logic
        );
end ControlUnit;

architecture Behavioral of ControlUnit is
type State is (nonState, State1, State2, State3, State4, State5, State6, FinalState1, FinalState2, FinalState3, FinalState4);
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
    
    process(current_state, next_state, doneM, doneR, dNor, doneN, overflow, underflow)
    begin
        case current_state is
        when State1 => start <= '1';
                       next_state <= State2;
                       stateX <= "0001";
                       done <= '0';
                       
        when State2 => start <= '0';
                       case doneM is
                           when '0' => next_state <= State2;
                           when '1' => next_state <= State3;
                           when others => next_state <= State3;
                       end case;
                       stateX <= "0010";
                       done <= '0';
                       
        when State3 => expMux <= '0';
                       manMux <= "00";
                       next_state <= State4;
                       stateX <= "0011";
                       done <= '0';
                       
        when State4 => if overflow = '1' then next_state <= FinalState1;
                       elsif underflow = '1' then next_state <= FinalState2;
                       elsif doneDN = '1' then next_state <= FinalState3;
                       elsif dNor = '1' then next_state <= State5;
                       elsif dNor = '0' and doneR = '1' then next_state <= FinalState4;
                       else next_state <= State6;
                       end if;
                       stateX <= "0100";
                       done <= '0';
                       
        when State5 => manMux <= "01";
                       expMux <= '1';
                       next_state <= State4;
                       stateX <= "0101";
                       done <= '0';
                       
        when State6 => manMux <= "10";
                       expMux <= '1';
                       next_state <= State4;
                       stateX <= "0110";
                       done <= '0';
        when FinalState1 => enableW <= "00"; done <= '1'; stateX <= "1001";
        when FinalState2 => enableW <= "01"; done <= '1'; stateX <= "1010";
        when FinalState3 => enableW <= "10"; done <= '1'; stateX <= "1011";
        when FinalState4 => enableW <= "11"; done <= '1'; stateX <= "1100";
        when others => next_state <= nonState; done <= '0';
        end case;
    end process;
end Behavioral;
