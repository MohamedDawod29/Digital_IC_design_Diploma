module SFIT_UNIT #(parameter width = 16)
(
	input wire [width-1:0] A,B,
	input wire clk,reset_n,shift_en,
	output reg [width-1:0] shift_out,
	output reg shift_flag,
	input wire [1:0] ALU_FUN
);

	always @(posedge clk, negedge reset_n)
	begin
		if (~reset_n)
		begin
			shift_out <= 0;
			shift_flag <= 0;
		end
		
		else if (shift_en)
		begin
			case (ALU_FUN)
				2'b00: 
				begin
					shift_out <= A >> 1;
					shift_flag <= 1'b1;
				end
				2'b01:
				begin
					shift_out <= A << 1;
					shift_flag <= 1'b1;
				end
				2'b10:
				begin
					shift_out <= B >> 1;
					shift_flag <= 1'b1;
				end
				2'b11:
				begin
					shift_out <= B << 1;
					shift_flag <= 1'b1;
				end
			endcase
		end
		
		else
		begin
			shift_out <= 0;
			shift_flag <= 0;
		end
	end
	
endmodule

		

	