`ifndef __RF_V
`define __RF_V


module rf(rn1, rn2, wn, rst, w, wd, rd1, rd2, clk);
	input [1:0] rn1, rn2;
	input rst, w;
	input [15:0] wd;
	input [1:0] wn;
	input clk;
	output [15:0] rd1, rd2;
	reg [15:0] r[3:0];
	always @(posedge clk, posedge rst)
	begin
		if(rst) 
		begin		
			r[0] <= 0;
			r[1] <= 0;
			r[2] <= 0;
			r[3] <= 0;
		end
		else 
		begin
			if(w) r[wn] <= wd;
		end
		
	end
	assign rd1 = r[rn1];
	assign rd2 = r[rn2];
endmodule


`endif // __RF_V
