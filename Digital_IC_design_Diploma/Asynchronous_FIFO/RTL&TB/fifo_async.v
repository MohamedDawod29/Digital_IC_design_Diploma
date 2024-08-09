module fifo_async #(parameter width = 8, depth = 8, n = $clog2 (depth))
(
	input wire wclk,
	input wire [n:0] waddr,raddr,
	input wire winc, wfull,
	input wire [width-1:0] wdata,
	output wire [width-1:0] rdata
);

	reg [width-1:0] mem [depth-1:0];

	always @(posedge wclk)
	begin
		if (winc && !wfull)
			mem [waddr[n-1:0]] <= wdata;
	end
	
	assign rdata = mem [raddr[n-1:0]];
	
endmodule
