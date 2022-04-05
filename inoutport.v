module inoutport(
	input OPin, clr, clk, InPortout,
	output[31:0] busInInPort,
	input [31:0] bus,
	output [7:0] sevSegOut
);

wire [31:0] OutPort1;
wire [31:0] IPdataIn;

gen_reg IN(busInInPort, IPDataIn, InPortout, clr, clk);
gen_reg OP(OutPort1, bus, OPin, clr, clk);
Seven_Seg_Display_Out sevSeg(sevSegOut,clk,OutPort1[3:0]);


endmodule