----------------------------------------------------------------------------------
-- Company: -
-- Engineer: aziljak
-- 
-- Create Date: 01.02.2020 20:59:23
-- Design Name: counter module
-- Module Name: counter - rtl
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity counter is
    generic (
        MAX_CNT         : integer range 1 to 99 := 99
    );
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        btn     : in std_logic;
        counter : out std_logic_vector(7 downto 0)
    );
end counter;

architecture rtl of counter is

    signal ff       : std_logic_vector(1 downto 0) := "00";
    signal cnt_up   : std_logic := '0';
    signal cnt_i    : std_logic_vector(7 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                ff <= (others => '0');
            else
                ff(0) <= btn;
                ff(1) <= ff(0);
            end if;
        end if;
    end process;
    
    cnt_up <= '1' when ff = "01" else '0';

    process(clk)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                cnt_i <= (others => '0');
            elsif (conv_integer(cnt_i) > MAX_CNT) then
                cnt_i <= (others => '0');
            elsif (cnt_up = '1') then
                cnt_i <= cnt_i + 1;
            else
                cnt_i <= cnt_i;
            end if;
        end if;
    end process;
    
    counter <= cnt_i;

end rtl;
