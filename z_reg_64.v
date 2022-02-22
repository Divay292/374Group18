module z_reg_64 (
			output reg [31:0] Z, //********This is bad, these aren't connected to anything, so the bus never sees anything it's outputting
			input [63:0] D,//                               make a single 32bit output for the bus, and find a way to store 64 bits and just choose between based on control signals
			input ZIn, ZLowOut, ZHighOut, clr, clk
);

reg[63:0] ZData;
	
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