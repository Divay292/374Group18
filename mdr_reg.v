module mdr_reg(out, MdataIn, bus, en, rd, clr, clk);
output reg [31:0] out;
input [31:0] MdataIn, bus;
input en, rd, clr, clk;
wire [31:0] in;

initial out = 0;

always @(posedge clk)
			if(clr)
				out=0;
			else if(en)
				if(rd)
					out = MdataIn;
			else
					out = bus;
			

endmodule