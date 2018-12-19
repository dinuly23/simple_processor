`ifndef __MIPS_V
`define __MIPS_V

`include "main.v"
`include "control.v"


module mips(clk, rst, work);
	input clk, rst, work;
	
	wire [3:0] op;
	wire [15:0] im_out; 
	wire store, wrf, wdm, sIn1_Alu, sIn2_Alu, sWn_Rf, sWd_Rf, sRn2_Rf, sIn0_Mux, sIn_Pc, zero, sExt10; 
	
	wire new_clk;
	
	assign new_clk = work? clk : 0;
	main _main(.clk(new_clk), .rst(rst), .store(store),  .wrf(wrf), .wdm(wdm), .op(op), 
						.sIn1_Alu(sIn1_Alu), .sIn2_Alu(sIn2_Alu), .sWn_Rf(sWn_Rf), 
						.sWd_Rf(sWd_Rf), .sRn2_Rf(sRn2_Rf), .sIn0_Mux(sIn0_Mux), .sIn_Pc(sIn_Pc), 
						.im_out(im_out) , .zero(zero), .sExt10(sExt10));
		
	control _control(.clk(new_clk), .rst(rst), .store(store),  .wrf(wrf), .wdm(wdm), .op(op), 
						.sIn1_Alu(sIn1_Alu), .sIn2_Alu(sIn2_Alu), .sWn_Rf(sWn_Rf), 
						.sWd_Rf(sWd_Rf), .sRn2_Rf(sRn2_Rf), .sIn0_Mux(sIn0_Mux), .sIn_Pc(sIn_Pc), 
						.im_out(im_out) , .zero(zero), .sExt10(sExt10));
	
endmodule 



`endif // __MIPS_V
