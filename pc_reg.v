module pc_reg(
			output reg [31:0] Q,
			input [31:0] D,
			input wr, conFFwr, conFFen, inc, clr, clk
);
			initial Q=0;
			reg incHelp, wrHelp;
			initial incHelp=0;
			initial wrHelp=0;
always @(posedge clk)
	begin
			if(inc)
				incHelp <= 1;
			if(wr)
				begin
					Q <= D;
					wrHelp <= 1;
				end
			if(!wr && wrHelp)
				begin
					wrHelp <= 0;
					if(incHelp)
						begin
							incHelp <= 0;
							Q <= Q+1;
						end
				end
			if(conFFen && conFFwr)
				Q <= D;
			if(clr)
				Q <= 0;
	end
endmodule
