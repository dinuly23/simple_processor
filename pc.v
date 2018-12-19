`ifndef __PC_V
`define __PC_V


module pc(in, out, rst, store, clk);
	input [15:0] in;
	input rst;
	input store;
	input clk;
	output reg [15:0] out;
	always @(posedge clk, posedge rst, posedge store)
	begin
		if(rst) out <= 0;
		else 
		begin
			if(store) out <= in;
		end
	end
endmodule

`endif // __PC_V
