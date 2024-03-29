library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity next_address is
	port(
		rt_in, rs_in : in std_logic_vector(1 downto 0);
		pc_in : in std_logic_vector(2 downto 0);
		target_address_in : in std_logic_vector(2 downto 0);
		branch_type : in std_logic_vector(1 downto 0);
		pc_sel : in std_logic_vector(1 downto 0);
		next_pc_out : out std_logic_vector(2 downto 0));
end next_address ;

architecture arch of next_address is

	signal branch_out : std_logic_vector(31 downto 0);
	signal sign_extended_branch_offset : std_logic_vector(31 downto 0);
	signal rt, rs : std_logic_vector(31 downto 0);

	signal pc : std_logic_vector(31 downto 0);

	signal target_address : std_logic_vector(25 downto 0);

	signal next_pc : std_logic_vector(31 downto 0);

begin
	--blabla to have less bits for board
	rt(1 downto 0) <= rt_in(1) & rt_in(0);
	rt(31 downto 2) <= (others => '0');

	rs(1 downto 0) <= rs_in(1) & rs_in(0);
	rs(31 downto 2) <= (others => '0');

	pc(2 downto 0) <= pc_in(2) & pc_in(1) & pc_in(0);
	pc(31 downto 3) <= (others => '0');

	target_address(2 downto 0) <= target_address_in(2) & target_address_in(1) & target_address_in(0);
	target_address(25 downto 3) <= (others => '0');

	next_pc_out(2 downto 0) <= next_pc(2) & next_pc(1) & next_pc(0);

	sign_extended_branch_offset(31 downto 16) <= (others => target_address(15)); 
	sign_extended_branch_offset(15 downto 0) <= target_address(15 downto 0);

	-- process 1
	pc_select : process(pc_sel, target_address, rs, pc, branch_out, sign_extended_branch_offset)
	begin
		case( pc_sel ) is		
			when "00" => next_pc <= (branch_out AND sign_extended_branch_offset) + pc + 1;
			when "01" => next_pc <= "000000" & target_address;
			when "10" => next_pc <= rs;
			when others => next_pc <= (others => '0');
		end case;
	end process;
		-- proces 2 
	branch_select_process: process(pc, branch_type, rs, rt)
	begin
		case ( branch_type ) is
			-- no branch
			when "00" => branch_out <= (others => '0');
			-- beq
			when "01" =>
				if rs = rt then
					branch_out <= (others => '1');
				else
					branch_out <= (others => '0');
				end if;
			when "10" =>
				if rs /= rt then
					branch_out <= (others => '1');
				else
					branch_out <= (others => '0');
				end if;
			when others =>
				if rs(31) = '1'  then
                    branch_out <= (others => '1');
                else
                    branch_out <= (others => '0');
                end if ;

		end case;
	end process;

end arch;
