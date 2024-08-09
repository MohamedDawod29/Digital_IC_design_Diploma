module TOP #(parameter width = 8, depth = 8, n = $clog2(depth))
(
	input wire wclk,rclk,
	input wire wrst_n,rrst_n,
	input wire winc,rinc,
	input wire [width-1:0] wdata,
	output wire [width-1:0] rdata,
	output wire wfull,rempty
);
	wire [n:0] rq2_wptr,raddr,rptr,wq2_rptr,waddr,wptr;
	
	rempty #(.depth(depth), .n(n)) B0
	(
	.rclk(rclk),
	.rrst_n(rrst_n),
	.rinc(rinc),
	.rq2_wptr(wptr),
	.raddr(raddr),
	.rptr(rptr),
	.rempty(rempty)
	);
	
	wfull #(.depth(depth), .n(n)) B1
	
	(
	.wclk(wclk),
	.wrst_n(wrst_n),
	.winc(winc),
	.wq2_rptr(rptr),
	.waddr(waddr),
	.wptr(wptr),
	.wfull(wfull)
	);
	
	fifo_async #(.width(width), .depth(depth), .n(n)) B2
	(
	.wclk(wclk),
	.waddr(waddr),
	.raddr(raddr),
	.winc(winc), 
	.wfull(wfull),
	.wdata(wdata),
	.rdata(rdata)
	);

endmodule
	