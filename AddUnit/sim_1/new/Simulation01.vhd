----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2023 01:22:09 PM
-- Design Name: 
-- Module Name: Simulation01 - Behavioral
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


entity Simulation01 is
--  Port ( );
end Simulation01;



architecture Behavioral of Simulation01 is
component SmallALU is
 Port (expA: in std_logic_vector(7 downto 0);
       expB: in std_logic_vector(7 downto 0);
       expDiff: out std_logic_vector(7 downto 0);
       cmpAB: out std_logic  );
end component;

component ShifterRight is
 Port (dN: in std_logic;
       nrBits: in std_logic_vector(7 downto 0);
       inA: in std_logic_vector(22 downto 0);
       outA: out std_logic_vector(278 downto 0) );
end component;

component BigALU is
 Port (manA: in std_logic_vector(278 downto 0);
       manB: in std_logic_vector(278 downto 0);
       signA,signB: in std_logic;
       manRez: out std_logic_vector(278 downto 0);
       carryOut: out std_logic );
end component;

component Extender is
 Port (dN: in std_logic;
       inA : in std_logic_vector(22 downto 0);
       outA : out std_logic_vector(278 downto 0));
end component;

component AddNormaliser is
 Port (
       sigIn: in std_logic_vector(279 downto 0);
       expIn: in std_logic_vector(7 downto 0);
       sigOut: out std_logic_vector(279 downto 0);
       expOut: out std_logic_vector(7 downto 0);
       doneN, dnor, doneDN: out std_logic
       );
end component;

component ADDRounding is
 Port (en: in std_logic;
       sigIn: in std_logic_vector(279 downto 0);
       sigOut: out std_logic_vector(279 downto 0);
       done: out std_logic
       );
end component;

component ADDFlowUnit is
 Port (expIn: in std_logic_vector(7 downto 0);
       expOut: out std_logic_vector(7 downto 0);
       overflowOut: out std_logic
       );
end component;

component ADDControlUnit is
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
end component;

 signal A:  std_logic_vector(31 downto 0);
 signal B:  std_logic_vector(31 downto 0);
 signal dNA, dNB:  std_logic;
 signal clk:  std_logic := '1';
 signal en:  std_logic;
 signal REZ:  std_logic_vector(31 downto 0);
 signal READY :std_logic;
---------------------------------------------------------------------------------
signal exponent1, exponent2, exponent3, exponent12: std_logic_vector(7 downto 0);
signal exponentDiff: std_logic_vector(7 downto 0);
signal biggerExponent: std_logic;
signal inputShifterRight, inputExtender: std_logic_vector(22 downto  0);
signal outputShifterRight, outputExtender: std_logic_vector(278 downto 0);
signal BigResult: std_logic_vector(278 downto 0);
signal BigCarry: std_logic;
signal addedMan: std_logic_vector(279 downto 0);
signal semn1, semn2: std_logic;
signal BigMantissa1, BigMantissa2, BigMantissa3, BigMantissaN: std_logic_vector(279 downto 0);
signal dN1, dN2: std_logic := '0';
------------------------------------------
signal expMux: std_logic;
signal manMux: std_logic_vector(1 downto 0);
------------------------------------------
signal doneN, doneDn, dNor, doneR: std_logic;
signal overflow: std_logic;
signal enableW: std_logic_vector(1 downto 0);
signal state: std_logic_vector(3 downto 0);
signal READYDONE: std_logic := '0';

