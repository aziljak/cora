----------------------------------------------------------------------------------
-- Company: -
-- Engineer: aziljak
-- 
-- Create Date: 01.02.2020 22:54:58
-- Design Name: binary_to_bcd module
-- Module Name: binary_to_bcd - rtl
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
--      in order to show binary counter on the 7 seg display, it needs to be
--      converted to bcd
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity binary_to_bcd is
    port (
        cnt         : in std_logic_vector(7 downto 0);
        upper_digit : out std_logic_vector(3 downto 0);
        lower_digit : out std_logic_vector(3 downto 0)
    );
end binary_to_bcd;

architecture rtl of binary_to_bcd is

begin
        
    process(cnt)
    
        variable binary_reg     : std_logic_vector(7 downto 0) := (others => '0');
        variable bcd_digits_i   : std_logic_vector(7 downto 0) := (others => '0');
    
    begin
        binary_reg := cnt;
        bcd_digits_i := (others => '0');
        
        for i in 0 to 7 loop
            if (bcd_digits_i(3 downto 0) > "0100") then
                bcd_digits_i(3 downto 0) := bcd_digits_i(3 downto 0) + "0011";
            end if;
            
            if (bcd_digits_i(7 downto 4) > "0100") then
                bcd_digits_i(7 downto 4) := bcd_digits_i(7 downto 4) + "0011";
            end if;
            
            bcd_digits_i := bcd_digits_i(6 downto 0) & binary_reg(7);
            binary_reg := binary_reg(6 downto 0) & '0';
        end loop;
        
        upper_digit <= bcd_digits_i(7 downto 4);
        lower_digit <= bcd_digits_i(3 downto 0);
    end process;

end rtl;
