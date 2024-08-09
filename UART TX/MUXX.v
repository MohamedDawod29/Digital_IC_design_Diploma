module MUXX 
(
	input wire clk,reset_n,
	input wire parity_bit,
	input wire ser_data,
	input wire [1:0] mux_sel,
	output reg TX_OUT
);

	reg out;
	
	always @ (posedge clk, negedge reset_n)
	begin
		if (~reset_n)
			TX_OUT <= 1'b1;
		else
			TX_OUT <= out;
	end
	
	always @(*)
	begin
		case (mux_sel)
		2'b00: out = 1'b0;              //start
		2'b01: out = 1'b1;              //stop
		2'b10: out = ser_data;
		2'b11: out = parity_bit;
		endcase
	end
	
endmodule
