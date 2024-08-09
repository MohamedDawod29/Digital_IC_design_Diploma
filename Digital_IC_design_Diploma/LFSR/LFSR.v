module LFSR 
(
	input wire clk,reset,
	output reg [7:0] LFSR,
	input wire [7:0] seed,
	input wire enable,out_enable,
	output reg valid,
	output reg OUT
);

	wire feedback;
	localparam [7:1] decide = 7'b1010101;
	integer i;
	
	assign feedback = LFSR[7] ^ (~|LFSR[6:0]);
	
	always @(posedge clk or negedge reset)
	begin
		if (~reset)
		begin
			LFSR <= seed;
			valid <= 1'b0;
			OUT <= 1'b0;
		end
		
		else if (enable)
		begin
			LFSR [0] <= feedback;
			for (i = 7; i >= 1; i = i - 1)
				if (decide[i] == 1)
					LFSR [i] <= LFSR [i-1] ^ feedback;
				else
					LFSR [i] <= LFSR [i-1];
		end
		
		else if (out_enable)
		begin
			{LFSR[6:0],OUT} <= LFSR;
			valid <= 1'b1;
		end
	end
	
endmodule

			
			