module ALU_Top #(parameter width = 16)
(
	input wire [width-1:0] A,B,
	input wire [3:0] ALU_FUN,
	input wire clk,reset_n,
	output  [2*width-1:0] Arith_OUT,
	output  [width-1:0] Logic_OUT,SHIFT_OUT,
	output [1:0] CMP_OUT,
	output Carry_OUT,Arith_Flag,CMP_Flag,Logic_Flag,SHIFT_Flag
);

	wire [3:0] Enables;
	
	decod B0 
	(
	.ALU_FUN(ALU_FUN[3:2]),
	.Enables(Enables)
	);
	
	ARITH_UNIT #(.width(width)) B1
	(
	.A(A),
	.B(B),
	.clk(clk),
	.reset_n(reset_n),
	.arith_en(Enables[3]),
	.arith_out(Arith_OUT),
	.arith_flag(Arith_Flag),
	.carry_out(Carry_OUT),
	.ALU_FUN(ALU_FUN[1:0])
	);
	
	LOGIC_UNIT #(.width(width)) B2
	(
	.A(A),
	.B(B),
	.clk(clk),
	.reset_n(reset_n),
	.logic_en(Enables[2]),
	.logic_out(Logic_OUT),
	.logic_flag(Logic_Flag),
	.ALU_FUN(ALU_FUN[1:0])
	);
	
	CMP_UNIT #(.width(width)) B3
	(
	.A(A),
	.B(B),
	.clk(clk),
	.reset_n(reset_n),
	.cmp_en(Enables[1]),
	.cmp_out(CMP_OUT),
	.cmp_flag(CMP_Flag),
	.ALU_FUN(ALU_FUN[1:0])
	);
	
	SFIT_UNIT #(.width(width)) B4
	(
	.A(A),
	.B(B),
	.clk(clk),
	.reset_n(reset_n),
	.shift_en(Enables[0]),
	.shift_out(SHIFT_OUT),
	.shift_flag(SHIFT_Flag),
	.ALU_FUN(ALU_FUN[1:0])
	);
	
endmodule
