module con_ff(
	input [31:0] inst,
	input signed [31:0] bus,
	input ConIn, clk,
	output reg out
);
	wire [3:0] Con_en;
	wire [31:0] reducer;
	initial out = 0;
	
	decoder_4 dec(Con_en, inst[20:19]);
	
	wire eval, eq, neg, gte, lt;
	
	assign eq = ((bus == 0) && Con_en[0]) ? 1'b1 : 1'b0;
	assign neg = ((bus != 0) && Con_en[1]) ? 1'b1 : 1'b0;
	assign gte = ((bus >= 0) && Con_en[2]) ? 1'b1 : 1'b0;
	assign lt = ((bus <= 0) && Con_en[3]) ? 1'b1 : 1'b0;
	
	assign eval = eq | neg | gte | lt;
	
	gen_reg ff(reducer, {31'b0,eval}, ConIn, 1'b0, clk);
	always @(posedge clk)
		out=reducer[0];
endmodule