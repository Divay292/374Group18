module OutPort(
	input clr, clk, InPortout,
	output OutportOut,
	input [31:0] busMuxOut,
);

reg [31:0] OutPort1;
wire [31:0] IPdataIn, busInInPort, bus;

gen_reg IN(busInInPort, IPDataIn, InPortout, clr, clk);
gen_reg OP(OutPort1, bus, OPin, clr, clk);

endmodule
