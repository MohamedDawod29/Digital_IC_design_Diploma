`timescale 1ns/1ns

module RegFile_TB ;

//parameters
parameter WIDTH = 16 ; 
parameter DEPTH = 8 ; 
parameter ADDR = 3 ;

//declare the signals
reg Wr_En_TB, Rd_En_TB,clk_TB,reset_n_TB;
reg [WIDTH - 1:0] WrData_TB;
reg [ADDR - 1:0] Address_TB;
wire [WIDTH - 1:0] RdData_TB;

//instantiation of DUT
RegFile #(.Width(WIDTH), .Depth(DEPTH), .ADDR(ADDR)) DUT
(
	.clk(clk_TB),
	.reset_n(reset_n_TB),
	.Wr_En(Wr_En_TB),
	.Rd_En(Rd_En_TB),
	.WrData(WrData_TB),
	.RdData(RdData_TB),
	.Address(Address_TB)
);

//clock generator
always #5 clk_TB = ~clk_TB;

//test cases
initial 
begin
	$dumpfile("RegFile_TB.vcd");
	$dumpvars;
	
	//initialize signals
	clk_TB = 0;
	reset_n_TB = 1;
	Wr_En_TB = 0;
	Rd_En_TB = 0;
	
	//reset the desig
	#5 reset_n_TB = 0;
	#5 reset_n_TB = 1;
	
	//case 1 (writing)
	$display ("**************************************Case 1 is Writing in address 2*********************************************************");
	Wr_En_TB = 1;
	Rd_En_TB = 0;
	WrData_TB = 16'h0002;
	Address_TB = 3'b010;
	
	#10
	//case 2 (writing)
	$display ("**************************************Case 2 is Writing in address 3*********************************************************");
	Wr_En_TB = 1;
	Rd_En_TB = 0;
	WrData_TB = 16'h0003;
	Address_TB = 3'b011;

	#10
	//case 3 (reading)
	$display ("**************************************Case 3 is reading from address 2*********************************************************");
	Wr_En_TB = 0;
	Rd_En_TB = 1;
	Address_TB = 3'b010;
	#6
		if(RdData_TB == 16'h0002 & Address_TB == 3'b010)
		$display ("Case 3 is reading from address 2 is passed");
		else
		$display ("Case 3 is reading from address 2 is not passed");
	#4
	//case 4 (reading)
	$display ("**************************************Case 4 is reading from address 3*********************************************************");
	Wr_En_TB = 0;
	Rd_En_TB = 1;
	Address_TB = 3'b011;
	#6
		if(RdData_TB == 16'h0003 & Address_TB == 3'b011)
		$display ("Case 4 is reading from address 3 is passed");
		else
		$display ("Case 4 is reading from address 3 is not passed");
	
	#100
	$stop;
end

endmodule
	