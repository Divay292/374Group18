module bus_enc(
	input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout,
							LOout, ZHighout, ZLowout, PCout, MDRout, InPortout, Cout,
	output reg[4:0] encoded,
	input clk
	);
	
	wire[31:0] outCombined;
	
	assign outCombined = {R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout,
							LOout, ZHighout, ZLowout, PCout, MDRout, InPortout, Cout};
	
	
	always @ (outCombined, clk)
		casez (outCombined)
			32'b???????????????????????????????1	:	encoded<=0;
			32'b??????????????????????????????1?	:	encoded<=1;
			32'b?????????????????????????????1??	:	encoded<=2;
			32'b????????????????????????????1???	:	encoded<=3;
			32'b???????????????????????????1????	:	encoded<=4;
			32'b??????????????????????????1?????	:	encoded<=5;
			32'b?????????????????????????1??????	:	encoded<=6;
			32'b????????????????????????1???????	:	encoded<=7;
			32'b???????????????????????1????????	:	encoded<=8;
			32'b??????????????????????1?????????	:	encoded<=9;
			32'b?????????????????????1??????????	:	encoded<=10;
			32'b????????????????????1???????????	:	encoded<=11;
			32'b???????????????????1????????????	:	encoded<=12;
			32'b??????????????????1?????????????	:	encoded<=13;
			32'b?????????????????1??????????????	:	encoded<=14;
			32'b????????????????1???????????????	:	encoded<=15;
			32'b???????????????1????????????????	:	encoded<=16;
			32'b??????????????1?????????????????	:	encoded<=17;
			32'b?????????????1??????????????????	:	encoded<=18;
			32'b????????????1???????????????????	:	encoded<=19;
			32'b???????????1????????????????????	:	encoded<=20;
			32'b??????????1?????????????????????	:	encoded<=21;
			32'b?????????1??????????????????????	:	encoded<=22;
			32'b????????1???????????????????????	:	encoded<=23;
			default											:	encoded<=5'bx;
		endcase		
		
endmodule