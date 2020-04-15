----------------------------------------------------------------------------------
-- Company: -
-- Engineer: aziljak
-- 
-- Create Date: 02.02.2020 17:17:58
-- Design Name: binary_to_bcd_tb
-- Module Name: binary_to_bcd_tb - rtl
-- Project Name: seven segment display counter
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

entity binary_to_bcd_tb is
end binary_to_bcd_tb;

architecture rtl of binary_to_bcd_tb is

    -- input signals
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal cnt : std_logic_vector(7 downto 0) := (others => '0');
    
    -- output signals
    signal upper_digit : std_logic_vector(3 downto 0) := (others => '0');
    signal lower_digit : std_logic_vector(3 downto 0) := (others => '0');
    
    -- constants
    constant clk_period : time := 8 ns;

    component binary_to_bcd is
        port (
            clk         : in std_logic;
            rst         : in std_logic;
            cnt         : in std_logic_vector(7 downto 0);
            upper_digit : out std_logic_vector(3 downto 0);
            lower_digit : out std_logic_vector(3 downto 0)
        );
    end component;

begin

    UUT: binary_to_bcd
        port map (
            clk => clk,
            rst => rst,
            cnt => cnt,
            upper_digit => upper_digit,
            lower_digit => lower_digit
        );

    process
    begin
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
    end process;

    process
    begin
        cnt <= (others => '0');
        wait for 20 ms;
        cnt <= x"01"; -- dec 1
        wait for 10 ms;
        cnt <= x"0A"; -- dec 10
        wait for 15 ms;
        cnt <= x"59"; -- dec 89
        wait for 30 ms;
    end process;
    
    rst <= '1', '0' after 15 ms;

end rtl;
