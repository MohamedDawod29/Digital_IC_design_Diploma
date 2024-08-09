`timescale 1ns/10ps
module RST_SYNC_TB;

    // Parameters
    parameter NUM_STAGES = 2;
    
    // Signals
    reg clk;
    reg reset_n;
    wire SYNC_RST;
    
    // Instantiation
    RST_SYNC #(NUM_STAGES) DUT
	 (
        .clk(clk),
        .reset_n(reset_n),
        .SYNC_RST(SYNC_RST)
    );
    
    // Clock generator
        
    always #5 clk = ~clk; // period 10 ns
    
    // initial block and test cases
	 
    initial 
	 begin
        // Initial conditions  
		clk = 0;
		reset_n = 1'b1;
		
		// reset
		#5
        reset_n = 1'b0;		
        #15;           
        // deassert the reset
        reset_n = 1'b1; 
          
        #50;
        $stop;
    end
    
    // Monitor output
	 
    initial 
	begin
        $monitor("At time %t, reset_n = %b, SYNC_RST = %b", $time, reset_n, SYNC_RST);
    end
    
endmodule
