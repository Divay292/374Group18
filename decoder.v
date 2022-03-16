module decoder(
	output reg[15:0] decOut,
	input	[3:0] decIn
);
							
							
always @ (decIn)
	begin
		case (decIn)
			0  : decOut<=16'b0000000000000001;
			1  : decOut<=16'b0000000000000010;
			2  : decOut<=16'b0000000000000100;
			3  : decOut<=16'b0000000000001000;
			4  : decOut<=16'b0000000000010000;
			5  : decOut<=16'b0000000000100000;
			6  : decOut<=16'b0000000001000000;
			7  : decOut<=16'b0000000010000000;
			8  : decOut<=16'b0000000100000000;
			9  : decOut<=16'b0000001000000000;
			10 : decOut<=16'b0000010000000000;
			11 : decOut<=16'b0000100000000000;
			12 : decOut<=16'b0001000000000000;
			13 : decOut<=16'b0010000000000000;
			14 : decOut<=16'b0100000000000000;
			15 : decOut<=16'b1000000000000000;
			default: decOut<=5'bx;
		endcase
	end
endmodule