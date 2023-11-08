analyze -vhdl2k "task1.vhd"
analyze -sv09 task1_top.sv
elaborate -top {task1_top}
clock clk
reset rst
prove -bg -all
