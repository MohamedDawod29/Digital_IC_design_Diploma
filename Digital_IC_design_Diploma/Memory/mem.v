module mem #(parameter ADDR_WIDTH = 4, MEM_DEPTH = 8, MEM_WIDTH = 16)
(
	input wire WR_EN,clk,
	input wire [ADDR_WIDTH - 1:0] address,
	input wire [MEM_WIDTH - 1:0] data_in,
	output reg [MEM_WIDTH - 1:0] data_out
);


	reg [MEM_WIDTH - 1:0] MEM [MEM_DEPTH - 1:0];
	
	always @(posedge clk)
	begin
		if (WR_EN)
			MEM [address] <= data_in;	
		else
			data_out <= MEM [address];
	end

endmodule
