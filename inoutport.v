module inoutport(
	input OPin, clr, clk, InPortout,
	output[31:0] busInInPort,
	input [31:0] bus
);

wire [31:0] OutPort1;
wire [31:0] IPdataIn;

gen_reg IN(busInInPort, IPDataIn, InPortout, clr, clk);
gen_reg OP(OutPort1, bus, OPin, clr, clk);

endmodule