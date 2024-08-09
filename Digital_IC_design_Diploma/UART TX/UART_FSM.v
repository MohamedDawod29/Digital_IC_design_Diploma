module UART_FSM 
(
	input wire clk,
	input wire reset_n,
	input wire PAR_EN,
	input wire ser_done,
	input wire Data_Valid,
	output reg ser_en,
	output reg [1:0] mux_sel,
	output reg busy
);

	reg [2:0] next_state,current_state;
	 
	localparam [2:0] idle = 3'b000, start = 3'b001, data = 3'b011, parity = 3'b010, stop = 3'b110;
	
	//states transition
	always @(posedge clk, negedge reset_n)
	begin
		if(~reset_n)
			current_state <= idle;
		else
			current_state <= next_state;
	end
	
	
	// next_state logic
	always @(*)
	begin
		case(current_state)
		idle:
		begin
			if (Data_Valid)
				next_state = start;
			else
				next_state = idle;
		end
		
		start:
		begin
			next_state = data;
		end
		
		data:
		begin
			if (ser_done)
			begin
				if (PAR_EN)
					next_state = parity;
				else
					next_state = stop;
			end
			else
				next_state = data;
		end
		
		parity:
		begin
			next_state = stop;
		end
		
		stop:
		begin
			next_state = idle;
		end
		
		default:
		begin
			next_state = idle;
		end	
		endcase
	end
	
	//output logic
	always @(*)
	begin
		case (current_state)
		idle:
		begin
			ser_en = 1'b0;
			busy = 1'b0;
			mux_sel = 2'b01;
		end
		
		start:
		begin
			ser_en = 1'b0;
			busy = 1'b1;
			mux_sel = 2'b00;
		end
		
		data:
		begin
			ser_en = 1'b1;
			busy = 1'b1;
			mux_sel = 2'b10;
		end
		
		parity:
		begin
			ser_en = 1'b0;
			busy = 1'b1;
			mux_sel = 2'b11;
		end
		
		stop:
		begin
			ser_en = 1'b0;
			busy = 1'b1;
			mux_sel = 2'b01;
		end
		
		default:
		begin
			ser_en = 1'b0;
			busy = 1'b0;
			mux_sel = 2'b01;
		end
		endcase
	end
	
endmodule

		