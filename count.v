`ifndef __COUNT_V
`define __COUNT_V


module count #(parameter N = 16) (in, out);
	input [N-1:0] in;
	output [N-1:0] out;
	assign out= in +1;
endmodule  


`endif // __COUNT_V
