module wfull #(parameter depth = 8, n = $clog2 (depth))
(
	input wire wclk,wrst_n,
	input wire winc,
	input wire [n:0] wq2_rptr,
	output reg [n:0] waddr,
	output wire [n:0] wptr,
	output wire wfull
);

	always @(posedge wclk, negedge wrst_n)
	begin
		if (~wrst_n)
			waddr <= 'b0;
		else if (winc && !wfull)
			waddr <= waddr + 1;	
	end
	
	//synchronization
	
	reg [n:0] sync0,sync1;
	wire [n:0] sync_wq2_rptr;
	
	always @(posedge wclk, negedge wrst_n)
	begin
		if (~wrst_n)
		begin
			sync0 <= 0;
			sync1 <= 0;
		end
		
		else
		begin
			sync0 <= wq2_rptr;
			sync1 <= sync0;
		end
	end
	
	assign sync_wq2_rptr = sync1;
	
	//converting from bin to gray
	
	assign wptr = (waddr >> 1) ^ waddr;
	
	//assign full flag
	
	assign wfull = (wptr[n] != sync_wq2_rptr[n] && wptr[n-1] != sync_wq2_rptr[n-1] && wptr[n-2:0] == sync_wq2_rptr[n-2:0]); 
	
endmodule

	
	