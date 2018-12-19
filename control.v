`ifndef __CONTROL_V
`define __CONTROL_V
`include "opcodes.vh"
`include "funct.vh"


module control(clk, rst, store, wrf, wdm, op, sIn1_Alu, sIn2_Alu, sWn_Rf, sWd_Rf, sRn2_Rf, sIn0_Mux, sIn_Pc, im_out,  zero, sExt10);
	input clk, rst, work;
	input zero;
	input [15:0] im_out;
	output reg store;
	output reg  [3:0] op;
	output reg wrf, wdm,sIn1_Alu, sIn2_Alu, sWn_Rf, sWd_Rf, sRn2_Rf, sIn0_Mux, sIn_Pc, sExt10; 

	wire [5:0] opcode;
	wire [3:0] func;
	assign opcode = im_out[15:10];
	assign func = im_out[3:0];
	
	always @(*)
	begin 
		store = 1;
		case(opcode)
		`OPCODE_AR: 
			begin 
				op = func;								
				wrf = 1; 
				wdm = 0; //x				
				sIn1_Alu = 0;
				sIn2_Alu = 0; 
				sWn_Rf = 1; 
				sWd_Rf = 0;
				sRn2_Rf = 0; 
				sIn0_Mux = 0; 
				sIn_Pc = 0; 
				sExt10 =0; //x
			end 
		`OPCODE_ADDIU: 
			begin 
				op = `FUNCT_ADD;								
				wrf = 1; 
				wdm = 0; //x				
				sIn1_Alu = 0;
				sIn2_Alu = 1; 
				sWn_Rf = 1; 
				sWd_Rf = 0;
				sRn2_Rf = 1; 
				sIn0_Mux = 0; 
				sIn_Pc = 0; 
				sExt10 = 0; 
			end
		`OPCODE_ADDI: 
			begin 
				op = `FUNCT_ADD; //ext01 signal 								
				wrf = 1; 
				wdm = 0; //x				
				sIn1_Alu = 0;
				sIn2_Alu = 1; 
				sWn_Rf = 1; 
				sWd_Rf = 0;
				sRn2_Rf = 1; 
				sIn0_Mux = 0; 
				sIn_Pc = 0;
				sExt10 = 1; 
			end
		`OPCODE_ANDIU: 
			begin 
				op = `FUNCT_AND;								
				wrf = 1; 
				wdm = 0; //x				
				sIn1_Alu = 0;
				sIn2_Alu = 1; 
				sWn_Rf = 1; 
				sWd_Rf = 0;
				sRn2_Rf = 1; 
				sIn0_Mux = 0; 
				sIn_Pc = 0; 
				sExt10 = 0;
			end
		`OPCODE_ANDI: 
			begin 
				op = `FUNCT_AND;								
				wrf = 1; 
				wdm = 0; //x				
				sIn1_Alu = 0;
				sIn2_Alu = 1; 
				sWn_Rf = 1; 
				sWd_Rf = 0;
				sRn2_Rf = 1; 
				sIn0_Mux = 0; 
				sIn_Pc = 0; 
				sExt10 = 1;
			end
		`OPCODE_ORIU: 
			begin 
				op = `FUNCT_OR;								
				wrf = 1; 
				wdm = 0; //x				
				sIn1_Alu = 0;
				sIn2_Alu = 1; 
				sWn_Rf = 1; 
				sWd_Rf = 0;
				sRn2_Rf = 1; 
				sIn0_Mux = 0; 
				sIn_Pc = 0; 
				sExt10 = 0;
			end
		`OPCODE_ORI: 
			begin 
				op = `FUNCT_OR;								
				wrf = 1; 
				wdm = 0; //x				
				sIn1_Alu = 0;
				sIn2_Alu = 1; 
				sWn_Rf = 1; 
				sWd_Rf = 0;
				sRn2_Rf = 1; 
				sIn0_Mux = 0; 
				sIn_Pc = 0;
				sExt10 = 1; 
			end
		`OPCODE_SLTIU: 
			begin 
				op = `FUNCT_SLTU;								
				wrf = 1; 
				wdm = 0; //x				
				sIn1_Alu = 0;
				sIn2_Alu = 1; 
				sWn_Rf = 1; 
				sWd_Rf = 0;
				sRn2_Rf = 1; 
				sIn0_Mux = 0; 
				sIn_Pc = 0; 
				sExt10 = 0;
			end
		`OPCODE_SLTI: 
			begin 
				op = `FUNCT_SLT;								
				wrf = 1; 
				wdm = 0; //x				
				sIn1_Alu = 0;
				sIn2_Alu = 1; 
				sWn_Rf = 1; 
				sWd_Rf = 0;
				sRn2_Rf = 1; 
				sIn0_Mux = 0; 
				sIn_Pc = 0;
				sExt10 = 1; 
			end
		`OPCODE_BEQ: 
			begin 
				op = `FUNCT_SUB;
				wrf = 0; //x 
				wdm = 0; //x				
				sIn1_Alu = 0;
				sIn2_Alu = 0; 
				sWn_Rf = 1; 
				sWd_Rf = 0; //x
				sRn2_Rf = 1; 
				sIn0_Mux = zero; 
				sIn_Pc = 0; 
				sExt10 = 0;
			end
		`OPCODE_BNE: 
			begin 
				op = `FUNCT_SUB;								
				wrf = 0; //x 
				wdm = 0; //x				
				sIn1_Alu = 0;
				sIn2_Alu = 0; 
				sWn_Rf = 1; 
				sWd_Rf = 0; //x
				sRn2_Rf = 1; 
				sIn0_Mux = ~zero; 
				sIn_Pc = 0;
				sExt10 = 0; 
			end
		`OPCODE_LW: 
			begin 
				op = `FUNCT_ADD;								
				wrf = 1; 
				wdm = 0; //x				
				sIn1_Alu = 0;
				sIn2_Alu = 1; 
				sWn_Rf = 1; 
				sWd_Rf = 1;
				sRn2_Rf = 1; //x 
				sIn0_Mux = 0; 
				sIn_Pc = 0;
				sExt10 = 0; 
			end
		`OPCODE_SW: 
			begin 
				op = `FUNCT_ADD;								
				wrf = 0; 
				wdm = 1;
				sIn1_Alu = 0; //
				sIn2_Alu = 1; //
				sWn_Rf = 1;  
				sWd_Rf = 1; 
				sRn2_Rf = 1; 
				sIn0_Mux = 0; 
				sIn_Pc = 0;
				sExt10 = 0; 
			end
		`OPCODE_J: 
			begin 
				op = `FUNCT_ADD;								
				wrf = 0; //x
				wdm = 0; //x				
				sIn1_Alu = 0; //x
				sIn2_Alu = 0; //x
				sWn_Rf = 1; //x
				sWd_Rf = 0; //x
				sRn2_Rf = 0; //x
				sIn0_Mux = 0; //x 
				sIn_Pc = 1; 
				sExt10 = 0;
			end
		default:  ;
		endcase
	end

endmodule

`endif // __CONTROL_V
