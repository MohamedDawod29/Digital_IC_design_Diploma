`timescale 1ns/1ns
module LFSR_TB ;

//difine signals
	reg clk_TB,reset_TB;
	wire [7:0] LFSR_TB;
	reg [7:0] seed_TB;
	reg enable_TB,out_enable_TB;
	wire valid_TB;
	wire OUT_TB;
	
//clock generator
	always #5 clk_TB = ~clk_TB;
	
//initial block
	initial
		begin
		$dumpfile("LFSR_TB.vcd");
		$dumpvars;
		
		initialzie();
		enable(8'b10010010);
		out();
		
		#100
		$stop;
		end
	
//initialization
	task initialzie;
		begin
		clk_TB = 1'b0;
		reset_TB = 1'b1;
		enable_TB = 1'b0;
		out_enable_TB = 1'b0;
		end
	endtask
	
//reset the LFSR
	task reset;
		begin
		#5
		reset_TB = 1'b0;
		#5
		reset_TB = 1'b1;
		end
	endtask
	
//enabling case
	task enable;
		input [7:0] seed_T;
		begin
		#5
		seed_TB = seed_T;
		reset();
		#5
		enable_TB = 1'b1;
		#100
		enable_TB = 1'b0;
		end
	endtask
	
//out serially
	task out;
		begin
		#10
		out_enable_TB = 1'b1;
		#80
		out_enable_TB = 1'b0;
		end
	endtask
	
//instatiation
	LFSR DUT
	(
	.clk(clk_TB),
	.reset(reset_TB),
	.LFSR(LFSR_TB),
	.seed(seed_TB),
	.enable(enable_TB),
	.out_enable(out_enable_TB),
	.valid(valid_TB),
	.OUT(OUT_TB)
	);
		
endmodule
		
			