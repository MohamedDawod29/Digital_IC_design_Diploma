module RST_SYNC #(parameter NUM_STAGES = 2)
(
	input wire clk, reset_n,
	output reg SYNC_RST
);

	reg [NUM_STAGES-1:0] sync;
	
	always @(posedge clk, negedge reset_n)
	begin
		if (~reset_n)
		begin
			sync <= 'b0;
			SYNC_RST <= 0;
		end
		
		else
		begin
			sync <= {sync[NUM_STAGES-2:0],1'b1};
			SYNC_RST <= sync[NUM_STAGES-1];
		end
	end
	
endmodule 