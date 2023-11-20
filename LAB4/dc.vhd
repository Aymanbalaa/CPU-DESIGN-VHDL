library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 
use IEEE.numeric_std.all;

entity data_cache_ent is
port( din : in std_logic_vector(31 downto 0);
reset : in std_logic;
clk : in std_logic;
data_write : in std_logic;
address : in std_logic_vector(4 downto 0); d_out : out std_logic_vector(31 downto 0));
end data_cache_ent;

architecture data_cache_arch of data_cache_ent is

type registerarray is array (0 to 31) of std_logic_vector(31 downto 0); 
signal allregisters : registerarray;

begin
write: process(clk, reset) is 
begin
if (reset ='1') then
allregisters <= (others => (others => '0'));
elsif (rising_edge(clk) and data_write ='1') then 
allregisters(conv_integer(address)) <= din;
end if;
end process;
d_out <= allregisters(conv_integer(address)); 
end data_cache_arch;
