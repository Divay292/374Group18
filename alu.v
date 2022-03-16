module alu(
			input [3:0] select,
			input clk,
			input signed [31:0] A,
			input signed [31:0] B,
			output [63:0] Z,
			output carry
);

wire [63:0] mult_res;
wire[31:0] ror_res, rol_res;
reg [31:0] RLo, RHi;
initial RHi = 32'b00000000000000000000000000000000;
initial RLo = 32'b00000000000000000000000000000000;
assign Z = {RHi, RLo};


multiply mult(mult_res,A,B);
rotate_right ror(ror_res,A,B);
rotate_left rol(rol_res,A,B);


always @ (posedge clk)
begin
		RHi <= RHi;
		case(select)
				4'b0001:
						RLo <= A+B;
				4'b0010:
						RLo <= A-B;
				4'b0011:
						begin
							RLo <= mult_res[31:0];
							RHi <= mult_res[63:32];
						end
				4'b0101:
						begin
							RHi <= A%B;
							RLo <= (A-RHi)/B;
						end
				4'b0110:
						RLo <= A & B;
				4'b0111:
						RLo <= A|B;
				4'b1000:
						RLo <= ~B+1;
				4'b1001:
						RLo <= B;
				4'b1010:
						RLo <= ~B;
				4'b1100:
						RLo <= A<<B;
				4'b1101:
						RLo <= A>>B;
				4'b1110:
						RLo <= rol_res;
				4'b1111:
						RLo <= ror_res;
				default:
						RLo <= RLo;
			endcase
		end
endmodule
