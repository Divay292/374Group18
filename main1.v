module main1(
		input Rin,
		input Rout,
		input	HIin, LOin, PCin, IRin, Yin, InPortout, Zin, conIn, outPortin,
		input HIout, LOout, PCout, MDRout, MDRin, MARin, MDRread, Cout, clk, IncPC, ZLowout, ZHighout, conOut, BAout, Gra, Grb, Grc,
		input [3:0] ALUselect,
		input [31:0] MDatain
		);
		
		wire[63:0] ZReg;
		wire[31:0] bus, IRdata;
		wire clr;
		wire IROut;
		wire [31:0] YData, XData;
		wire [31:0] ZLowData, ZHighData;
		
		wire R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
			  R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out;
		
		wire [31:0]	busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10, busInR11, busInR12, busInR13, busInR14, busInR15, busInPC, busInMAR, busInMDR, busInHI, busInLO, busInZ, busInInPort, busInC;
		
		wire [15:0] genRegIn, genRegOut;
		
		gen_reg r0(R0temp, bus, R0in, clr, clk);

		assign busInR0 = BAout ? 32'bx : busInR0;
		
		gen_reg r1(busInR1, bus, R1in, clr, clk);
		gen_reg r2(busInR2, bus, R2in, clr, clk);
		gen_reg r3(busInR3, bus, R3in, clr, clk);
		gen_reg r4(busInR4, bus, R4in, clr, clk);
		gen_reg r5(busInR5, bus, R5in, clr, clk);
		gen_reg r6(busInR6, bus, R6in, clr, clk);
		gen_reg r7(busInR7, bus, R7in, clr, clk);
		gen_reg r8(busInR8, bus, R8in, clr, clk);
		gen_reg r9(busInR9, bus, R9in, clr, clk);
		gen_reg r10(busInR10, bus, R10in, clr, clk);
		gen_reg r11(busInR11, bus, R11in, clr, clk);
		gen_reg r12(busInR12, bus, R12in, clr, clk);
		gen_reg r13(busInR13, bus, R13in, clr, clk);
		gen_reg r14(busInR14, bus, R14in, clr, clk);
		gen_reg r15(busInR15, bus, R15in, clr, clk);
		
		
		assign genRegIn = {R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in};
		assign genRegOut = {R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out};
		sel_enc selectEncodeLogic(IRdata, Rin, Rout, BAout, Cout, Gra, Grb, Grc, genRegIn, genRegOut, busInC);
		
		con_ff conFF(IRdata, bus, conIn, clk, conOut);
		
		inoutport inOutPort(outPortin, clr, clk, inPortout, busInInPort, bus);
		
		
		
		gen_reg ir(IRdata, bus, IRin, clr, clk);
		pc_reg pc(busInPC, bus, PCin, IncPC, clr, clk);
		//gen_reg pc(busInPC, bus, PCin, clr, clk);
		
		
		//Change these to be *in* the memSubsys
		//gen_reg mar(address, bus, MARin, clr, clk);
		//mdr_reg mdr(busInMDR, MDatain, bus, MDRin, MDRread, clr, clk);
		memSubsys memSys(MARin, busInMDR, MDatain, bus, MDRin, MDRread, memWrite, clr, clk);
		
		gen_reg hi(busInHI, bus, HIin, clr, clk);
		gen_reg lo(busInLO, bus, LOin, clr, clk);
		gen_reg y(YData, bus, Yin, clr, clk);
		z_reg_64 z(busInZ, ZReg, Zin, ZLowout, ZHighout, clr, clk);
		
		//ALU
		alu alu(ALUselect, clk, YData, bus, ZReg, carry);
		
		// Bus
		bus bus_inst(busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10, busInR11,
							busInR12, busInR13, busInR14, busInR15, busInHI, busInLO, busInZ, busInPC, busInMDR, busInInPort, busInC,
							R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout,
							LOout, ZHighout, ZLowout, PCout, MDRout, InPortout, Cout, bus, clk);
endmodule
		
