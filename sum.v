`ifndef __SUM_V
`define __SUM_V

module sum(in0, in1, out);
	input [15:0] in0, in1;
	output [15:0] out;
	assign out= in0 + in1;
endmodule

`endif // __SUM_V
