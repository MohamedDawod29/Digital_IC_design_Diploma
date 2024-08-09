`timescale 1ns/10ps
module DATA_SYNC_TB;

   // TB signals and parameters
	
   localparam NUM_STAGES = 2, BUS_WIDTH = 8;
	
	reg clk, reset_n;
	reg bus_enable;
	reg [BUS_WIDTH-1:0] unsync_bus;
	wire enable_pulse;
	wire [BUS_WIDTH-1:0] sync_bus;
	
	//instantiation
	
	DATA_SYNC #(.NUM_STAGES(NUM_STAGES), .BUS_WIDTH(BUS_WIDTH)) DUT
	(
		.clk(clk), 
		.reset_n(reset_n),
		.bus_enable(bus_enable),
		.unsync_bus(unsync_bus),
		.enable_pulse(enable_pulse),
		.sync_bus(sync_bus)
	);
	
	//clock generator
	
	always #5 clk = ~clk;                        //period 10 ns
	
	//initial block and test cases
	
	initial 
	begin
		$dumpfile ("DATA_SYNC_TB.vcd");
		$dumpvars;
		
		initialization;
		reset;
		
		// test case 1 enable signal rised for two clock cycles
		
		$display ("#########################################################################################################################################");
		$display ("###############################################################CASE2#####################################################################");
		$display ("#########################################################################################################################################");
		
		bus_enable = 1'b1;
		unsync_bus = 8'b00010001;
		
		#20
		bus_enable = 1'b0;
		
		#15
		
		if (enable_pulse == 1'b1 && sync_bus == 8'b00010001)
			$display ("enable_pulse = %b | sync_bus = %b | Time = %t ",enable_pulse,sync_bus,$time);
		else
			$display ("enable_pulse = %b | sync_bus = %b | Time = %t ",enable_pulse,sync_bus,$time);
		
		#6
		
		if (enable_pulse == 1'b0 && sync_bus == 8'b00010001)
			$display ("DATA_SYNC WORKED CORRECTLY | enable_pulse = %b | sync_bus = %b | Time = %t \n The pulse generator worked correctly also. ",enable_pulse,sync_bus,$time);
		else
			$display ("DATA_SYNC NOT WORKED CORRECTLY | enable_pulse = %b | sync_bus = %b | Time = %t ",enable_pulse,sync_bus,$time);
			
			
		// test case 2 enable signal rised for one clock cycle
		
		$display ("#########################################################################################################################################");
		$display ("###############################################################CASE2#####################################################################");
		$display ("#########################################################################################################################################");
		
		#9
		bus_enable = 1'b1;
		unsync_bus = 8'b11110001;
		
		#10
		bus_enable = 1'b0;
		
		#25
		
		if (enable_pulse == 1'b1 && sync_bus == 8'b11110001)
			$display ("enable_pulse = %b | sync_bus = %b | Time = %t ",enable_pulse,sync_bus,$time);
		else
			$display ("enable_pulse = %b | sync_bus = %b | Time = %t ",enable_pulse,sync_bus,$time);
		
		#6
		
		if (enable_pulse == 1'b0 && sync_bus == 8'b11110001)
			$display ("DATA_SYNC WORKED CORRECTLY | enable_pulse = %b | sync_bus = %b | Time = %t \n The pulse generator worked correctly also. ",enable_pulse,sync_bus,$time);
		else
			$display ("DATA_SYNC NOT WORKED CORRECTLY | enable_pulse = %b | sync_bus = %b | Time = %t ",enable_pulse,sync_bus,$time);
		
		#20
		$stop;
	end
	
	
	//initialization task
	
	task initialization;
		begin
			clk = 0;
			reset_n = 1;
			bus_enable = 0;
			unsync_bus = 0;
		end
	endtask
	
	//reset task
	
	task reset;
		begin
			reset_n = 1'b0;
			#15
			reset_n = 1'b1;
		end
	endtask
	
	
endmodule	


