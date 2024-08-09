module parity_calc #(parameter DATA_WIDTH = 8)
(
	input wire clk,reset_n,
	input wire Data_Valid,PAR_TYP,PAR_EN,
	input wire [DATA_WIDTH-1:0] P_DATA,
	output reg parity_bit 
);

	reg [DATA_WIDTH-1:0] DATA;
	
	always @(posedge clk, negedge reset_n)
	begin
		if(~reset_n)
			DATA <= 'b0;
		else if (Data_Valid)
			DATA <= P_DATA;
	end

	always @(posedge clk, negedge reset_n)
	begin
		if (~reset_n)
			parity_bit <= 1'b0;
		
		else 
		begin
			if (PAR_EN)
			begin
				case (PAR_TYP)
				1'b0: parity_bit <= ^DATA;                  //even parity
				1'b1: parity_bit <= ~^DATA;               //odd parity
				endcase
			end
		end	
	end
	
endmodule

	