`timescale 1us/1us
module alU_TB ;

	//signals declaration
	reg clk_TB;
	reg [15:0] A_TB,B_TB;
	reg [3:0] ALU_FUN_TB;
	wire [15:0] ALU_OUT_TB;
	wire ARITH_FLAG_TB,LOGIC_FLAG_TB,CMP_FLAG_TB,SHIFT_FLAG_TB;
	
	wire [3:0] flag = {ARITH_FLAG_TB,LOGIC_FLAG_TB,CMP_FLAG_TB,SHIFT_FLAG_TB};
	
	//clock generator
	always #5 clk_TB = ~clk_TB;
	
	//instatiation of DUT
	alU DUT
	(
		.clk(clk_TB),
		.A(A_TB),
		.B(B_TB),
		.ALU_FUN(ALU_FUN_TB),
		.ALU_OUT(ALU_OUT_TB),
		.ARITH_FLAG(ARITH_FLAG_TB),
		.LOGIC_FLAG(LOGIC_FLAG_TB),
		.CMP_FLAG(CMP_FLAG_TB),
		.SHIFT_FLAG(SHIFT_FLAG_TB)
	);
	
	//Test Cases
	initial
		begin 
		$dumpfile ("alU_TB.vcd");
		$dumpvars;
		//initialze the value of inputs
		clk_TB = 0;
		B_TB = 16'h0055;                        //85 in decimal
		A_TB = 16'h00A2;                        //162 in decimal
		
		$display ("Case 1: Addition");
		ALU_FUN_TB = 0;
		#6
		if ((ALU_OUT_TB == 16'd247) & (flag == 4'b1000))
			$display ("case 1 is passed: ALU_OUT_TB = %d + %d = %d",A_TB,B_TB,ALU_OUT_TB);
		else
			$display ("case 1 is not passed: ALU_OUT_TB = %d + %d = %d",A_TB,B_TB,ALU_OUT_TB);
			
		
		#5
		$display ("Case 2: Subtraction");
		ALU_FUN_TB = 4'b0001;
		#5
		if ((ALU_OUT_TB == 16'd77) & (flag == 4'b1000))
			$display ("case 2 is passed: ALU_OUT_TB = %d - %d = %d",A_TB,B_TB,ALU_OUT_TB);
		else
			$display ("case 2 is not passed: ALU_OUT_TB = %d - %d = %d",A_TB,B_TB,ALU_OUT_TB);
			
			
		#5
		$display ("Case 3: Multiplication");
		ALU_FUN_TB = 4'b0010;
		#5
		if ((ALU_OUT_TB == 16'd13770) & (flag == 4'b1000))
			$display ("case 3 is passed: ALU_OUT_TB = %d * %d = %d",A_TB,B_TB,ALU_OUT_TB);
		else
			$display ("case 3 is not passed: ALU_OUT_TB = %d * %d = %d",A_TB,B_TB,ALU_OUT_TB);
			
			
		#5
		$display ("Case 4: Division");
		ALU_FUN_TB = 4'b0011;
		#5
		if ((ALU_OUT_TB == 16'd1) & (flag == 4'b1000))
			$display ("case 4 is passed: ALU_OUT_TB = %d / %d = %d",A_TB,B_TB,ALU_OUT_TB);
		else
			$display ("case 4 is not passed: ALU_OUT_TB = %d / %d = %d",A_TB,B_TB,ALU_OUT_TB);
			
			
		#5
		$display ("Case 5: AND");
		ALU_FUN_TB = 4'b0100;
		#5
		if ((ALU_OUT_TB == 16'd0) & (flag == 4'b0100))
			$display ("case 5 is passed: ALU_OUT_TB = %d & %d = %d",A_TB,B_TB,ALU_OUT_TB);
		else
			$display ("case 5 is not passed: ALU_OUT_TB = %d & %d = %d",A_TB,B_TB,ALU_OUT_TB);
			
			
		#5
		$display ("Case 6: OR");
		ALU_FUN_TB = 4'b0101;
		#5
		if ((ALU_OUT_TB == 16'd247) & (flag == 4'b0100))
			$display ("case 6 is passed: ALU_OUT_TB = %d | %d = %d",A_TB,B_TB,ALU_OUT_TB);
		else
			$display ("case 6 is not passed: ALU_OUT_TB = %d | %d = %d",A_TB,B_TB,ALU_OUT_TB);
			
		
		#5
		$display ("Case 7: NAND");
		ALU_FUN_TB = 4'b0110;
		#5
		if ((ALU_OUT_TB == 16'd65535) & (flag == 4'b0100))
			$display ("case 7 is passed: ALU_OUT_TB = %d ~& %d = %d",A_TB,B_TB,ALU_OUT_TB);
		else
			$display ("case 7 is not passed: ALU_OUT_TB = %d ~& %d = %d",A_TB,B_TB,ALU_OUT_TB);
						
		
		#5
		$display ("Case 8: NOR");
		ALU_FUN_TB = 4'b0111;
		#5
		if ((ALU_OUT_TB == 16'd65288) & (flag == 4'b0100))
			$display ("case 8 is passed: ALU_OUT_TB = %d ~| %d = %d",A_TB,B_TB,ALU_OUT_TB);
		else
			$display ("case 8 is not passed: ALU_OUT_TB = %d ~| %d = %d",A_TB,B_TB,ALU_OUT_TB);
						
		
		#5
		$display ("Case 9: XOR");
		ALU_FUN_TB = 4'b1000;
		#5
		if ((ALU_OUT_TB == 16'd247) & (flag == 4'b0100))
			$display ("case 9 is passed: ALU_OUT_TB = %d ^ %d = %d",A_TB,B_TB,ALU_OUT_TB);
		else
			$display ("case 9 is not passed: ALU_OUT_TB = %d ^ %d = %d",A_TB,B_TB,ALU_OUT_TB);
						
		
		#5
		$display ("Case 10: XNOR");
		ALU_FUN_TB = 4'b1001;
		#5
		if ((ALU_OUT_TB == 16'd65288) & (flag == 4'b0100))
			$display ("case 10 is passed: ALU_OUT_TB = %d ~^ %d = %d",A_TB,B_TB,ALU_OUT_TB);
		else
			$display ("case 10 is not passed: ALU_OUT_TB = %d ~^ %d = %d",A_TB,B_TB,ALU_OUT_TB);
									
		
		#5
		$display ("Case 11: equality");
		ALU_FUN_TB = 4'b1010;
		#5
		if ((ALU_OUT_TB == 16'd1) & (flag == 4'b0010))
			$display ("case 11 is passed: %d equal %d ALU_OUT_TB = %d",A_TB,B_TB,ALU_OUT_TB);
		else
			$display ("case 11 is passed: %d  not equal %d ALU_OUT_TB = %d",A_TB,B_TB,ALU_OUT_TB);
												
		
		#5
		$display ("Case 12: greater");
		ALU_FUN_TB = 4'b1011;
		#5
		if ((ALU_OUT_TB == 16'd2) & (flag == 4'b0010))
			$display ("case 12 is passed: %d is greater than %d ALU_OUT_TB = %d",A_TB,B_TB,ALU_OUT_TB);
		else
			$display ("case 12 is passed: %d is not greater than %d ALU_OUT_TB = %d",A_TB,B_TB,ALU_OUT_TB);
														
		
		#5
		$display ("Case 13: less");
		ALU_FUN_TB = 4'b1100;
		#5
		if ((ALU_OUT_TB == 16'd3) & (flag == 4'b0010))
			$display ("case 13 is passed: %d is less than %d ALU_OUT_TB = %d",A_TB,B_TB,ALU_OUT_TB);
		else
			$display ("case 13 is passed: %d is not less than %d ALU_OUT_TB = %d",A_TB,B_TB,ALU_OUT_TB);
															
		
		#5
		$display ("Case 14: shift right");
		ALU_FUN_TB = 4'b1101;
		#5
		if ((ALU_OUT_TB == 16'd81) & (flag == 4'b0001))
			$display ("case 14 is passed: ALU_OUT_TB = %d >> 1 = %d",A_TB,ALU_OUT_TB);
		else
			$display ("case 14 is not passed: ALU_OUT_TB = %d >> 1 = %d",A_TB,ALU_OUT_TB);
																	
		
		#5
		$display ("Case 15: shift left");
		ALU_FUN_TB = 4'b1110;
		#5
		if ((ALU_OUT_TB == 16'd324) & (flag == 4'b0001))
			$display ("case 15 is passed: %d << 1 = %d",A_TB,ALU_OUT_TB);
		else
			$display ("case 15 is not passed: %d << 1 = %d",A_TB,ALU_OUT_TB);
																		
		
		#5
		$display ("Case 16: NOP");
		ALU_FUN_TB = 4'b1111;
		#5
		if ((ALU_OUT_TB == 16'd0) & (flag == 4'b0000))
			$display ("case 16 is passed: ALU_OUT_TB = %d",ALU_OUT_TB);
		else
			$display ("case 16 is not passed: ALU_OUT_TB = %d",ALU_OUT_TB);
			
			
		#20
		$stop;
		end

endmodule
	