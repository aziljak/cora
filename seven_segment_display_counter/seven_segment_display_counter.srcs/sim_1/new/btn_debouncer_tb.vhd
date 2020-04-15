----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2020 20:35:16
-- Design Name: 
-- Module Name: btn_debouncer_tb - rtl
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

entity btn_debouncer_tb is
end btn_debouncer_tb;

architecture rtl of btn_debouncer_tb is

    component btn_debouncer is
        generic (
            CNT_WIDTH : integer := 21
        );
        port (
            clk     : in std_logic;
            btn_in  : in std_logic;
            btn_out : out std_logic
        );
    end component;
    
    -- input signals
    signal clk : std_logic := '0';
    signal btn_in : std_logic := '0';
    
    --output signals
    signal btn_out : std_logic;
    
    -- time period
    constant clk_period : time := 8 ns;

begin

    UUT: btn_debouncer
        generic map (
            CNT_WIDTH => 21
        )
        port map (
            clk => clk,
            btn_in => btn_in,
            btn_out => btn_out
        );
        
    process
    begin
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
    end process;
    
    btn_in <= '0', '1' after 10ms, '0' after 35ms, '1' after 60ms, '0' after 90ms;

end rtl;
