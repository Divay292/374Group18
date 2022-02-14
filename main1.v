module main1(
		input R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
		input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
		input	HIin, LOin, PCin, IRin, Yin, InPortout, Zin,
		input HIout, LOout, PCout, MDRout, MDRin, MARin, MDRread, Cout, clk, IncPC, ZLowout, ZHighout,
		input [3:0] ALUselect,
		input [31:0] Mdatain,
		
		output R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15,
		output [63:0] ZReg
		);
		
		wire[31:0] bus;
		wire clr;
		wire IROut;
		wire [31:0] YData, XData;
		wire [31:0] ZLowData, ZHighData;
		
		wire [31:0]	busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10, busInR11, busInR12, busInR13, busInR14, busInR15, busInPC, busInMAR, busInMDR, busInHI, busInLO, busInZHI, busInZLO, busInInPort, busInC;
						
		gen_reg r0(busInR0, bus, R0in, clr, clk);
		gen_reg r1(busInR1, bus, R1in, clr, clk);
		gen_reg r2(busInR2, bus, R2in, clr, clk);
		gen_reg r3(busInR3, bus, R3in, clr, clk);
		gen_reg r4(busInR4, bus, R4in, clr, clk);
		gen_reg r5(busInR5, bus, R5in, clr, clk);
		gen_reg r6(busInR6, bus, R6in, clr, clk);
		gen_reg r7(busInR7, bus, R7in, clr, clk);
		gen_reg r8(busInR8, bus, R8in, clr, clk);
		gen_reg r9(busInR9, bus, R9in, clr, clk);
		gen_reg r10(busInR0, bus, R10in, clr, clk);
		gen_reg r11(busInR0, bus, R11in, clr, clk);
		gen_reg r12(busInR0, bus, R12in, clr, clk);
		gen_reg r13(busInR0, bus, R13in, clr, clk);
		gen_reg r14(busInR0, bus, R14in, clr, clk);
		gen_reg r15(busInR0, bus, R15in, clr, clk);
		
		gen_reg ir(IRout, bus, IRin, clr, clk);
		pc_reg pc(busInPC, bus, PCin, IncPC, clr, clk);
		
		gen_reg mar(busInMAR, bus, MARin, clr, clk);
		mdr_reg mdr(busInMDR, Mdatain, bus, MDRin, MDRread, clr, clk);
		
		gen_reg hi(busInHI, bus, HIin, clr, clk);
		gen_reg lo(busInLO, bus, LOin, clr, clk);
		gen_reg y(Ydata, bus, Yin, clr, clk);
		z_reg_64 z(ZHighData, ZLowData, ZReg, Zin, ZLowout, ZHighout, clr, clk);
		
		//ALU
		alu alu(ALUselect ,bus, Ydata, ZLowData, ZHighData, carry);
		assign busInZHI = ZReg[63:0];
		assign busInZLO = ZReg[31:0];
		// Bus
		bus bus_inst(bus, busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10, busInR11,
							busInR12, busInR13, busInR14, busInR15, busInHI, busInLO, busInZHI, busInZLO, busInPC, busInMDR, busInInPort, busInPC,
							R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout,
							LOout, ZHighout, ZLowout, PCout, MDRout, InPortout, Cout);
endmodule
		
