module memSubsys(input MARin, output reg[31:0] busInMDR, input[31:0] MDatain, input[31:0] bus, input MDRin, input read, input write, 
					  input clr, input clk);
	wire[8:0] address;
	wire[31:0] memOut, qMDR;
	gen_reg mar(address, bus, MARin, clr, clk);
	mdr_reg mdr(qMDR, memOut, bus, MDRin, read, clr, clk);
	ram memory(address, clk, qMDR, read, write, memOut);
	always @ (posedge clk)
		begin
			if(read) busInMDR=qMDR;
			else busInMDR=memOut;
		end
endmodule