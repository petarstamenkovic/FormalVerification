library ieee;
use ieee.std_logic_1164.all;

entity task1 is
port(
	a : in std_logic;
	b : in std_logic;
	c : in std_logic;
	d : in std_logic;
	e : in std_logic;
	f : in std_logic;
	g : in std_logic;
	h : in std_logic;
	clk : in std_logic;
	rst : in std_logic;
	o1 : out std_logic;
	o2 : out std_logic
);
end entity task1;

architecture arch of task1 is
	
	signal d0  :   std_logic_vector(3 downto 0);
	signal d1  :   std_logic_vector(3 downto 0); 
	signal sel :   std_logic_vector(3 downto 0);
	signal o_mux : std_logic;
	signal out_1 : std_logic; 

begin

out_1 <= ((((not a) and (not b) and (not c) and (not e) and (not f)) or 
	 (a and (not b) and (not c) and e and (not f)) or 
	 ((not a) and b and (not c) and (not e) and f) or 
	 (a and b and (not c) and e and f) or 
	 ((not a) and (not b) and c and (not g) and (not h)) or 
	 (a and (not b) and c and  g and (not h)) or
	 ((not a) and b and c and (not g) and h) or
	 (a and b and c and g and h)) and (not d)) or d;
 
D2_4E_1: process(e,f)
begin

	if(e = '0' and f = '0') then
		d0 <= "0001";
	elsif(e = '1' and f = '0') then 
		d0 <= "0010";
	elsif(e = '0' and f = '1') then 
		d0 <= "0100";
	else 
		d0 <= "1000";
	end if;	 
end process; 


D2_4E_2: process(g,h)
begin

	if(g = '0' and h = '0') then
		d1 <= "0001";
	elsif(g = '1' and h = '0') then 
		d1 <= "0010";
	elsif(g = '0' and h = '1') then 
		d1 <= "0100";
	else 
		d1 <= "1000";
	end if;
	 
end process;

MUX16_1 : process(sel,d0,d1) 
begin 
case sel is 
	when "0000" => 
	o_mux <= d0(0);
	when "0001" => 
	o_mux <= d0(1);
	when "0010" =>
	o_mux <= d0(2);
	when "0011" =>
	o_mux <= d0(3);

	when "0100" => 
	o_mux <= d1(0);
	when "0101" => 
	o_mux <= d1(1);
	when "0110" =>
	o_mux <= d1(2);
	when "0111" =>
	o_mux <= d1(3);

	when others =>
	o_mux <= '1';
end case;

end process;

reg : process(clk)
begin 
	if rising_edge(clk) then
		if(rst = '1') then 
			o1 <= '0';
			o2 <= '0';
		else 
			o1 <= o_mux;
			o2 <= out_1;
		end if;
	end if;		
end process;

sel <= d&c&b&a;

end arch;

