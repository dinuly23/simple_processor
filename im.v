`ifndef __IM_V
`define __IM_V

module im(addr, com);
	input [15:0] addr;
	output [15:0] com;
	reg [15:0] prog[15:0]; //можно больше
	
	assign com = prog[addr];
endmodule


`endif // __IM_V
