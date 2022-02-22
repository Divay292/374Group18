module multiply(
	output[63:0] p,
	input signed [31:0] x,y
);

	reg[2:0] cc[(32/2)-1:0];
	reg[32:0] pp[(32/2)-1:0];
	reg[63:0] spp[(32/2)-1:0];
	reg[63:0] prod;
	wire[32:0] inv_x;
	integer kk,i;
	
	assign inv_x = {~x[31], ~x}+1;
	
	always @(x or y or inv_x)
	begin
			cc[0] = {y[1],y[0],1'b0};
			
			for(kk=1;kk<(32/2);kk=kk+1)
				cc[kk] = {y[2*kk+1],y[2*kk],y[2*kk-1]};
			for(kk=0;kk<(32/2);kk=kk+1)
			begin
				case(cc[kk])
					3'b001,3'b010:pp[kk]={x[32-1],x};
					3'b011:pp[kk]={x,1'b0};
					3'b100:pp[kk]={inv_x[32-1:0],1'b0};
					3'b101,3'b110:pp[kk] = inv_x;
					default:pp[kk]=0;
				endcase
				spp[kk]=$signed(pp[kk]);
				for(i=0;i<kk;i=i+1)
					spp[kk]={spp[kk],2'b00};
				end
				prod=spp[0];
				for(kk=1;kk<(32/2);kk=kk+1)
					prod=prod+spp[kk];
				end
				assign p = prod;
endmodule