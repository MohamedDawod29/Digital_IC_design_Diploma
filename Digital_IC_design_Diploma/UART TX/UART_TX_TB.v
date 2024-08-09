`timescale 1us/1ns
module UART_TX_TB ;

	localparam DATA_WIDTH = 8;
	localparam clk_period = 8.86;
	
	//signal definition
	
	reg clk_TB;
	reg reset_n_TB;
	reg Data_Valid_TB;
	reg PAR_EN_TB;
	reg PAR_TYP_TB;
	reg [DATA_WIDTH-1:0] P_DATA_TB;
	wire busy_TB;
	wire TX_OUT_TB;

	
	//initial block

	initial 
	begin
		$dumpfile ("UART_TX.vcd");
		$dumpvars;
		
		initialize();
		reset();
		
		//Case 1 No parity
		confg(1'b0,1'b0);
		Data_Entry(8'b11010011);
		#(50*clk_period)
		
		
		//Case 2 parity even
		confg(1'b1,1'b0);
		Data_Entry(8'b11010010);
		#(50*clk_period)
		
		
		//Case 3 parity odd
		confg(1'b1,1'b1);
		Data_Entry(8'b11111011);
		#(50*clk_period)
		
		
		$stop;
	end


	//instatiation

	UART_TX DUT
	(
	.clk(clk_TB),
	.reset_n(reset_n_TB),
	.Data_Valid(Data_Valid_TB),
	.PAR_EN(PAR_EN_TB),
	.PAR_TYP(PAR_TYP_TB),
	.P_DATA(P_DATA_TB),
	.busy(busy_TB),
	.TX_OUT(TX_OUT_TB)
	);


	//clock generator

	//freq 115200            period 8.86 us

	always #(clk_period/2) clk_TB = ~clk_TB;


	//Initialization

	task initialize;
		begin
			clk_TB = 1'b0; 
			reset_n_TB = 1'b1;
		end
	endtask

	//reset

	task reset;
		begin
			#clk_period
			reset_n_TB = 1'b0;
			#clk_period
			reset_n_TB = 1'b1;
			#(clk_period/2);
		end
	endtask


	//configration           
	task confg;
		input  PAR_EN_T,PAR_TYP_T;	           //two inputs for this task
		begin
			PAR_EN_TB = PAR_EN_T;
			PAR_TYP_TB = PAR_TYP_T;
		end
	endtask
	
	
	//input the data
	task Data_Entry;
		input [DATA_WIDTH-1:0] Data_in;          //one input for this task
		begin
			P_DATA_TB = Data_in;
			Data_Valid_TB = 1'b1;              //rise the Data_Valid signal for only one clock period
			#clk_period
			Data_Valid_TB = 1'b0;
		end
	endtask
	

endmodule
