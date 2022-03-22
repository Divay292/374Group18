module sel_enc(
	input [31:0] instr,
	input Rin, Rout, BAout, Cout, Gra, Grb, Grc,
	output [15:0] ctrl_in, ctrl_out,
	output reg[31:0] c_sign_extended
);

	wire [3:0] ra, rb, rc, decIn;
	assign ra = instr[26:23];
	assign rb = instr[22:19];
	assign rc = instr[18:15];
	
	always @ (instr)
		begin
			c_sign_extended[17:0] = instr[17:0];
			if (instr[18])
				begin
					c_sign_extended[31:18] = 14'b11111111111111;
				end
			else
				begin
					c_sign_extended[31:18] = 14'b00000000000000;
				end
		end
	assign decIn = Gra ? ra :
						Grb ? rb :
						Grc ? rc :
						4'b0000;
						
	wire [15:0] decOut;
	decoder dec(decOut, decIn);
	
	wire Rout_en;
	assign Rout_en = BAout | Rout;
	assign ctrl_in = Rin ? decOut : 16'b0000000000000000;
	assign ctrl_out = Rout_en ? decOut : 16'b0000000000000000;
	
endmodule