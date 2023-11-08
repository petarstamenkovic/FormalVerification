analyze -vhdl2k task3.vhd
analyze -sv09 task3_top.sv
elaborate -top {task3_top}
clock clk
reset rst
prove -bg -all
