module bus_mux(
	input [31:0] busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10, busInR11,
					 busInR12, busInR13, busInR14, busInR15, busInHI, busInLO, busInZ, busInPC, busInMDR, busInInPort, busInC,
	input [4:0] encoded,
	output reg [31:0] bus,
	input clk
);

	always @ (encoded, clk)
		case (encoded)
		23	:	bus<=busInR0;
		22	:	bus<=busInR1;
		21	:	bus<=busInR2;
		20	:	bus<=busInR3;
		19	:	bus<=busInR4;
		18	:	bus<=busInR5;
		17	:	bus<=busInR6;
		16	:	bus<=busInR7;
		15	:	bus<=busInR8;
		14	:	bus<=busInR9;
		13	:	bus<=busInR10;
		12	:	bus<=busInR11;
		11	:	bus<=busInR12;
		10	:	bus<=busInR13;
		9	:	bus<=busInR14;
		8	:	bus<=busInR15;
		7	:	bus<=busInHI;
		6	:	bus<=busInLO;
		5	:	bus<=busInZ;
		4	:	bus<=busInZ;
		3	:	bus<=busInPC;
		2	:	bus<=busInMDR;
		1	:	bus<=busInInPort;
		0	:	bus<=busInC;
		default	:	bus<=31'bx;
		endcase

endmodule