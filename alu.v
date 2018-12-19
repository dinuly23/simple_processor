`ifndef __ALU_V
`define __ALU_V

`include "funct.vh"



module alu(in1, in2, op, out, zero);
	input [15:0] in1, in2;
	input [3:0] op;
	output reg [15:0] out;
	output zero;
	always @(*)
	begin
		case(op)
		`FUNCT_ADD: out <= in1 + in2;  
		`FUNCT_SUB: out <= in1 - in2;
		`FUNCT_AND: out <= in1 & in2; 
		`FUNCT_OR:  out <= in1 | in2; 
		`FUNCT_SLTU: out <= (in1 > in2)? 1 : 0;
		`FUNCT_SLT:  out <= ($signed(in1) > $signed(in2))? 1 : 0;
		default: out <= 1;
		endcase	
	end
	assign zero = (out==0)? 1: 0;
endmodule 

`endif // __ALU_V
