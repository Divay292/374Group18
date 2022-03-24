module decoder_4(
	output reg[3:0] decOut,
	input	[1:0] decIn
);
							
							
always @ (decIn)
	begin
		case (decIn)
			0  : decOut<=16'b0000000000000001;
			1  : decOut<=16'b0000000000000010;
			2  : decOut<=16'b0000000000000100;
			3  : decOut<=16'b0000000000001000;
			default: decOut<=16'bx;
		endcase
	end
endmodule