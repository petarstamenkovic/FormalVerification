analyze -vhdl2k lut4.vhd
analyze -vhdl2k task2.vhd
analyze -sv09 task2_top.sv
elaborate -top {task2_top}
clock clk
reset rst
prove -bg -all
