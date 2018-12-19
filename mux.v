`ifndef __MUX_V
`define __MUX_V

module mux #(parameter N = 16) (in0, in1, select, out);
	input [N-1:0] in0, in1;
	input select;
	output [N-1:0] out; 
	assign out= select? in1: in0;
endmodule

`endif // __MUX_V
