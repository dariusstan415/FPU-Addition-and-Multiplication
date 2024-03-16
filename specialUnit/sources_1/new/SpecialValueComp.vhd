----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 09:31:07 PM
-- Design Name: 
-- Module Name: SpecialValueComp - Behavioral
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

entity SpecialValueComp is
  Port (A : in std_logic_vector(31 downto 0);
        B : in std_logic_vector(31 downto 0);
        op : in std_logic;
        code : out std_logic_vector(4 downto 0);
        dNA: out std_logic;
        dNB: out std_logic );
end SpecialValueComp;

architecture Behavioral of SpecialValueComp is
signal c1, c2, cr : std_logic_vector(4 downto 0) := "00000";
signal z1, minf1, pinf1, nan1, dnor1: std_logic;
signal z2, minf2, pinf2, nan2, dnor2: std_logic;

component SpecialValSingular is
  Port (A : in std_logic_vector(31 downto 0);
        code : out std_logic_vector(4 downto 0) );
end component;

begin
    code_for_A: SpecialValSingular port map(A,c1);
    code_for_B: SpecialValSingular port map(B,c2);
    
    process(c1, c2, op)
    begin
        case op is
            when '0' => 
                case c1 is
                    when "10000" => cr <= c2; -- zero
                    when "01000" => --plus inf
                        case c2 is
                            when "10000" => cr <= "01000";--pinf + zero = pinf
                            when "01000" => cr <= "01000";--pinf + pinf = pinf
                            when "00100" => cr <= "00001";--pinf + minf = nan
                            when "00010" => cr <= "01000";--pinf + dnor = pinf
                            when "00001" => cr <= "00001";--pinf + nan = nan
                            when others => cr <= "01000"; --pinf + nor = pinf
                        end case;
                    when "00010" => --dnor
                        case c2 is
                            when "10000" => cr <= "00010";--dNOR + zero = dNOR
                            when "01000" => cr <= "01000";--dNOR + pinf = pinf
                            when "00100" => cr <= "00100";--dNOR + minf = minf
                            when "00010" => cr <= "00010";--dNOR + dnor = dnor
                            when "00001" => cr <= "00001";--dNOR + nan = nan
                            when others => cr <= "00000"; --dNOR + nor = NOR
                        end case;
                    when "00100" => -- minf
                        case c2 is
                            when "10000" => cr <= "00100";--minf + zero = minf
                            when "01000" => cr <= "01000";--minf + pinf = nan
                            when "00100" => cr <= "00100";--minf + min = minf
                            when "00010" => cr <= "00100";--minf + dnor = minf
                            when "00001" => cr <= "00001";--minf + nan = nan
                            when others => cr <= "00100"; --minf + nor = minf
                        end case;
                    when "00001" => -- non
                        case c2 is
                            when "10000" => cr <= "00001";--nan + zero = nan
                            when "01000" => cr <= "00001";--nan + pinf = nan
                            when "00100" => cr <= "00001";--nan + min = nan
                            when "00010" => cr <= "00001";--nan + dnor = nan
                            when "00001" => cr <= "00001";--nan + nan = nan
                            when others => cr <= "00001"; --nan + nor = nan
                        end case;
                    when others => --nor
                        case c2 is
                            when "10000" => cr <= "00000";--nor + zero = nor
                            when "01000" => cr <= "01000";--nor + pinf = pinf
                            when "00100" => cr <= "00001";--nor + min = min
                            when "00010" => cr <= "00000";--nor + dnor = nor
                            when "00001" => cr <= "00001";--nor + nan = nan
                            when others => cr <= "00000"; --nor + nor = nor
                        end case;
                   end case;
            when others => -- inmultire
                        case c1 is
                                when "10000" => 
                                    case c2 is
                                        when "10000" => cr <= "10000";--zero + zero = zero
                                        when "01000" => cr <= "00001";--zero + pinf = nan
                                        when "00100" => cr <= "00001";--zero + minf = nan
                                        when "00010" => cr <= "10000";--zero + dnor = zero
                                        when "00001" => cr <= "00001";--zero + nan = nan
                                        when others => cr <= "10000"; --zero + nor = zero
                                    end case;                                    
                                when "01000" => --plus inf
                                    case c2 is
                                        when "10000" => cr <= "00001";--pinf + zero = nan
                                        when "01000" => cr <= "01000";--pinf + pinf = pinf
                                        when "00100" => cr <= "10000";--pinf + minf = minf
                                        when "00010" => cr <= "01000";--pinf + dnor = pinf
                                        when "00001" => cr <= "00001";--pinf + nan = nan
                                        when others => cr <= "01000"; --pinf + nor = pinf
                                    end case;
                                when "00010" => --dnor
                                    case c2 is
                                        when "10000" => cr <= "00010";--dNOR + zero = zero
                                        when "01000" => cr <= "01000";--dNOR + pinf = pinf
                                        when "00100" => cr <= "00100";--dNOR + minf = minf
                                        when "00010" => cr <= "00010";--dNOR + dnor = dnor
                                        when "00001" => cr <= "00001";--dNOR + nan = nan
                                        when others => cr <= "00000"; --dNOR + nor = NOR
                                    end case;
                                when "00100" => -- minf
                                    case c2 is
                                        when "10000" => cr <= "00001";--minf + zero = nan
                                        when "01000" => cr <= "10000";--minf + pinf = minf
                                        when "00100" => cr <= "10000";--minf + min = minf
                                        when "00010" => cr <= "10000";--minf + dnor = minf
                                        when "00001" => cr <= "00001";--minf + nan = nan
                                        when others => cr <= "10000"; --minf + nor = minf
                                    end case;
                                when "00001" => -- non
                                    case c2 is
                                        when "10000" => cr <= "00001";--nan + zero = nan
                                        when "01000" => cr <= "00001";--nan + pinf = nan
                                        when "00100" => cr <= "00001";--nan + min = nan
                                        when "00010" => cr <= "00001";--nan + dnor = nan
                                        when "00001" => cr <= "00001";--nan + nan = nan
                                        when others => cr <= "00001"; --nan + nor = nan
                                    end case;
                                when others => --nor
                                    case c2 is
                                        when "10000" => cr <= "10000";--nor + zero = nor
                                        when "01000" => cr <= "01000";--nor + pinf = pinf
                                        when "00100" => cr <= "00100";--nor + min = min
                                        when "00010" => cr <= "00000";--nor + dnor = nor
                                        when "00001" => cr <= "00001";--nor + nan = nan
                                        when others => cr <= "00000"; --nor + nor = nor
                                    end case;
                           end case;            
       end case;
       end process;

end Behavioral;
