`include "asm.vh"
`include "mips.v"
`include "main_mips.v"

module test;
	reg clk, rst, change, step;
	main_mips _main_mips(.clk(clk), .rst(rst), .change(change), .step(step));
	
	initial clk=0; 
	initial change=0;
	initial step=0;
	always #4 clk =!clk;


	initial _main_mips._fsm.state = 2'b00;
	initial _main_mips._fsm.state_step = 2'b00;
	initial _main_mips._mips._main._im.prog[0] = `ASM_ADDIU(2'b00, 2'b11, 6'b000001); 
	initial _main_mips._mips._main._im.prog[1] = `ASM_ADDIU(2'b01, 2'b11, 6'b001000);
	initial _main_mips._mips._main._im.prog[2] = `ASM_ADDIU(2'b10, 2'b11, 6'b000010);
	initial _main_mips._mips._main._im.prog[3] = `ASM_ADD(2'b00, 2'b01, 2'b10); 
	initial _main_mips._mips._main._im.prog[4] = `ASM_SUB(2'b00, 2'b01, 2'b10); 
	initial _main_mips._mips._main._im.prog[5] = `ASM_SW(2'b00, 2'b10, 6'b000000); 
	initial _main_mips._mips._main._im.prog[6] = `ASM_LW(2'b11, 2'b10, 6'b000000); 
	initial _main_mips._mips._main._im.prog[7] = `ASM_BEQ(2'b11, 2'b00, 6'b000001);
	initial _main_mips._mips._main._im.prog[8] = `ASM_ADD(2'b00, 2'b01, 2'b01); 
	initial _main_mips._mips._main._im.prog[9] = `ASM_SUB(2'b00, 2'b01, 2'b10); 
	initial _main_mips._mips._main._im.prog[10] = `ASM_ADDI(2'b00, 2'b10, 6'b111111);
	initial _main_mips._mips._main._im.prog[11] = `ASM_J(10'b0);
	initial
	begin
		#4
		rst =1;
		#4
		rst = 0;
		change = 0;
		#4 change = 1;
		//work
		#4 change = 0;
		#8 change = 1;
		//don't work
		#8 step = 0;
		#4 step = 1;
		//work one instruction
		#8 change = 0;
		#4 change = 1;
		//work
		#8 step = 0;
		#4 step = 1;
		//step doesn't affect
		#240
		$finish;
	end	
	initial $monitor(_main_mips._mips._main._rf.r[0],_main_mips._mips._main._rf.r[1],_main_mips._mips._main._rf.r[2],_main_mips._mips._main._rf.r[3], _main_mips._mips._main._dm.r[2],  _main_mips._mips._main._dm.r[6],  _main_mips._mips._main._dm.r[4], _main_mips._mips._main._im.prog[4][15:10] );
	initial 
	begin
		$dumpfile("dump");
		$dumpvars(0,test);
	end
endmodule
