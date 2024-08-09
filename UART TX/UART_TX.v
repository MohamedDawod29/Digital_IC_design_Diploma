module UART_TX #(parameter DATA_WIDTH = 8)
(
	input wire clk,
	input wire reset_n,
	input wire Data_Valid,
	input wire PAR_EN,
	input wire PAR_TYP,
	input wire [DATA_WIDTH-1:0] P_DATA,
	output busy,
	output TX_OUT
);

	wire ser_en,ser_done,ser_data;
	wire [1:0] mux_sel;
	wire parity_bit;
	
	serializer #(.DATA_WIDTH(DATA_WIDTH)) B0
	(
	.clk(clk),
	.reset_n(reset_n),
	.ser_en(ser_en),
	.Data_Valid(Data_Valid),
	.P_DATA(P_DATA),
	.ser_data(ser_data),
	.ser_done(ser_done)
	);
	
	UART_FSM B1
	(
	.clk(clk),
	.reset_n(reset_n),
	.PAR_EN(PAR_EN),
	.ser_done(ser_done),
	.Data_Valid(Data_Valid),
	.ser_en(ser_en),
	.mux_sel(mux_sel),
	.busy(busy)
	);
	
	parity_calc #(.DATA_WIDTH(DATA_WIDTH)) B2
	(
	.clk(clk),
	.reset_n(reset_n),
	.Data_Valid(Data_Valid),
	.PAR_TYP(PAR_TYP),
	.PAR_EN(PAR_EN),
	.P_DATA(P_DATA),
	.parity_bit(parity_bit) 
	);

	MUXX B4
	(
	.clk(clk),
	.reset_n(reset_n),
	.parity_bit(parity_bit),
	.ser_data(ser_data),
	.mux_sel(mux_sel),
	.TX_OUT(TX_OUT)
	);


endmodule
