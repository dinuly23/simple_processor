`ifndef __FSM_V
`define __FSM_V


module fsm(clk, rst , change, step, work);
	input clk, rst, change, step;
	output work;
	
	reg [1:0] state;
	reg [1:0] state_step;	
	
	always @(posedge clk)
	begin
		case(state)
		2'b00: state= rst? (change? 2'b01: 2'b00) : (change? 2'b11: 2'b00);  	
		2'b01: state= rst? (change? 2'b01: 2'b00) : (change? 2'b01: 2'b00);
		2'b10: state= rst? (change? 2'b01: 2'b00) : (change? 2'b01: 2'b10);
		2'b11: state= rst? (change? 2'b01: 2'b00) : (change? 2'b11: 2'b10); //w = state[1] , change= state[0]
		endcase
	end
	
	always @(posedge clk)
	begin 
		case(state_step)
		2'b00: state_step= step? 2'b10 : 2'b00;
		2'b01: state_step= step? 2'b01 : 2'b00;
		2'b10: state_step= step? 2'b01 : 2'b00;
		endcase
	end
	
	assign 	work = (state[1] == 1 || state_step == 2'b10) ? 1: 0 ; 
	
endmodule 


`endif // __FSM_V
