----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.01.2020 20:47:33
-- Design Name: 
-- Module Name: led_blinker_tb - rtl
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
use ieee.std_logic_unsigned.all;

entity led_blinker_tb is
end led_blinker_tb;

architecture rtl of led_blinker_tb is

    component led_blinker
        generic (
            CLK_DIVIDE : integer range 2 to 27
        );
        port (
            clk : in std_logic;
            rst : in std_logic;
            led : out std_logic
        );
    end component;
        
     -- input signals
     signal clk : std_logic := '0';
     signal rst : std_logic := '0';
     
     -- output signals
     signal led : std_logic := '0';
     
     -- time constant
     constant clk_period : time := 20ns;

begin

    UUT: led_blinker
        generic map (
            CLK_DIVIDE => 3
        )
        port map (
            clk => clk,
            rst => rst,
            led => led
        );
    
    rst <= '1', '0' after 30ns;    
    
    process
    begin
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
    end process;

end rtl;
