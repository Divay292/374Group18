module pc_reg(
			output reg [31:0] Q,
			input [31:0] D,
			input wr, inc, clr, clk
);
			initial Q=0;
always @(posedge clk)
	begin
			if(clr)
				Q = 0;
			else if(wr)
				Q = D;
			else if(inc)
				Q = Q+1;
	end
endmodule
