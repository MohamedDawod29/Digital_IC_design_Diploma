module serializer #(parameter DATA_WIDTH = 8)
(
	input wire clk,reset_n,
	input wire ser_en,Data_Valid,
	input wire [DATA_WIDTH-1:0] P_DATA,
	output  ser_data,ser_done
);


	reg[2:0] counter;
	reg[DATA_WIDTH-1:0] Data;
	
	
	//shift the P_input data
	always @(posedge clk, negedge reset_n)
	begin
		if (~reset_n)
			Data <= 0;
		
		else if (Data_Valid)
			Data <= P_DATA;
		
		else if (ser_en)
			Data <= Data >> 1;
	end
			
	always @(posedge clk, negedge reset_n)
	begin
		if (~reset_n)
			counter <= 0;
			
		else 
		begin
			if (ser_en)
				counter <= counter + 1;
			else
				counter <= 0;
		end
	end
	
	assign ser_done = (counter == 3'b111)?1'b1 : 1'b0;
	assign ser_data = Data[0];
	
endmodule
