module rempty #(parameter depth = 8, n = $clog2(depth))
(
	input wire rclk,rrst_n,
	input wire rinc,
	input wire [n:0] rq2_wptr,
	output reg [n:0] raddr,
	output wire [n:0] rptr,
	output wire rempty
);

	always @(posedge rclk, negedge rrst_n)
	begin
		if (~rrst_n)
			raddr <= 'b0;
		else if (rinc && !rempty)
			raddr <= raddr + 1;	
	end
	
	//synchronization
	
	reg [n:0] sync0,sync1;
	wire [n:0] sync_rq2_wptr;
	
	always @(posedge rclk, negedge rrst_n)
	begin
		if (~rrst_n)
		begin
			sync0 <= 0;
			sync1 <= 0;
		end
		
		else
		begin
			sync0 <= rq2_wptr;
			sync1 <= sync0;
		end
	end
	
	assign sync_rq2_wptr = sync1;
	
	//converting from bin to gray
	
	assign rptr = (raddr >> 1) ^ raddr;
	
	//assign empty flag
	
	assign rempty = (rptr == sync_rq2_wptr);
	
endmodule

	
	