begin
    A<="01000001011110100000000000000000", "01000001101010100000000000000000" after 49 ns;
    B<="01000001011110100000000000000000", "01000100011100010100000000000000" after 49 ns;
    dNA<='1';
    dNB<='1';
    
    en <= '1', '0' after 10 ns, '1' after 50 ns, '0' after 60 ns;
        process
            begin
                while now <= 2000 ns loop
                    wait for 1 ns;
                    clk <= not clk;
                end loop;
        end process;
   -------------------------------------------------------------------------------------------------------
   diferenta_exponenti: SmallALU port map(A(30 downto 23), B(30 downto 23), exponentDiff, biggerExponent);
   -------------------------------------------------------------------------------------------------------
   process(A,B, biggerExponent) -- mux pentru intrarile in BIG ALU
   begin
       if biggerExponent = '1' then
           inputShifterRight <= B(22 downto 0);
           dN1 <= dNB;
      
           inputExtender <= A(22 downto 0);
           dN2 <= dNA;
           semn1 <= B(31);
           semn2 <= A(31);
           exponent1 <= A(30 downto 23);
       else
           inputShifterRight <= A(22 downto 0);
           dN1 <= dNA;
           inputExtender <= B(22 downto 0);
           dN2 <= dNB;
           semn1 <= A(31);
           semn2 <= B(31);
           exponent1 <= B(30 downto 23);
       end if;
   end process;
   -------------------------------------------------------------------------------------------------------
   shiftare: ShifterRight port map(dN1,exponentDiff,inputShifterRight,outputShifterRight);
   extindere: Extender port map(dN2,inputExtender,outputExtender);
   
   adunare_mantisse: BigALU port map(outputShifterRight,outputExtender,semn1,semn2,BigResult,BigCarry);
   BigMantissa1 <= BigCarry & BigResult;
   --------------------------------------------------------------------------------------------------------
   gen_for_loop: for i in 0 to 7 generate -- mux pt lucru cu exponentul curent
       exponent12(i) <= (expMux and exponent2(i)) or ((not expMux) and exponent1(i));
   end generate;
   ---------------------------------------------------------------------------------------------------------
   flowing: ADDFlowUnit port map (expIn => exponent12,
                                  expOut => exponent3,
                                  overflowOut => overflow
                                  );
   ----------------------------------------------------------------------------------------------------------
   process(manMux, BigMantissa1,BigMantissa2,BigMantissa3)
   begin
       if manMux = "00" then BigMantissaN <= BigMantissa1;
       elsif manMux = "01" then BigMantissaN <= BigMantissa2;
       elsif manMux = "10" then BigMantissaN <= BigMantissa3;
       end if;
   end process;
   ---------------------------------------------------------------------------------------------------------
   normalise: AddNormaliser port map(sigIn => BigMantissaN,
                                     expIn => exponent3,
                                     sigOut => BigMantissa2,
                                     expOut => exponent2,
                                     doneN => doneN,
                                     dnor => dnor,
                                     doneDN => doneDN);
  ----------------------------------------------------------------------------------------------------------
  roundandround: ADDRounding port map( en => doneN,
                                       sigIn => BigMantissa2,
                                       sigOut => BigMantissa3,
                                       done => doneR);
  ----------------------------------------------------------------------------------------------------------
  xyZ: ADDControlUnit
    Port map(clk => clk,
          en => en,
          overflow => overflow,
          doneN => doneN,
          doneDN => doneDN,
          dNor => dNor,
          doneR => doneR,
          expMux => expMux,
          manMux => manMux,
          enableW => enableW,
          stateX => state,
          done => READY
          );
   REZ(31) <= A(31) xor B(31);
   process(enableW,A,B,state)
    begin
        if enableW = "00" then
            REZ(30 downto 23) <= "11111111";
            REZ(22 downto 0) <= (others => '0');
        elsif enableW = "01" then
            REZ(30 downto 23) <= (others => '0');
            REZ(22 downto 0) <= (others => '0');
        elsif enableW = "10" then
            REZ(30 downto 23) <= exponent2;
            REZ(22 downto 0) <= BigMantissa2(277 downto 255);
        elsif enableW = "11" then
            REZ(30 downto 23) <= exponent2;
            REZ(22 downto 0) <= BigMantissa3(277 downto 255);
        end if;
    end process;
   
   
   
   
   
   
   
   
   
   
   
   
   
end Behavioral;

