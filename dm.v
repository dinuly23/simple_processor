`ifndef __DM_V
`define __DM_V

module dm(id, addr, w, od, clk);
	input [15:0] id, addr;
	input w, clk;
	output [15:0] od;
	reg [15:0] r[15:0]; //можно больше
	always @(posedge clk)
	begin
		if(w) r[addr] <= id;
	end
	assign od = r[addr];
endmodule


`endif // __DM_V
