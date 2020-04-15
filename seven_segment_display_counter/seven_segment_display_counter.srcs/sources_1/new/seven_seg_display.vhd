----------------------------------------------------------------------------------
-- Company: -
-- Engineer: aziljak
-- 
-- Create Date: 01.02.2020 21:33:50
-- Design Name: seven_seg_display module
-- Module Name: seven_seg_display - rtl
-- Project Name: seven segment counter
-- Target Devices: Cora Z7-10
-- Tool Versions: 2019.1
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity seven_seg_display is
    port (
        digit               : in std_logic_vector(3 downto 0);
        seven_seg_disp      : out std_logic_vector(6 downto 0)
    );
end seven_seg_display;

architecture rtl of seven_seg_display is

begin

    with digit select
        seven_seg_disp <= "1111110" when x"0", -- ABCDEFG
                          "0110000" when x"1",
                          "1101101" when x"2",
                          "1111001" when x"3",
                          "0110011" when x"4",
                          "1011011" when x"5",
                          "1011111" when x"6",
                          "1110000" when x"7",
                          "1111111" when x"8",
                          "1111011" when x"9",
                          "0000000" when others;

end rtl;
