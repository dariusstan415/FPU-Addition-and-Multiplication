
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Simulation07 is
--  Port ( );
end Simulation07;

architecture Behavioral of Simulation07 is
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
  Port (en: in std_logic;
        sigIn: in std_logic_vector(47 downto 0);
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
        stateX: out std_logic_vector(3 downto 0);
        done: out std_logic
        );
end component;
---------------------------------------------------------------------------------------------
signal A,B: std_Logic_vector(31 downto 0);
signal exp1, exp2, exp12, exp3: std_logic_vector(7 downto 0);
signal over1, under1, over2, underflow, overflow: std_logic;
signal doneM, doneDN, dNor, doneR, doneN: std_logic;
signal dna, dnb: std_logic;
signal rez1, rez2, rez3, rezN: std_logic_vector(47 downto 0);
signal clk: std_logic := '1';
signal FINAL: std_logic_vector(31 downto 0);
----------------------------------------------------------------------------------------------
signal expMux, W, start: std_logic;
signal manMux, enableW : std_logic_vector(1 downto 0);
signal  en: std_logic;
signal state: std_logic_vector(3 downto 0);
signal READY: std_logic :='0';
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
---------------------------------------------------------------------------------------------
    getting_the_exponent: ExonentComp port map(expA => A(30 downto 23),
                                               expB => B(30 downto 23),
                                               rez  => exp1,
                                               overflow => over1,
                                               underflow => under1 );
    
    gen_loop: for i in 0 to 7 generate
        exp12(i) <= (not expMux and exp1(i)) or (expMux and exp2(i));
    end generate gen_loop;                                 
    the_flow_unit: FlowUnit port map(expIn => exp12,
                                     overflowIn => (over1),
                                     underflowIn => (under1),
                                     expOut => exp3,
                                     overflowOut => overflow,
                                     underflowOut => underflow );
----------------------------------------------------------------------------------------------
    multipy_the_significants: Multiplier port map( clk => clk,
                                                   start => start,
                                                   manA => A (22 downto 0),
                                                   manB => B (22 downto 0),
                                                   dNA => dna,
                                                   dNB => dnb,                                     
                                                   rez => rez1,
                                                   done => doneM );
    process(manMux, rez1, rez2, rez3)
    begin
        if manMux = "00" then rezN <= rez1;
        elsif manMux = "01" then rezN <= rez2;
        elsif manMux = "10" then rezN <= rez3;
        end if;
    end process;   
    normalise: Normaliser port map( sigIn => rezN,
                                    expIn => exp3,
                                    sigOut => rez2,
                                    expOut => exp2,
                                    doneN => doneN,
                                    dnor => dNor,
                                    doneDN => doneDN );
    round: Rounding port map ( en => doneN,
                               sigIn => rez2,
                               sigOut => rez3,
                               done => doneR);
    Ctrl:ControlUnit port map(clk => clk,
                              en => en,
                              underflow => underflow,
                              overflow => overflow,
                              doneM => doneM,
                              doneN => doneN,
                              doneDN => doneDN,
                              dNor => dNor,
                              doneR => doneR,
                              start => start,
                              expMux => expMux,
                              manMux => manMux,
                              enableW => enableW,
                              stateX => state,
                              done => READY
                                );
    FINAL(31) <= A(31) xor B(31);
    process(enableW,A,B,state)
    begin
        if enableW = "00" then
            FINAL(30 downto 23) <= "11111111";
            FINAL(22 downto 0) <= (others => '0');
        elsif enableW = "01" then
            FINAL(30 downto 23) <= (others => '0');
            FINAL(22 downto 0) <= (others => '0');
        elsif enableW = "10" then
            FINAL(30 downto 23) <= exp2;
            FINAL(22 downto 0) <= rez2(45 downto 23);
        elsif enableW = "11" then
            FINAL(30 downto 23) <= exp2;
            FINAL(22 downto 0) <= rez3(45 downto 23);
        end if;
    end process;
   
end Behavioral;
