module ARITH_UNIT #(parameter width = 16)
(
	input wire signed [width-1:0] A,B,
	input wire clk,reset_n,arith_en,
	output reg signed [2*width-1:0] arith_out,
	output reg arith_flag,carry_out,
	input wire [1:0] ALU_FUN
);

	always @(posedge clk, negedge reset_n)
	begin
		if (~reset_n)
		begin
			arith_out <= 0;
			arith_flag <= 0;
			carry_out <= 0;
		end
		
		else if (arith_en)
		begin
			case (ALU_FUN)
				2'b00: 
				begin
					{carry_out,arith_out} <= A + B;
					arith_flag <= 1'b1;
				end
				2'b01:
				begin
					{carry_out,arith_out} <= A - B;
					arith_flag <= 1'b1;
				end
				2'b10:
				begin
					{carry_out,arith_out} <= A * B;
					arith_flag <= 1'b1;
				end
				2'b11:
				begin
					{carry_out,arith_out} <= A / B;
					arith_flag <= 1'b1;
				end
			endcase
		end
		
		else
		begin
			arith_out <= 0;
			arith_flag <= 0;
			carry_out <= 0;
		end
	end
	
endmodule

		