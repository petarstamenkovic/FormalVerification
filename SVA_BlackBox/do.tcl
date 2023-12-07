clear -all
analyze -sv09 bind.sv black_box_checker.sv sv_model.sv
elaborate -top sv_model
#elaborate -vhdl -top and_proc
clock clk
reset rst
prove -bg -all
