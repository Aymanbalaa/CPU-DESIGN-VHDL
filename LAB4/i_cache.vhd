library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity instru_cache_ent is
port(address : in std_logic_vector(4 downto 0);
instr : out std_logic_vector(31 downto 0)); end instru_cache_ent;

architecture instru_cache_arch of instru_cache_ent is 
begin
cache : process(address)
begin

case (address) is
when "00000" => instr <= " 00100000000000110000000000000000"; -- addi r3, r0, 0

when "00001" => instr <= " 00100000000000010000000000000000"; -- addi r1, r0, 0

when "00010" => instr <= " 00100000000000100000000000000101"; -- addi r2, r0, 5

when "00011" => instr <= " 00000000001000100000100000100000"; -- add r1, r1, r2

 when "00100" => instr <= "00100000010000101111111111111111"; -- addi r2, r2, -1

when "00101" => instr <= "00010000010000110000000000000001"; -- beq r2, r3 (+1) THERE

when "00110" => instr <= "00001000000000000000000000000011"; -- jump 3 (LOOP)

when "00111" => instr <= "10101100000000010000000000000000"; -- sw r1, 0(r0)

when "01000" => instr <= "10001100000001000000000000000000"; -- lw r4, 0(r0)

when "01001" => instr <= "00110000100001000000000000001010"; -- andi r4, r4, 0x000A

when "01010" => instr <= "00110100100001000000000000000001"; -- ori r4, r4, 0x0001

when "01011" => instr <= "00111000100001000000000000001011"; -- xori r4, r4, 0xB

when "01100" => instr <= "00111000100001000000000000000000"; -- xori r4, r4, 0x0000

when others  => instr <= "00000000000000000000000000000000"; -- dont care

end process cache; 
end instru_cache_arch;
