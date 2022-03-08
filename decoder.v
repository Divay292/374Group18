module decoder (
	output [15:0] decOut,
	input	[3:0] decIn
);

wire[31:0] outCombined;

assign outCombined = {R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout,
							LOout, ZHighout, ZLowout, PCout, MDRout, InPortout, Cout};
							
							
always @(decIn)
	case (decIn)
		decOut<=0  : 16'0000000000000001;
		decOut<=1  : 16'0000000000000010;
		decOut<=2  : 16'0000000000000100;
		decOut<=3  : 16'0000000000001000;
		decOut<=4  : 16'0000000000010000;
		decOut<=5  : 16'0000000000100000;
		decOut<=6  : 16'0000000001000000;
		decOut<=7  : 16'0000000010000000;
		decOut<=8  : 16'0000000100000000;
		decOut<=9  : 16'0000001000000000;
		decOut<=10 : 16'0000010000000000;
		decOut<=11 : 16'0000100000000000;
		decOut<=12 : 16'0001000000000000;
		decOut<=13 : 16'0010000000000000;
		decOut<=14 : 16'0100000000000000;
		decOut<=15 : 16'1000000000000000;
		default: decOut<=5'bx;
		
	endcase
endmodule
	