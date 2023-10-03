library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity regfile is
	port( 
	din : in std_logic_vector(3 downto 0);
	reset : in std_logic;
	clk : in std_logic;
    write : in std_logic;

    read_a : in std_logic_vector(3 downto 0);
	read_b : in std_logic_vector(3 downto 0);
	write_address : in std_logic_vector(3 downto 0);

    out_a : out std_logic_vector(3 downto 0);
	out_b : out std_logic_vector(3 downto 0));
end regfile ;

architecture logic of regfile is
	type array_reg is array (0 to 31) of std_logic_vector(31 downto 0);
	signal reg: array_reg;
	signal d : std_logic_vector(31 downto 0);
begin
	d(3 downto 0) <= din(3) & din(2) & din(1) & din(0);
	d(31 downto 4) <= (others => '0');

	write_process : process(reset, clk, write)
	begin
		if (reset = '1') then
			for i in 0 to 31 loop
				reg(i) <= "00000000000000000000000000000000";
			end loop;
		elsif (write = '1' and rising_edge(clk)) then
			reg(to_integer(unsigned(write_address))) <= d;
		end if;
	end process;


	read_process : process(read_a, read_b, reg)
		variable temp : std_logic_vector(31 downto 0);
	begin	
		temp := reg(to_integer(unsigned(read_a)));
		out_a <= temp(3) & temp(2) & temp(1) & temp(0);

		temp := reg(to_integer(unsigned(read_b)));
		out_b <= temp(3) & temp(2) & temp(1) & temp(0);
	end process;

end logic;