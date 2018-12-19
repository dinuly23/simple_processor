`ifndef __MAIN_V
`define __MAIN_V



`include "alu.v"
`include "dm.v"
`include "rf.v"
`include "pc.v"
`include "im.v"
`include "ext0.v"
`include "ext01.v"
`include "count.v"
`include "sum.v"
`include "mux.v"

module main(clk, rst, store,  wrf, wdm, op, sIn1_Alu, sIn2_Alu, sWn_Rf, sWd_Rf, sRn2_Rf, sIn0_Mux, sIn_Pc, im_out, zero , sExt10);
	input clk, rst, wrf, wdm, store;
	input sIn1_Alu, sIn2_Alu, sWn_Rf, sWd_Rf, sRn2_Rf, sIn0_Mux, sIn_Pc, sExt10;
	input [3:0] op;
	output zero;

	wire [15:0] pc_count_im, mux_pc, mux_mux, ext0_mux, sum_mux, count_mux_sum, ext01_sum_mux;
	output [15:0] im_out; // im_out[15:10]-opcode, im_out[9:8]-t, im_out[7:6]-s1, im_out[5:4]-s2, im_out[3:0]-funct   for AR
			    // im_out[15:10]-opcode, im_out[9:8]-t, im_out[7:6]-s, im_out[5:0]-IMM                      for AI (sign, unsign)
			    // im_out[15:10]-opcode, im_out[9:8]-s1, im_out[7:6]-s2, im_out[5:0]-IMM                    for BI (sign)
			    // im_out[15:10]-opcode, im_out[9:8]-t, im_out[7:6]-s, im_out[5:0]-IMM                      for MI (sign) 
			    // im_out[15:10]-opcode, im_out[9:0]-ADDR                                                   for J
	wire [1:0] mux_wn_Rf, mux_rn2_Rf;	
	wire [15:0] mux_wd_Rf, rd1_Rf_mux_dm, rd2_Rf_mux ;	
	wire [15:0] alu_out, dm_out;
	wire [15:0] mux_in2_Alu, mux_in1_Alu;

	alu _alu(.in1(mux_in1_Alu), .in2(mux_in2_Alu), .op(op), .out(alu_out), .zero(zero)); //+ zero, op
	dm  _dm(.id(rd2_Rf_mux), .addr(alu_out), .w(wdm), .od(dm_out), .clk(clk)); //+ w (rd1->addr)
	rf _rf(.rn1(im_out[7:6]), .rn2(mux_rn2_Rf), .wn(mux_wn_Rf), .rst(rst), .w(wrf), .wd(mux_wd_Rf), .rd1(rd1_Rf_mux_dm), .rd2(rd2_Rf_mux), .clk(clk)); //+ rst, w : (->s1)AR, (->s)AI, (->s2)BI, (->s)MI
	pc _pc(.in(mux_pc), .out(pc_count_im), .rst(rst), .store(store), .clk(clk)); //+ rst, store 
	im _im(.addr(pc_count_im), .com(im_out)); //+
	ext0 _ext0( .in(im_out[9:0]), .out(ext0_mux)); //+ ->opcode
	ext01 _ext01( .in(im_out[5:0]), .out(ext01_sum_mux), .select(sExt10));//+ ->IMM, 
	count #(.N(16)) _count(.in(pc_count_im), .out(count_mux_sum)); //+
	sum  _sum(.in0(count_mux_sum), .in1(ext01_sum_mux), .out(sum_mux)); //+
	mux  #(.N(16)) _mux_Alu1(.in0(rd1_Rf_mux_dm), .in1(rd2_Rf_mux), .select(sIn1_Alu), .out(mux_in1_Alu));//+
	mux  #(.N(16)) _mux_Alu2(.in0(rd2_Rf_mux), .in1(ext01_sum_mux), .select(sIn2_Alu), .out(mux_in2_Alu));//+ 
	mux  #(.N(2)) _mux_Rf2(.in0(im_out[5:4]), .in1(im_out[9:8]), .select(sWn_Rf), .out(mux_wn_Rf));//+ 1(w=1) (->s2, ->t)AR , 1(w=1) (X, ->t)AI, 1(w=0)(X, ->s1)BI, 1(w=1 lw) (w=0 sw) (X, ->t)MI
	mux  #(.N(2)) _mux_Rf1(.in0(im_out[5:4]), .in1(im_out[9:8]), .select(sRn2_Rf), .out(mux_rn2_Rf)); //+ 0(w=1) (->s2, ->t)AR , 1(w=1) (X, ->t)AI, 1(w=0)(X, ->s1)BI, 1(w=1 lw) (w=0 sw) (X, ->t)MI
	mux  #(.N(16)) _mux_Rf_wd(.in0(alu_out), .in1(dm_out), .select(sWd_Rf), .out(mux_wd_Rf)); //+
	mux  #(.N(16)) _mux_Count(.in0(count_mux_sum), .in1(sum_mux), .select(sIn0_Mux), .out(mux_mux)); //+
	mux  #(.N(16)) _mux_Mux(.in0(mux_mux), .in1(ext0_mux), .select(sIn_Pc), .out(mux_pc)); // +
	
endmodule

`endif // __MAIN_V
