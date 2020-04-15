----------------------------------------------------------------------------------
-- Company: -
-- Engineer: aziljak
-- 
-- Create Date: 30.01.2020 20:08:44
-- Design Name: btn_debouncer module
-- Module Name: btn_debouncer - rtl
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
--          stable button after ~10ms @ 125 MHz
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity btn_debouncer is
    generic (
        CNT_WIDTH : integer := 22
    );
    port (
        clk         : in std_logic;
        btn_in      : in std_logic;
        btn_out     : out std_logic
    );
end btn_debouncer;

architecture rtl of btn_debouncer is

    signal cnt_rst  : std_logic := '0';
    signal btn_i    : std_logic := '0';
    signal btn_ii   : std_logic := '0';
    signal cnt      : std_logic_vector(CNT_WIDTH-1 downto 0) := (others => '0');

begin

    cnt_rst <= btn_i xor btn_ii;

    -- debounce the button
    process(clk)
    begin
        if rising_edge(clk) then
            btn_i <= btn_in;
            btn_ii <= btn_i;
            if cnt_rst = '1' then
                cnt <= (others => '0');
            elsif cnt(CNT_WIDTH - 1) = '0' then
                cnt <= cnt + 1;
            else
                btn_out <= btn_ii;
            end if;
        end if;
    end process;

end rtl;
