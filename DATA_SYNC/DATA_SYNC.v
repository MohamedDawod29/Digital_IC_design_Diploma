module DATA_SYNC #(parameter NUM_STAGES = 2, BUS_WIDTH = 8)
(
	input wire clk, reset_n,
	input wire bus_enable,
	input wire [BUS_WIDTH-1:0] unsync_bus,
	output reg enable_pulse,
	output reg [BUS_WIDTH-1:0] sync_bus
);

	// synchronizer of bus_enable
	
	reg [NUM_STAGES-1:0] sync;
	
	always @(posedge clk, negedge reset_n)
	begin
		if (~reset_n)
			sync <= 'b0;
		else
			sync <= {sync [NUM_STAGES-2:0],bus_enable};
	end
	
	// pulse generator
	
	reg p_gen,PulseGen;
	
	always @(posedge clk, negedge reset_n)
	begin
		if (~reset_n)
			p_gen <= 1'b0;
		else
			p_gen <= sync[NUM_STAGES-1];
	end
	
	// enable pulse
	
	always @(*)
	begin
		PulseGen = (!p_gen) && (sync[NUM_STAGES-1]);
	end
	
	always @(posedge clk, negedge reset_n)
	begin
		if (~reset_n)
			enable_pulse <= 0;
		else
			enable_pulse <= PulseGen;
	end
	
	// sync_bus
	
	always @(posedge clk, negedge reset_n)
	begin
		if (~reset_n)
			sync_bus <= 'b0;
		else
			sync_bus <= (PulseGen) ? unsync_bus : sync_bus;
	end
	
endmodule
			
