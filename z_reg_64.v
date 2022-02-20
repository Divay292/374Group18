module z_reg_64 (
			output reg [31:0] ZHighData, ZLowData,
			input [63:0] D,
			input ZIn, ZLowOut, ZHighOut, clr, clk
);
	
always @(posedge clk)
	if(clr)
		begin
			ZHighData=32'h00000000;
			ZLowData=32'h00000000;
	end
	else if(ZIn)
			begin
				if(ZLowOut)
					ZLowData=D[31:0];
				else if(ZHighOut)
					ZHighData=D[63:32];
			end
endmodule
