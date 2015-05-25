library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity novena_bare is
	Port ( clk_n : in  STD_LOGIC;
	       clk_p : in  STD_LOGIC;
	       ledA : out  STD_LOGIC;
	       ledB : out  STD_LOGIC;
	       ledC : out  STD_LOGIC;
	       ledD : out  STD_LOGIC);
end novena_bare;

architecture Behavioral of novena_bare is
	signal clk: STD_LOGIC;
	signal counter: STD_LOGIC_VECTOR(31 downto 0) :=(others => '0');
begin
	IBUFGDS_inst : IBUFGDS
                generic map (
                                    IBUF_LOW_PWR => TRUE,
                                    IOSTANDARD => "DEFAULT"
                            )

                port map (
                                 O => clk, -- clock buffer output
                                 I => clk_p,       -- diff_p clock buffer input
                                 IB => clk_n      -- diff_n clock buffer input
                         );

	process(clk)
	begin
		if rising_edge(clk) then
			if counter(31) = '1' then
				counter <= (others => '0'); -- reset counter if bit 31 is set
			else
				counter <= std_logic_vector(unsigned(counter) + 1); -- increase counter if not
			end if;
		end if;
	end process;
	

        ledA <= counter(25);
	ledB <= NOT counter(26);
	ledC <= counter(27);
	ledD <= NOT counter(28);
end Behavioral;
