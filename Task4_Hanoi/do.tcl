clear -all
analyze -sv09 hanoi_logic2.sv
elaborate -top {hanoi_logic2}
clock clk
reset rst
prove -bg -all
