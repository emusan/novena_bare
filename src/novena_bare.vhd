library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.ALL;

entity novena_bare is
	generic(
		clk_freq: integer := 50_000_000
	);
	port(
		led: out std_logic;
		clk_n: in std_logic;
		clk_p: in std_logic
	);
end novena_bare;

architecture Behavioral of novena_bare is

	signal count_1s: integer range 0 to clk_freq := 0;
	signal enable_led: std_logic := '0';
	signal clk: std_logic;

begin
	IBUFGDS_inst: IBUFGDS generic map(IBUF_LOW_PWR => TRUE,IOSTANDARD => "DEFAULT")
	                      port map ( O => clk, I => clk_p, IB => clk_n );

	process(clk)
	begin
		if(rising_edge(clk)) then
			count_1s <= count_1s + 1;
			if(count_1s = clk_freq) then
				count_1s <= 0;
				enable_led <= not enable_led;
			end if;
		end if;
	end process;

	led <= enable_led;

end Behavioral;
