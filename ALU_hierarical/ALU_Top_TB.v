`timescale 1us/1ns
module ALU_Top_TB #(parameter width = 16);

//Define all signals
	reg [width-1:0] A,B;
	reg[3:0] ALU_FUN;
	reg clk,reset_n;
	wire  [2*width-1:0] Arith_OUT;
	wire  [width-1:0] Logic_OUT,SHIFT_OUT;
	wire [1:0] CMP_OUT;
	wire Carry_OUT,Arith_Flag,CMP_Flag,Logic_Flag,SHIFT_Flag;
	
	wire [3:0] flags = {Arith_Flag,Logic_Flag,CMP_Flag,SHIFT_Flag};
//clock generator
	localparam clk_period = 10;
	localparam clk_high = 6;
	localparam clk_low = 4;
	
	always 
	begin
		#clk_high
		clk = ~clk;
		#clk_low
		clk = ~clk;
	end
	
	
//instatiation the design
	ALU_Top #(.width(width)) DUT
	(
	.A(A),
	.B(B),
	.ALU_FUN(ALU_FUN),
	.clk(clk),
	.reset_n(reset_n),
	.Arith_OUT(Arith_OUT),
	.Logic_OUT(Logic_OUT),
	.CMP_OUT(CMP_OUT),
	.SHIFT_OUT(SHIFT_OUT),
	.Carry_OUT(Carry_OUT),
	.Arith_Flag(Arith_Flag),
	.CMP_Flag(CMP_Flag),
	.Logic_Flag(Logic_Flag),
	.SHIFT_Flag(SHIFT_Flag)
	);
	
	
//Test Cases
	initial 
	begin
		$dumpfile("ALU_Top_TB.vcd");
		$dumpvars;
		
		
		//initial values
		A = 16'b0;
		B = 16'b0;
		ALU_FUN = 4'b0;
		clk = 1'b0;
	   reset_n = 1'b1;
		
		//reset the ALU
		#clk_period
		reset_n = 1'b0;
		#clk_period
		reset_n = 1'b1;
		
		//case 1
		
		$display ("Case 1 is Signed Arithmetic Addition: A is Negative & B is Negative");
		#clk_low
		A = -'d4;
		B = -'d10;
		ALU_FUN = 4'b0;
		
		#clk_high
		if ((Arith_OUT == -'d14) & (flags == 4'b1000))
			$display ("Case 1 is passed");
		else
			$display ("Case 1 is not passed");
			
		
		//case 2
		
		$display ("Case 2 is Signed Arithmetic Addition: A is Positive & B is Negative");
		#clk_low
		A = 'd14;
		B = -'d10;
		ALU_FUN = 4'b0;
		
		#clk_high
		if ((Arith_OUT == 'd4) & (flags == 4'b1000))
			$display ("Case 2 is passed");
		else
			$display ("Case 2 is not passed");
			
			
			
		//case 3
		
		$display ("Case 3 isSigned Arithmetic Addition: A is Negative & B is Positive");
		#clk_low
		A = -'d14;
		B = 'd10;
		ALU_FUN = 4'b0;
		
		#clk_high
		if ((Arith_OUT == -'d4) & (flags == 4'b1000))
			$display ("Case 3 is passed");
		else
			$display ("Case 3 is not passed");
			
			
		//case 4
		
		$display ("Case 4 is Signed Arithmetic Addition: A is Positive & B is Positive");
		#clk_low
		A = 'd14;
		B = 'd10;
		ALU_FUN = 4'b0;
		
		#clk_high
		if ((Arith_OUT == 'd24) & (flags == 4'b1000))
			$display ("Case 4 is passed");
		else
			$display ("Case 4 is not passed");
			
			
		//case 5
		
		$display ("Case 5 is Signed Arithmetic Subtraction: A is Negative & B is Negative");
		#clk_low
		A = -'d14;
		B = -'d10;
		ALU_FUN = 4'b0001;
		
		#clk_high
		if ((Arith_OUT == -'d4) & (flags == 4'b1000))
			$display ("Case 5 is passed");
		else
			$display ("Case 5 is not passed");
		
		
		
		//case 6
		
		$display ("Case 6 is Signed Arithmetic Subtraction: A is Positive & B is Negative");
		#clk_low
		A = 'd14;
		B = -'d10;
		ALU_FUN = 4'b0001;
		
		#clk_high
		if ((Arith_OUT == 'd24) & (flags == 4'b1000))
			$display ("Case 6 is passed");
		else
			$display ("Case 6 is not passed");
		
		
		
		//case 7
		
		$display ("Case 7 is Signed Arithmetic Subtraction: A is Negative & B is Positive");
		#clk_low
		A = -'d14;
		B = 'd10;
		ALU_FUN = 4'b0001;
		
		#clk_high
		if ((Arith_OUT == -'d24) & (flags == 4'b1000))
			$display ("Case 7 is passed");
		else
			$display ("Case 7 is not passed");
			
			
		//case 8
		
		$display ("Case 8 is Signed Arithmetic Subtraction: A is Positive & B is Positive");
		#clk_low
		A = 'd14;
		B = 'd10;
		ALU_FUN = 4'b0001;
		
		#clk_high
		if ((Arith_OUT == 'd4) & (flags == 4'b1000))
			$display ("Case 8 is passed");
		else
			$display ("Case 8 is not passed");
		
		
		
		//case 9
		
		$display ("Case 9 is Signed Arithmetic Multiplication: A is Negative & B is Negative");
		#clk_low
		A = -'d14;
		B = -'d10;
		ALU_FUN = 4'b0010;
		
		#clk_high
		if ((Arith_OUT == 'd140) & (flags == 4'b1000))
			$display ("Case 9 is passed");
		else
			$display ("Case 9 is not passed");
			
			
		
		//case 10
		
		$display ("Case 10 is Signed Arithmetic Multiplication: A is Positive & B is Negative");
		#clk_low
		A = 'd14;
		B = -'d10;
		ALU_FUN = 4'b0010;
		
		#clk_high
		if ((Arith_OUT == -'d140) & (flags == 4'b1000))
			$display ("Case 10 is passed");
		else
			$display ("Case 10 is not passed");
			
			
		//case 11
		
		$display ("Case 11 is Signed Arithmetic Multiplication: A is Negative & B is Positive");
		#clk_low
		A = -'d14;
		B = 'd10;
		ALU_FUN = 4'b0010;
		
		#clk_high
		if ((Arith_OUT == -'d140) & (flags == 4'b1000))
			$display ("Case 11 is passed");
		else
			$display ("Case 11 is not passed");
		
		
		//case 12
		
		$display ("Case 12 is Signed Arithmetic Multiplication: A is Positive & B is Positive");
		#clk_low
		A = 'd14;
		B = 'd10;
		ALU_FUN = 4'b0010;
		
		#clk_high
		if ((Arith_OUT == 'd140) & (flags == 4'b1000))
			$display ("Case 12 is passed");
		else
			$display ("Case 12 is not passed");
		
		
		
		//case 13
		
		$display ("Case 13 is Signed Arithmetic Division: A is Negative & B is Negative");
		#clk_low
		A = -'d20;
		B = -'d10;
		ALU_FUN = 4'b0011;
		
		#clk_high
		if ((Arith_OUT == 'd2) & (flags == 4'b1000))
			$display ("Case 13 is passed");
		else
			$display ("Case 13 is not passed");
		
		
		
		//case 14
		
		$display ("Case 14 is Signed Arithmetic Division: A is Positive & B is Negative");
		#clk_low
		A = 'd20;
		B = -'d10;
		ALU_FUN = 4'b0011;
		
		#clk_high
		if ((Arith_OUT == -'d2) & (flags == 4'b1000))
			$display ("Case 14 is passed");
		else
			$display ("Case 14 is not passed");
			
		
		//case 15
		
		$display ("Case 15 is Signed Arithmetic Division: A is Negative & B is Positive");
		#clk_low
		A = -'d20;
		B = 'd10;
		ALU_FUN = 4'b0011;
		
		#clk_high
		if ((Arith_OUT == -'d2) & (flags == 4'b1000))
			$display ("Case 15 is passed");
		else
			$display ("Case 15 is not passed");
		
		
		//case 16
		
		$display ("Case 16 is Signed Arithmetic Division: A is Positive & B is Positive");
		#clk_low
		A = 'd20;
		B = 'd10;
		ALU_FUN = 4'b0011;
		
		#clk_high
		if ((Arith_OUT == 'd2) & (flags == 4'b1000))
			$display ("Case 16 is passed");
		else
			$display ("Case 16 is not passed");
			
			
		//case 17
		
		$display ("Case 17 is Logical Operation AND");
		#clk_low
		A = 'd4;
		B = 'd5;
		ALU_FUN = 4'b0100;
		
		#clk_high
		if ((Logic_OUT == 'd4) & (flags == 4'b0100))
			$display ("Case 17 is passed");
		else
			$display ("Case 17 is not passed");

		
		
		//case 18
		
		$display ("Case 18 is Logical Operation OR");
		#clk_low
		A = 'd4;
		B = 'd5;
		ALU_FUN = 4'b0101;
		
		#clk_high
		if ((Logic_OUT == 'd5) & (flags == 4'b0100))
			$display ("Case 18 is passed");
		else
			$display ("Case 18 is not passed");
		
		
		
		//case 19
		
		$display ("Case 19 is Logical Operation NAND");
		#clk_low
		A = 'd4;
		B = 'd5;
		ALU_FUN = 4'b0110;
		
		#clk_high
		if ((Logic_OUT == 16'hFFFB) & (flags == 4'b0100))
			$display ("Case 19 is passed");
		else
			$display ("Case 19 is not passed");
		
		
		
		
		//case 20
		
		$display ("Case 20 is Logical Operation NOR");
		#clk_low
		A = 'd4;
		B = 'd5;
		ALU_FUN = 4'b0111;
		
		#clk_high
		if ((Logic_OUT == 16'hFFFA) & (flags == 4'b0100))
			$display ("Case 20 is passed");
		else
			$display ("Case 20 is not passed");
		
		
		
		//case 21
		
		$display ("Case 21 is Compare Operation : Equal");
		#clk_low
		A = 'd4;
		B = 'd5;
		ALU_FUN = 4'b1001;
		
		#clk_high
		if ((CMP_OUT == 'd0) & (flags == 4'b0010))
			$display ("Case 21 is passed");
		else
			$display ("Case 21 is not passed");
		
		
		//case 22
		
		$display ("Case 22 is Compare Operation : Greater");
		#clk_low
		A = 'd10;
		B = 'd5;
		ALU_FUN = 4'b1010;
		
		#clk_high
		if ((CMP_OUT == 'd2) & (flags == 4'b0010))
			$display ("Case 22 is passed");
		else
			$display ("Case 22 is not passed");
			
			
		//case 23
		
		$display ("Case 23 is Compare Operation : Less");
		#clk_low
		A = 'd4;
		B = 'd5;
		ALU_FUN = 4'b1011;
		
		#clk_high
		if ((CMP_OUT == 'd3) & (flags == 4'b0010))
			$display ("Case 23 is passed");
		else
			$display ("Case 23 is not passed");
			
			
			
		//case 24
		
		$display ("Case 24 is Shift Operation : A shift right");
		#clk_low
		A = 'd4;
		B = 'd5;
		ALU_FUN = 4'b1100;
		
		#clk_high
		if ((SHIFT_OUT == 'd2) & (flags == 4'b0001))
			$display ("Case 24 is passed");
		else
			$display ("Case 24 is not passed");
			
		
		//case 25
		
		$display ("Case 25 is Shift Operation : A shift left");
		#clk_low
		A = 'd4;
		B = 'd5;
		ALU_FUN = 4'b1101;
		
		#clk_high
		if ((SHIFT_OUT == 'd8) & (flags == 4'b0001))
			$display ("Case 25 is passed");
		else
			$display ("Case 25 is not passed");
		
			
			
		//case 26
		
		$display ("Case 26 is Shift Operation : B shift right");
		#clk_low
		A = 'd4;
		B = 'd5;
		ALU_FUN = 4'b1110;
		
		#clk_high
		if ((SHIFT_OUT == 'd2) & (flags == 4'b0001))
			$display ("Case 26 is passed");
		else
			$display ("Case 26 is not passed");
			
			
			
			
		//case 27
		
		$display ("Case 27 is Shift Operation : B shift left");
		#clk_low
		A = 'd4;
		B = 'd5;
		ALU_FUN = 4'b1111;
		
		#clk_high
		if ((SHIFT_OUT == 'd10) & (flags == 4'b0001))
			$display ("Case 27 is passed");
		else
			$display ("Case 27 is not passed");
			
			
			
		//case 28
		
		$display ("Case 27 is NOP");
		#clk_low
		A = 'd4;
		B = 'd5;
		ALU_FUN = 4'b1000;
		
		#clk_high
		if (flags == 4'b0000)
			$display ("Case 28 is passed");
		else
			$display ("Case 28 is not passed");	
	
	#clk_period
	$stop;
	end

endmodule

		