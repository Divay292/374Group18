`timescale 1ns/10ps
module datapath_tb;

	reg Rin;
	
	reg Rout;
	
	reg HIin, LOin, PCin, IRin, Yin, InPortout, Zin, conIn;
	
	reg HIout, LOout, PCout, MDRout, MDRin, MARin, MDRread, Cout, clk, IncPC, ZLowout, ZHighout;
	
	reg conOut, BAout, Gra, Grb, Grc;
	
	reg[3:0] ALUselect;
	reg[31:0] MDatain;
	reg Read;

	parameter	Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011 ,Reg_load2b = 4'b0100,
					Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011,
					T5 = 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
					
	reg[3:0] Present_state = Default;
	
	main1 DUT (.Rin(Rin), .Rout(Rout), .HIin(HIin), .LOin(LOin), .PCin(PCin), .IRin(IRin), .Yin(Yin), .InPortout(InPortout),
				  .Zin(Zin), .conIn(conIn), .outPortin(outPortin), .HIout(HIout), .LOout(LOout), .PCout(PCout), .MDRout(MDRout), .MDRin(MDRin), .MARin(MARin), .MDRread(Read), .Cout(Cout), .clk(clk), .IncPC(IncPC),
				  .ZLowout(ZLowout), .ZHighout(ZHighout), .conOut(conOut), .BAout(BAout), .Gra(Gra), .Grb(Grb), .Grc(Grc), .ALUselect(ALUselect), .MDatain(MDatain));

initial
				begin
						clk = 0;
						forever #5 clk = ~clk;
				end
				
				
always @(posedge clk)
			begin
					case(Present_state)
								Default		:	#40	Present_state = T0;
								Reg_load1a	:	#40	Present_state = Reg_load1b;
								Reg_load1b	:	#40	Present_state = Reg_load2a;
								Reg_load2a	:	#40	Present_state = Reg_load2b;
								Reg_load2b	:	#40	Present_state = Reg_load3a;
								Reg_load3a	:	#40	Present_state = Reg_load3b;
								Reg_load3b	:	#40	Present_state = T0;
								
								T0			   :	#40	Present_state = T1;
								T1				:	#40	Present_state = T2;
								T2				:	#40	Present_state = T3;
								T3				:	#40	Present_state = T4;
								T4				:	#40	Present_state = T5;
								T5				:	#40	Present_state = T6;
								T6				:	#40	Present_state = T7;
					endcase
			end
			
always @(Present_state)
			begin
					case(Present_state)
							Default:begin
											Rout <=0; Rin <=0;
											HIout <=0; LOout <=0; InPortout <=0; Cout <=0;
											LOin <=0; HIin <=0;
											PCout <=0; ZLowout <=0; ZHighout <=0; MDRout <=0;
											MARin <=0; Zin <=0;
											PCin <=0; MDRin <=0; IRin <=0; Yin <=0;
											IncPC <=0; Read <=0; ALUselect <=0;
											MDatain<=32'h00000000;
			end
			/*Reg_load1a:begin
									Read = 0; MDRin = 0;
									//MDatain <= 32'h00000022;		//For everything except ror, rol
									MDatain <= 32'h80000022;		//For ror, rol
									#10 Read <= 1; MDRin <= 1;
									#15 Read <= 0; MDRin <= 0;
			end
			Reg_load1b: begin  
                          #10 MDRout <= 1; R2in <= 1;   
								  #15 MDRout <= 0; R2in <= 0;     // initialize R2 with the value $22           
			end 
			Reg_load2a: begin   
								  //MDatain <= 32'h00000024; 		//Everything except div, shr, shl, ror, rol
								  MDatain <= 32'h00000003;			//For div, shr, shl, ror, rol
								  #10 Read <= 1; MDRin <= 1;   
								  #15 Read <= 0; MDRin <= 0;       
			end 
			Reg_load2b: begin  
                          #10 MDRout <= 1; R4in <= 1;   
								  #15 MDRout <= 0; R4in <= 0;  // initialize R4 with the value $24 (3 for division)
			end 
		  Reg_load3a: begin   
								 MDatain <= 32'h00000026; 
								#10 Read <= 1; MDRin <= 1;   
								#15 Read <= 0; MDRin <= 0; 
			end 
        Reg_load3b: begin  
                            #10 MDRout <= 1; R5in <= 1;   
               #15 MDRout <= 0; R5in <= 0;  // initialize R5 with the value $26           
			end*/
			//ld	R1, $85				:	8388693
			//ld	R0, $35(R1)			:	524323
 
 
			T0: begin #5 PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1; ALUselect <= 4'b1001;
						 #30 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0; ALUselect <= 4'b0000; end
			
			T1: begin #5 ZLowout <= 1; PCin <= 1; Read <=1; MDRin <=1;
						 #30 ZLowout <= 0; PCin <= 0; Read <=0; MDRin <=0; end
			
			T2: begin #5 MDRout <= 1; IRin <=1;
						 #30 MDRout <= 0; IRin <=0; end
			
			//ld
			T3: begin #5 Grb <= 1; BAout <= 1; Yin <= 1;
						 #30 Grb <= 0; BAout <= 0; Yin <= 0; end
			
			T4: begin #5 Cout <= 1; ALUselect <= 4'b0001; Zin <= 1;
						 #30 Cout <= 0; ALUselect <= 4'b0000; Zin <= 0; end
			
			T5: begin #5 ZLowout <= 1; MARin <= 1;
						 #30 ZLowout <= 0; MARin <= 0; end
			
			T6: begin #5 Read <= 1; MDRin <= 1;
						 #30 Read <= 0; MDRin <= 0; end
			
			T7: begin #5 MDRout <= 1; Gra <= 1; Rin <= 1;
						 #30 MDRout <= 0; Gra <= 0; Rin <= 0; end
       endcase 
    end 
endmodule  