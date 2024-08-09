module decod 
(
	input wire[1:0] ALU_FUN,
	output reg [3:0] Enables	
);

	
	always @(*)
	begin
		case (ALU_FUN)
			2'b00: Enables = 4'b1000;
			2'b01: Enables = 4'b0100;
			2'b10: Enables = 4'b0010;
			2'b11: Enables = 4'b0001;	
		endcase
	end
	
endmodule
