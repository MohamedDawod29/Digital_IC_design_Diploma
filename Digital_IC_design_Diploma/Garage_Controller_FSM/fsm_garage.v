module fsm_garage
(
input wire clk,reset_n,
input wire Up_Max,Dn_Max,Active,
output reg UP_M,DN_M
);

localparam [1:0] idle = 0, Move_Up = 1, Move_Dn = 3;
reg [1:0] next_state,current_state;


//state transitions
always @(posedge clk , negedge reset_n)
begin
	if (~reset_n)
		current_state <= idle;
	else
		current_state <= next_state;
end


//state logic
always @(*)
begin
	case (current_state)
	idle:
	begin
		if (~Active)
			next_state = idle;
		else if (Active & Dn_Max & ~Up_Max)
			next_state = Move_Up;
		else if (Active & ~Dn_Max & Up_Max)
			next_state = Move_Dn;
		else
			next_state = idle;
	end
	
	Move_Up:
	begin
		if (Up_Max)
			next_state = idle;
		else
			next_state = Move_Up;
	end
	
	Move_Dn:
	begin
		if (Dp_Max)
			next_state = idle;
		else
			next_state = Move_Dn;
	end
	
	default: next_state = idle;
	endcase
end

//output logic
always @(*)
begin
	case (current_state)
	idle:
	begin
		UP_M = 1'b0;
		DN_M = 1'b0;
	end
	
	Move_Up:
	begin
		UP_M = 1'b1;
		DN_M = 1'b0;
	end
	
	Move_Dn:
	begin
		UP_M = 1'b0;
		DN_M = 1'b1;
	end
	
	default: 
	begin
		UP_M = 1'b0;
		DN_M = 1'b0;
	end
	endcase
end

endmodule
