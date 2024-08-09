`timescale 1ns/10ps
module TOP_TB();

    // Parameters
    parameter WIDTH = 8;
    parameter DEPTH = 8;
    parameter N = $clog2(DEPTH);

    // Testbench signals
    reg wclk, rclk;
    reg wrst_n, rrst_n;
    reg winc, rinc;
    reg [WIDTH-1:0] wdata;
    wire [WIDTH-1:0] rdata;
    wire wfull, rempty;

    // Instantiate the DUT (Design Under Test)
    TOP #(
        .width(WIDTH),
        .depth(DEPTH),
        .n(N)
    ) DUT (
        .wclk(wclk),
        .rclk(rclk),
        .wrst_n(wrst_n),
        .rrst_n(rrst_n),
        .winc(winc),
        .rinc(rinc),
        .wdata(wdata),
        .rdata(rdata),
        .wfull(wfull),
        .rempty(rempty)
    );

    // Generate clocks
    initial begin
        wclk = 0;
        forever #5 wclk = ~wclk;  // 10 ns period
    end

    initial begin
        rclk = 0;
        forever #12.5 rclk = ~rclk;  // 25 ns period
    end

    // Test procedure
    initial begin
        // Initialize signals
        wrst_n = 0;
        rrst_n = 0;
        winc = 0;
        rinc = 0;
        wdata = 0;

        // Apply reset
        #20;
        wrst_n = 1;
        rrst_n = 1;
        
        // Wait for reset synchronization
        #40;

        // Write to FIFO
        write_to_fifo(8'hAA);
        write_to_fifo(8'hBB);
        write_to_fifo(8'hCC);

        // Read from FIFO
        read_from_fifo();

        // Test overflow (write more data than FIFO depth)
        repeat (DEPTH+2) begin
            write_to_fifo($random);
        end

        // Test underflow (read more data than written)
        repeat (DEPTH+2) begin
            read_from_fifo();
        end

        // End simulation
        #100;
        $stop;
    end

    // Task to write data to FIFO
    task write_to_fifo(input [WIDTH-1:0] data);
    begin
        @(posedge wclk);
        if (!wfull) begin
            wdata = data;
            winc = 1;
            $display("Write: %h at time %0t, waddr=%0h, wptr=%0h", data, $time, DUT.B1.waddr, DUT.B1.wptr);
        end else begin
            $display("Write failed (FIFO full) at time %0t", $time);
        end
        @(posedge wclk);
        winc = 0;
    end
    endtask

    // Task to read data from FIFO
    task read_from_fifo();
    begin
        @(posedge rclk);
        if (!rempty) begin
            rinc = 1;
            $display("Read: %h at time %0t, raddr=%0h, rptr=%0h", rdata, $time, DUT.B0.raddr, DUT.B0.rptr);
        end else begin
            $display("Read failed (FIFO empty) at time %0t", $time);
        end
        @(posedge rclk);
        rinc = 0;
    end
    endtask

    // Monitor for status signals
    initial begin
        $monitor("At time %0t: wfull=%b, rempty=%b", $time, wfull, rempty);
    end

endmodule
