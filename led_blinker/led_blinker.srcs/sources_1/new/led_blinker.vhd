----------------------------------------------------------------------------------
-- Company: -
-- Engineer: aziljak
-- 
-- Create Date: 28.01.2020 20:38:42
-- Design Name: 
-- Module Name: led_blinker - rtl
-- Project Name: led_blinker
-- Target Devices: Cora-Z7-10
-- Tool Versions: 2019.1
-- Description: 
-- 
-- Dependencies: -
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity led_blinker is
    generic (
        CLK_DIVIDE : integer range 2 to 50 := 28
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        led : out std_logic
    );
end led_blinker;

architecture rtl of led_blinker is

    signal cnt : std_logic_vector(CLK_DIVIDE-1 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                cnt <= (others => '0');
            elsif cnt(CLK_DIVIDE - 1) = '1' then
                cnt <= (others => '0');
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process;
    
    led <= cnt(CLK_DIVIDE - 2);

end rtl;
