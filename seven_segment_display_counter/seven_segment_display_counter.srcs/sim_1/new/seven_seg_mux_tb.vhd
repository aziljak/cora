----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2020 05:25:09 PM
-- Design Name: 
-- Module Name: seven_seg_mux_tb - rtl
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

entity seven_seg_mux_tb is
end seven_seg_mux_tb;

architecture rtl of seven_seg_mux_tb is

    component seven_seg_mux is
        port (
            clk : in std_logic;
            display_en : out std_logic
        );
    end component;
    
    signal clk : std_logic := '0';
    signal display_en : std_logic := '0';
    
    constant clk_period : time := 8 ns;

begin

    UUT: seven_seg_mux
        port map (
            clk => clk,
            display_en => display_en
        );

    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

end rtl;
