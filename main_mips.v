`include "mips.v"
`include "fsm.v"


module main_mips(clk, rst, change, step);
	input clk, rst, change, step;
	wire work;
	fsm _fsm(.clk(clk), .rst(rst) , .change(change), .step(step), .work(work));
	mips _mips(.clk(clk), .rst(rst) , .work(work));

endmodule

