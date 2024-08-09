module fsm
(
	input wire button_1,button_0,reset_n,clk,
	output reg unlock	
);

	//define states
	
	reg [2:0] next_state,current_state;
	localparam idle = 3'b000, s1 = 3'b001 , s11 = 3'b011 , s011 = 3'b010, s1011 = 3'b110; 
	
	
	// current and next state transition
	always @(posedge clk,negedge reset_n)
	begin
		if (~reset_n)
			current_state <= idle;
		else
			current_state <= next_state;
	end
	
	//next state
	always @(*)
	begin
		case (current_state)
			idle:
			begin
				if (button_1)
					next_state = s1;
				else
					next_state = idle;
			end
			
			s1:
			begin
				if (button_1)
					next_state = s11;
				else if (button_0)
					next_state  = idle;
				else
					next_state = s1;
			end
			
			s11:
			begin
				if (button_0)
					next_state = s011;
				else if (button_1)
					next_state  = idle;
				else
					next_state = s11;
			end
			
			s011:
			begin
				if (button_1)
					next_state = s1011;
				else if (button_0)
					next_state  = idle;
				else
					next_state = s1011;
			end
			
			s1011:
			begin
				if (button_0)
					next_state = idle;
				else if (button_1)
					next_state  = idle;
				else
					next_state = s1011;
			end
			
			default: next_state = idle;
		endcase
	end
	
	//output
	always @(*)
	begin
		case (current_state)
			idle:
			begin
					unlock = 1'b0;
			end
			
			s1:
			begin
					unlock = 1'b0;
			end
			
			s11:
			begin
					unlock = 1'b0;
			end
			
			s011:
			begin
					unlock = 1'b0;
			end
			
			s1011:
			begin
				if (button_0)
					unlock = 1'b1;
				else if (button_1)
					unlock  = 1'b0;
				else
					unlock  = 1'b0;
			end
			
			default: unlock  = 1'b0;
		endcase
	end
	
endmodule
