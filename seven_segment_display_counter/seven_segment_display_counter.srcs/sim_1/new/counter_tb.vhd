----------------------------------------------------------------------------------
-- Company: -
-- Engineer: aziljak
-- 
-- Create Date: 01.02.2020 21:16:44
-- Design Name: counter_tb
-- Module Name: counter_tb - rtl
-- Project Name: seven segmend counter
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

entity counter_tb is
end counter_tb;

architecture rtl of counter_tb is

    -- input signals
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal btn : std_logic := '0';
    
    -- output signals
    signal counter_out : std_logic_vector(7 downto 0) := (others => '0');
    
    -- time period
    constant clk_period : time := 8 ns;

    component counter is
        generic (
            MAX_CNT : integer := 99;
            MAX_CNT_SIZE : integer := 8
        );
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            btn     : in std_logic;
            counter : out std_logic_vector(MAX_CNT_SIZE - 1 downto 0)
        );
    end component;

begin

    UUT: counter
        generic map (
            MAX_CNT => 99,
            MAX_CNT_SIZE => 8
        )
        port map (
            clk => clk,
            rst => rst,
            btn => btn,
            counter => counter_out
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
        wait for 10 ms;
        btn <= '1';
        wait for 15 ms;
        btn <= '0';
    end process;

    rst <= '1', '0' after 50 us;
    

end rtl;
