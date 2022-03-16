module bus(
	input [31:0] busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10, busInR11,
					 busInR12, busInR13, busInR14, busInR15, busInHI, busInLO, busInZ, busInPC, busInMDR, busInInPort, busInC,
	input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout,
							LOout, ZHighout, ZLowout, PCout, MDRout, InPortout, Cout,
	output [31:0] bus,
	input clk
	);
	
	wire[4:0] intermediate;
	
	
	bus_enc encoder(R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out,
							R15out, HIout, LOout, ZHighout, ZLowout, PCout, MDRout, InPortout, Cout, intermediate,clk);
	
	bus_mux multiplexer(busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10, busInR11,
					 busInR12, busInR13, busInR14, busInR15, busInHI, busInLO, busInZ, busInPC, busInMDR, busInInPort, busInC,
					 intermediate, bus,clk);
		
		
		
endmodule