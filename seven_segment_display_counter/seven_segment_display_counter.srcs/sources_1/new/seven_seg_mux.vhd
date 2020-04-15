----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.02.2020 19:07:10
-- Design Name: 
-- Module Name: seven_seg_mux - rtl
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
--              refresh rate of digits: 60Hz (16ms), which means
--              each digit 8ms of being shown
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity seven_seg_mux is
    port (
        clk : in std_logic;
        display_en : out std_logic
    );
end seven_seg_mux;

architecture rtl of seven_seg_mux is

    signal cnt : std_logic_vector(21 downto 0) := (others => '0'); -- period of ~16ms

begin

    process(clk)
    begin
        if rising_edge(clk) then
            cnt <= cnt + '1';
            if (cnt(21) = '1') then
                cnt <= (others => '0');
            end if;         
        end if;
    end process;
    
    display_en <= cnt(20); -- ~8ms

end rtl;
