module main1(
		input Rin,
		input Rout,
		input	HIin, LOin, PCin, IRin, Yin, InPortout, Zin, conIn, outPortin, R15ctrl,
		input HIout, LOout, PCout, MDRout, MDRin, MARin, MDRread, memWrite, Cout, clk, IncPC, ZLowout, ZHighout, conOut, BAout, Gra, Grb, Grc,
		input [3:0] ALUselect,
		input [31:0] MDatain,
		output [31:0] IRdata,
		output [7:0] sevSegOut
		);
		
		wire[63:0] ZReg;
		wire[31:0] bus, PCtemp;
		wire clr;
		wire IROut, R15in;
		wire [31:0] YData, XData;
		wire [31:0] ZLowData, ZHighData;
			
		wire [31:0]	R0temp, busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10, busInR11, busInR12, busInR13, busInR14, busInR15, busInPC, busInMAR, busInMDR, busInHI, busInLO, busInZ, busInInPort, busInC;
		
		wire [15:0] genRegIn, genRegOut;
		
		ctrl_unit ctrl(Gra1, Grb1, Grc1, Rin1, Rout1, MDRin1, MDRout1, BAout1, Cout1, ZLowout1, PCin1, IRin1, HIout1, LOout1,
								InPortout1, outPortin1, LOin1, ZHighout1, HIin1, Yin1, Zin1, PCout1, IncPC1, MARin1, read1, wren1, clr1, conIn1, Run1,
								ALUselect1, IRdata1, clk1, reset1, stp1, conOut1);
		
		
		
		gen_reg r0(R0temp, bus, genRegIn[0], clr, clk);

		assign busInR0 = BAout ? 32'b0 : R0temp;
		
		gen_reg r1(busInR1, bus, genRegIn[1], clr, clk);
		gen_reg r2(busInR2, bus, genRegIn[2], clr, clk);
		gen_reg r3(busInR3, bus, genRegIn[3], clr, clk);
		gen_reg r4(busInR4, bus, genRegIn[4], clr, clk);
		gen_reg r5(busInR5, bus, genRegIn[5], clr, clk);
		gen_reg r6(busInR6, bus, genRegIn[6], clr, clk);
		gen_reg r7(busInR7, bus, genRegIn[7], clr, clk);
		gen_reg r8(busInR8, bus, genRegIn[8], clr, clk);
		gen_reg r9(busInR9, bus, genRegIn[9], clr, clk);
		gen_reg r10(busInR10, bus, genRegIn[10], clr, clk);
		gen_reg r11(busInR11, bus, genRegIn[11], clr, clk);
		gen_reg r12(busInR12, bus, genRegIn[12], clr, clk);
		gen_reg r13(busInR13, bus, genRegIn[13], clr, clk);
		gen_reg r14(busInR14, bus, genRegIn[14], clr, clk);
		gen_reg r15(busInR15, bus, R15ctrl, clr, clk);
		
		assign R15in = genRegIn[15] | R15ctrl;
		
		sel_enc selectEncodeLogic(IRdata, Rin, Rout, BAout, Cout, Gra, Grb, Grc, genRegIn, genRegOut, busInC);
		
		con_ff conFF(IRdata, bus, conIn, clk, conFFOut);
		inoutport inOutPort(outPortin, clr, clk, inPortout, busInInPort, bus, sevSegOut);
		
		
		
		gen_reg ir(IRdata, bus, IRin, clr, clk);
		pc_reg pc(busInPC, bus, PCin, conOut, conFFOut, IncPC, clr, clk);

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
							genRegOut[0], genRegOut[1], genRegOut[2], genRegOut[3], genRegOut[4], genRegOut[5], genRegOut[6], genRegOut[7], genRegOut[8],
							genRegOut[9], genRegOut[10], genRegOut[11], genRegOut[12], genRegOut[13], genRegOut[14], genRegOut[15], HIout,
							LOout, ZHighout, ZLowout, PCout, MDRout, InPortout, Cout, bus, clk);
endmodule
		
