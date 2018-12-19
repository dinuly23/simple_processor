`ifndef __EXT01_V
`define __EXT01_V


module ext01( in, out, select);
	input [5:0] in;
	output [15:0] out;
	input select;
	assign out[5:0]= in;
	assign out[15:6]= select? ((in[5]==0) ? 10'b0 : 10'b1111111111) : 10'b0;
endmodule 

`endif // __EXT01_V
