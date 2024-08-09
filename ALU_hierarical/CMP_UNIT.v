module CMP_UNIT #(parameter width = 16)
(
	input wire [width-1:0] A,B,
	input wire clk,reset_n,cmp_en,
	output reg [1:0] cmp_out,
	output reg cmp_flag,
	input wire [1:0] ALU_FUN
);

	always @(posedge clk, negedge reset_n)
	begin
		if (~reset_n)
		begin
			cmp_out <= 0;
			cmp_flag <= 0;
		end
		
		else if (cmp_en)
		begin
			case (ALU_FUN)
				2'b01: 
				begin
					cmp_out <= (A == B) ? 2'b01 : 2'b00;
					cmp_flag <= 1'b1;
				end
				2'b10:
				begin
					cmp_out <= (A > B) ? 2'b10 : 2'b00;
					cmp_flag <= 1'b1;
				end
				2'b11:
				begin
					cmp_out <= (A < B) ? 2'b11 : 2'b00;
					cmp_flag <= 1'b1;
				end
				default:
				begin
					cmp_out <= 0;
					cmp_flag <= 0;
				end
			endcase
		end
		
		else
		begin
			cmp_out <= 0;
			cmp_flag <= 0;
		end
	end
	
endmodule
