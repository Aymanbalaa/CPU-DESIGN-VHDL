library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity pc_ent is
port(din : in std_logic_vector(31 downto 0);
reset : in std_logic;
clk : in std_logic;
q : out std_logic_vector(31 downto 0));
end pc_ent;
  
architecture pc_arch of pc_ent is begin
pc : process (din,reset,clk)
begin
if (reset = '1') then
q <= (others => '0');
elsif (rising_edge(clk)) then
q <= din; end if;
end process pc;
end pc_arch;
