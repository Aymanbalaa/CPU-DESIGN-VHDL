library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity sign_extender is port ( 
sign_extender_in: in std_logic_vector (15 downto 0); -- (16-bit)
sign_extender_func: in std_logic_vector (1 downto 0); -- func sign_extender_out :out sign_extender_out: std_logic_vector (31 downto 0));
end sign_extender;

architecture arch of sign extender is
begin

sign_extension : process( sign_extender_in, sign_extender_func) 
begin 

case( sign_extender_func ) is

when "00" => sign_extender_out <= signextender in & "0000000000000000'

when "01" =>
sign_extender_out (15 downto 0) <= sign_extender_in;
sign_extender_out (31 downto 16) <= (others => sign_extender_in(15));

when "10" =>
sign_extender_out(15 downto 0) <= sign_extender_in;
sign_extender_out (31 downto 16) <= (others => sign_extender_in(15));

when others => sign_extender_out <= "0000000000000000" & sign_extender_in;

end case;
end process;
end arch;
