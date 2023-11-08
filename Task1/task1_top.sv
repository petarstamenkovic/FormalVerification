module task1_top (
	input logic a,
	input logic b,
	input logic c,
	input logic d,
	input logic e,
	input logic f,
	input logic g,
	input logic h,
	input logic clk,
	input logic rst,
	output logic o1,
	output logic o2	
);

	task1 uufv
	(
	.a(a),
	.b(b),
	.c(c),	
	.d(d),
	.e(e),
	.f(f),
	.g(g),
	.h(h),
	.clk(clk),
	.rst(rst),
	.o1(o1),
	.o2(o2)
	);	
	
	property my_assert;
		@(posedge clk) o1 == o2;
	endproperty

	assert property (my_assert);
endmodule
