module LOGIC_UNIT #(parameter width = 16)
(
	input wire [width-1:0] A,B,
	input wire clk,reset_n,logic_en,
	output reg [width-1:0] logic_out,
	output reg logic_flag,
	input wire [1:0] ALU_FUN
);

	always @(posedge clk, negedge reset_n)
	begin
		if (~reset_n)
		begin
			logic_out <= 0;
			logic_flag <= 0;
		end
		
		else if (logic_en)
		begin
			case (ALU_FUN)
				2'b00: 
				begin
					logic_out <= A & B;
					logic_flag <= 1'b1;
				end
				2'b01:
				begin
					logic_out <= A | B;
					logic_flag <= 1'b1;
				end
				2'b10:
				begin
					logic_out <= ~(A & B);
					logic_flag <= 1'b1;
				end
				2'b11:
				begin
					logic_out <= ~(A | B);
					logic_flag <= 1'b1;
				end
			endcase
		end
		
		else
		begin
			logic_out <= 0;
			logic_flag <= 0;
		end
	end
	
endmodule

		

	