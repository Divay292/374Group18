module z_reg_64 (
			output reg [31:0] Z, 
			input [63:0] D,
			input ZIn, ZLowOut, ZHighOut, clr, clk
);

reg[63:0] ZData;

initial ZData = 0;
	
always @(clk, D)
	begin
		if(clr)
			begin
				Z<=64'h0000000000000000;
			end
		else if(ZIn)
			begin
				ZData<=D;
			end
		if(ZLowOut)
			begin
				Z<=ZData[31:0];
			end
		else if(ZHighOut)
			begin
				Z<=ZData[63:32];
			end
	end
endmodule
				/*if(ZLowOut)
					ZLowData=D[31:0];
				else if(ZHighOut)
					ZHighData=D[63:32];*/