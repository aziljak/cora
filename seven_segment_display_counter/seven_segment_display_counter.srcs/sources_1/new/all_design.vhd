----------------------------------------------------------------------------------
-- Company: -
-- Engineer: aziljak
-- 
-- Create Date: 02.02.2020 18:45:39
-- Design Name: 
-- Module Name: all_design - rtl
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

entity all_design is
    port (
        clk             : in std_logic;
        rst             : in std_logic;
        btn             : in std_logic;
        display_en      : out std_logic;
        digit_out       : out std_logic_vector(6 downto 0)
        -- upper_digit_out : out std_logic_vector(6 downto 0);
        -- lower_digit_out : out std_logic_vector(6 downto 0)
    );
end all_design;

architecture rtl of all_design is

    --=================================
    -- INTERNAL SIGNALS
    --=================================
    signal rst_i : std_logic := '0';
    signal btn_i : std_logic := '0';
    
    signal cnt_i            : std_logic_vector(7 downto 0) := (others => '0');
    signal upper_digit_i    : std_logic_vector(3 downto 0) := (others => '0');
    signal lower_digit_i    : std_logic_vector(3 downto 0) := (others => '0');
    
    signal upper_digit_out  : std_logic_vector(6 downto 0) := (others => '0');
    signal lower_digit_out  : std_logic_vector(6 downto 0) := (others => '0');
    signal display_en_i     : std_logic := '0';

    --=================================
    -- COMPONENT DECLARATION
    --=================================
    component btn_debouncer is
        generic (
            CNT_WIDTH : integer := 22
        );
        port (
            clk     : in std_logic;
            btn_in  : in std_logic;
            btn_out : out std_logic
        );
    end component;
    
    component counter is
        generic (
            MAX_CNT : integer range 1 to 99 := 99
        );
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            btn     : in std_logic;
            counter : out std_logic_vector(7 downto 0)
        );
    end component;
    
    component binary_to_bcd is
        port (
            cnt         : in std_logic_vector(7 downto 0);
            upper_digit : out std_logic_vector(3 downto 0);
            lower_digit : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component seven_seg_display is
        port (
            digit           : in std_logic_vector(3 downto 0);
            seven_seg_disp  : out std_logic_vector(6 downto 0)
        );
    end component;
    
    component seven_seg_mux is
        port (
            clk : in std_logic;
            display_en : out std_logic
        );
    end component;

begin

    --=================================
    -- COMPONENT INSTANTIATION
    --=================================
    rst_debounce: btn_debouncer
        generic map (
            CNT_WIDTH => 22
        )
        port map (
            clk => clk,
            btn_in => rst,
            btn_out => rst_i
        );
        
    increment_debouncer: btn_debouncer
        generic map (
            CNT_WIDTH => 22
        )
        port map (
            clk => clk,
            btn_in => btn,
            btn_out => btn_i
        );
        
    counter_i: counter
        generic map (
            MAX_CNT => 99
        )
        port map (
            clk => clk,
            rst => rst_i,
            btn => btn_i,
            counter => cnt_i
        );
            
    binary2bcd: binary_to_bcd
        port map (
            cnt => cnt_i,
            upper_digit => upper_digit_i,
            lower_digit => lower_digit_i
        );    
        
    seven_seg_lower: seven_seg_display
        port map (
            digit => lower_digit_i,
            seven_seg_disp => lower_digit_out
        );
        
    seven_seg_upper: seven_seg_display
        port map (
            digit => upper_digit_i,
            seven_seg_disp => upper_digit_out
        );
        
    seven_seg_mux_i: seven_seg_mux
        port map (
            clk => clk,
            display_en => display_en_i
        );
        
    digit_out <= lower_digit_out when display_en_i = '0'
                  else upper_digit_out;
    display_en <= display_en_i;

end rtl;
