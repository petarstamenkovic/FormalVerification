library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is 
port(
    clk : in std_logic;
    rst : in std_logic;

    rt1,rdy1,start1,endd1 :                out std_logic; -- case 1 
    er2 :                                  out std_logic; -- case 2
    er3, rdy3 :                            out std_logic; -- case 3
    rdy4,start4 :                          out std_logic; -- case 4
    endd5,stop5,er5,rdy5,start5 :          out std_logic; -- case 5
    endd6,stop6,er6,rdy6 :                 out std_logic; -- case 6 
    endd7,start7,status_valid7,instartsv7 : out std_logic; -- case 7
    rt8,enable8 :                          out std_logic; -- case 8
    rdy9,start9,interrupt9 :               out std_logic; -- case 9
    ack10,req10 :                          out std_logic  -- case 10
);
end entity counter;

architecture rtl of counter is 
    signal count : std_logic_vector(15 downto 0);
begin 

counter: process(clk,rst)
begin 
    if(rising_edge(clk)) then 
        if(rst = '1') then 
            count <= 0;
        else 
            count <= count + std_logic_vector(to_unsigned(1));
        end if;
    end if;            

end process;

-- Case 1 
if((count < 4) or (count = 8)) then 
    rt1 <= '1';
else 
    rt1 <= '0';
end if;

rdy1 <= '1' when (count = 5) else 
        '0';

start1 <= '1' when (count = 8) else 
        '0';

endd1 <= '1' when (count = 6) else 
        '0';

-- Case 2
er2 <= '1' when (count >= 1 and count < 3) or (count >= 6 and count < 10) else 
       '0';

-- Case 3
er3 <= '1' when (count = 1) or (count >= 5 and count < 7) or (count = 9) else 
       '0';

rdy3 <= '1' when (count >= 1 and count < 3) or (count = 5) or (count = 9) else 
       '0';

-- Case 4
rdy4 <= '1' when (count = 6) else 
        '0';

start4 <= '1' when (count = 2) else 
        '0';

-- Case 5
endd5 <= '1' when (count = 2) else
         '0';

stop5 <= '0';

er5 <= '1' when (count = 11) else 
       '0';

rdy5 <= '1' when (count >= 1 and count < 3) or (count >= 8 and count < 11) else 
       '0';

start5 <= '1' when (count = 8) else 
        0';

-- Case 6
endd6 <= '1' when (count = 2) else 
         '0';

stop6 <= '1' when (count = 5) else 
         '0';

er6 <= '1' when (count = 10) else 
         '0';  

rdy6 <= '1' when (count >= 1 and count < 3) or (count >= 4 and count < 7) or (count >= 9 and count < 11) else 
        '0';

-- Case 7
endd7 <= '1' when (count = 3) else 
         '0';

start7 <= '1' when (count = 5) else 
         '0';

status_valid7 <= '1' when (count = 10) else 
                 '0';

instartsv7 <= '1' when (count >= 3 and count < 8) else 
              '0';

-- Case 8
rt8 <= '1' when (count >= 0 and count < 3) else 
       '0';

enable8 <= '1' when (count = 7) else 
           '0';

-- Case 9
rdy9 <= '1' when (count >= 2 and count < 8) else 
        '0';

start9 <= '1' when (count >= 5 and count < 8) else 
        '0';

interrupt9 <= '1' when (count = 8) else 
              '0';

-- Case 10
ack10 <= '1' when (count = 6) else 
       '0';

req10 <= '1' when (count = 1) else 
       '0';


end rtl;
