module sel_enc(
	input [31:0] instr,
	input Rin, Rout, BAout, Gra, Grb, Grc,
	output [15:0] ctrl_in, ctrl_out
);

	wire [3:0] ra, rb, rc, decIn;
	assign ra = instr[26:23];
	assign rb = instr[22:19];
	assign rc = instr[18:15];
	
	assign decIn = Gra ? ra :
						Grb ? rb :
						Grc ? rc :
						4'b0000;
						
	wire [15:0] decOut;
	decoder dec(decOut, decIn);
	
	wire Rout_en;
	assign Rout_en = BAout | Rout;
	assign ctrl_in = Rin ? decOut : 16'b0;
	assign ctrl_out = Rout_en ? decOut : 16'b0;
	
endmodule
