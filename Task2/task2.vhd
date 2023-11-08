library ieee;
use ieee.std_logic_1164.all;

entity task2 is 
port(
	a :   in std_logic;
	b :   in std_logic;
	c :   in std_logic;
	d :   in std_logic;
	e :   in std_logic;
	f :   in std_logic;
	clk : in std_logic;
	rst : in std_logic;
	o1 :  out std_logic;
	o2 :  out std_logic
);
end entity task2;

architecture arch of task2 is 
	signal sel : std_logic_vector(2 downto 0);
	signal mux_out : std_logic;
	signal lut1_out,lut2_out,lut3_out,lut4_out : std_logic;

begin 

reg : process(clk,rst)
begin 
	if rising_edge(clk) then
		if(rst = '1') then 
		    o1 <= '0';
		    o2 <= '0';
		else 
		    o1 <= mux_out;
		    o2 <= lut4_out;
		end if;
	end if;
end process;

mux : process(sel,b,c,a)
begin 
	case sel is 
	  when "000" => 
	  mux_out <= b;
	  when "001" => 
	  mux_out <= b;
	  when "010" => 
	  mux_out <= c;
	  when "011" => 
	  mux_out <= a;
	  when "100" =>
	  mux_out <= '1';
	  when "101" =>
	  mux_out <= '0';
	  when "110" =>
	  mux_out <= '1';
	  when others =>
	  mux_out <= '0';
	end case;

end process;

lut1 : entity work.lut4
generic map(INIT => "0101001101010000")
port map(

	I0 => f,
	I1 => e,
	I2 => d,
	I3 => b,
	O  => lut1_out
);

lut2 : entity work.lut4
generic map(INIT => "0000010000000000")
port map(

	I0 => f,
	I1 => e,
	I2 => d,
	I3 => c,
	O  => lut2_out
);

lut3 : entity work.lut4
generic map(INIT => "0000100000000000")
port map(

	I0 => f,
	I1 => e,
	I2 => d,
	I3 => a,
	O  => lut3_out
);

lut4 : entity work.lut4
generic map(INIT => "1111111111111110")
port map(

	I0 => lut2_out,
	I1 => lut1_out,
	I2 => lut3_out,
	I3 => '0',
	O  => lut4_out
);

sel <= d & e & f;
end arch;

