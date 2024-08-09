module RegFile #(parameter Width = 16 , Depth = 8 , ADDR = 3)
(
	input wire clk,reset_n,Wr_En,Rd_En,
	input wire [ADDR - 1:0] Address,
	input wire [Width - 1:0] WrData,
	output reg [Width - 1:0] RdData
);

	reg [Width - 1:0] RegFile [Depth - 1:0];
	integer i;
	
	always @(posedge clk or negedge reset_n)
	begin
		if (~reset_n)
		begin
			for (i = 0;i < Depth; i = i+1) begin
				RegFile [i] <= 'b0;
		   end
		end
		
		else if (Wr_En & !Rd_En)
			RegFile[Address] <= WrData;
		
		else if (Rd_En & !Wr_En)
			RdData <= RegFile[Address];
		
		else
		begin
			RegFile[Address] <= 'b0;
			RdData <= 'b0;
		end
	end
	
endmodule

	