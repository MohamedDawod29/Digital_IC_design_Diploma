`timescale 1ns/1ps
module fsm_garage_TB();

 reg clk;
 reg reset_n;
 reg Up_Max;
 reg Dn_Max;
 reg Active;
 wire UP_M;
 wire DN_M;
 
 
 localparam clk_period = 20;

 initial 
 begin
	$dumpfile ("fsm_garage_TB.vcd");
	$dumpvar;
	
	initialize();
	reset();
	case_1();
	case_2();
	case_3();
	case_4();
	
	#clk_period
	$stop;
 end
 
 
 task initialize;
 begin
	clk = 1'b0;
	reset_n = 1'b1;
	Up_Max = 1'b0;
	Dn_Max = 1'b0;
	Active = 1'b0;
 end
 endtask
 
 task reset;
 begin
	#clk_period 
	reset_n = 1'b0;
	#clk_period
	reset_n = 1'b1;
 end
 endtask

 task case_1;
 begin
	#clk_period
	$display("###################");
	$display("#Case 1 is Move_Up#");
	$display("###################");
	
	#clk_period
	Active = 1'b1;
	Dn_Max = 1'b1;
	Up_Max = 1'b0;
	
	#(clk_period/2)
	if (UP_M & ~DN_M)
		$display("Case 1 is passed");
	else
		$display("Case 1 is not passed");
 end
 endtask
 
 
 task case_2;
 begin
	#clk_period
	$display("###################");
	$display("#Case 2 is Move_Dn#");
	$display("###################");
	
	#clk_period
	Active = 1'b1;
	Dn_Max = 1'b0;
	Up_Max = 1'b1;
	
	#(clk_period/2)
	if (~UP_M & DN_M)
		$display("Case 2 is passed");
	else
		$display("Case 2 is not passed");
 end
 endtask
 
 
 task case_3;
 begin
	#clk_period
	$display("################################");
	$display("#Case 3 is Back to idle from Up#");
	$display("################################");
	
	#clk_period
	Active = 1'b0;
	Dn_Max = 1'b0;
	Up_Max = 1'b1;
	
	#(clk_period/2)
	if (~UP_M & ~DN_M)
		$display("Case 3 is passed");
	else
		$display("Case 3 is not passed");
 end
 endtask
 
 
 task case_4;
 begin
	#clk_period
	$display("################################");
	$display("#Case 4 is Back to idle from Dn#");
	$display("################################");
	
	#clk_period
	Active = 1'b0;
	Dn_Max = 1'b1;
	Up_Max = 1'b0;
	
	#(clk_period/2)
	if (~UP_M & ~DN_M)
		$display("Case 4 is passed");
	else
		$display("Case 4 is not passed");
 end
 endtask
 
 always #(clk_period/2) clk = ~clk;
 
 fsm_garage DUT 
 (
 .clk(clk),
 .reset_n(reset_n),
 .Up_Max(Up_Max),
 .Dn_Max(Dn_Max),
 .Active(Active),
 .UP_M(UP_M),
 .DN_M(DN_M)
 );
 
 
endmodule
