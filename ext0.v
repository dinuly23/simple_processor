`ifndef __EXT0_V
`define __EXT0_V


module ext0( in, out);
	input [9:0] in;
	output [15:0] out;
	assign out[9:0]= in;
	assign out[15:10]= 6'b0;
endmodule 

`endif // __EXT0_V
