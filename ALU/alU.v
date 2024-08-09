module alU 
(
	input wire clk,
	input wire [15:0] A,B,
	input wire [3:0] ALU_FUN ,
	output reg [15:0] ALU_OUT,
	output reg ARITH_FLAG,LOGIC_FLAG,CMP_FLAG,SHIFT_FLAG
);

	reg [15:0] ALU_OUT_next;

	always @(posedge clk)
		begin
			ALU_OUT <= ALU_OUT_next;
		end
		
	always @(*)
		begin
			ALU_OUT_next = 16'h0000;
			case (ALU_FUN)
				4'b0000:  ALU_OUT_next = A + B;                                       //Arithmatic : unsigned Addition
				4'b0001:  ALU_OUT_next = A - B;                                       //Arithmatic : unsigned Subtraction   
				4'b0010:  ALU_OUT_next = A * B;                                       //Arithmatic : unsigned Multiplication 0010
				4'b0011:  ALU_OUT_next = A / B;                                       //Arithmatic : unsigned Division	
				4'b0100:  ALU_OUT_next = A & B;                                       //Logic AND 
				4'b0101:	 ALU_OUT_next = A | B;                                       //Logic OR 
				4'b0110:  ALU_OUT_next = ~(A & B);                                    //Logic NAND 
				4'b0111:	 ALU_OUT_next = ~(A | B);                                    //Logic NOR 
				4'b1000:	 ALU_OUT_next = A ^ B;                                       //Logic XOR 
				4'b1001:	 ALU_OUT_next = ~(A ^ B);                                    //Logic XNOR 
				4'b1010:  ALU_OUT_next = (A == B)? 16'h0001:16'h0000;                 //CMP: A = B
				4'b1011:  ALU_OUT_next = (A > B)? 16'h0002:16'h0000;						 //CMP: A > B
				4'b1100:	 ALU_OUT_next = (A < B)? 16'h0003:16'h0000;                  //CMP: A < B
				4'b1101:  ALU_OUT_next = A >> 1;                                      //SHIFT: A >> 1
				4'b1110:  ALU_OUT_next = A << 1;                                      //SHIFT: A << 1
				default:  ALU_OUT_next = 16'h0000;
			endcase
		end
		
	always @(*)
		begin
			ARITH_FLAG = 1'b0;
			LOGIC_FLAG = 1'b0;
			CMP_FLAG = 1'b0;
			SHIFT_FLAG = 1'b0;
			case (ALU_FUN)
				4'b0000:  ARITH_FLAG = 1'b1; 
				4'b0001:  ARITH_FLAG = 1'b1;
				4'b0010:  ARITH_FLAG = 1'b1;
				4'b0011:  ARITH_FLAG = 1'b1;
				4'b0100:  LOGIC_FLAG = 1'b1;
				4'b0101:	 LOGIC_FLAG = 1'b1;
				4'b0110:  LOGIC_FLAG = 1'b1; 
				4'b0111:	 LOGIC_FLAG = 1'b1;
				4'b1000:	 LOGIC_FLAG = 1'b1;
				4'b1001:	 LOGIC_FLAG = 1'b1;
				4'b1010:  CMP_FLAG = 1'b1;
				4'b1011:  CMP_FLAG = 1'b1;
				4'b1100:	 CMP_FLAG = 1'b1;
				4'b1101:  SHIFT_FLAG = 1'b1;
				4'b1110:  SHIFT_FLAG = 1'b1;
				default: 
					begin
						ARITH_FLAG = 1'b0;
						LOGIC_FLAG = 1'b0;
						CMP_FLAG = 1'b0;
						SHIFT_FLAG = 1'b0;
					end
			endcase
		end
		
endmodule
