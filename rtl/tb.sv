`timescale 1 ns / 1 ps

module tb;


    parameter DSIZE = 32;
    parameter ASIZE = 4;
    reg wclk;
    reg rclk;

    fifo_if_r fifo_io_r(rclk);
    fifo_if_w fifo_io_w(wclk);


    async_fifo
	#(
		DSIZE,
		ASIZE
    )
    dut
    (
		fifo_io_w.wclk,
		fifo_io_w.wrst_n,
		fifo_io_w.winc,
		fifo_io_w.wdata,
		fifo_io_w.wfull,
		fifo_io_w.awfull,
		fifo_io_r.rclk,
		fifo_io_r.rrst_n,
		fifo_io_r.rinc,
		fifo_io_r.rdata,
		fifo_io_r.rempty,
		fifo_io_r.arempty
    );


    // An example to create a clock
    initial wclk = 1'b0;
    always #2 wclk <= ~wclk;
    initial rclk = 1'b0;
    always #3 rclk <= ~rclk;

    initial begin
    fifo_io_w.wrst_n <= 1'bx;
    #10;
    fifo_io_w.wrst_n <= 1'b0;
    #10;
    fifo_io_w.wrst_n <= 1'b1;
    end

    initial begin
    fifo_io_r.rrst_n <= 1'bx;
    #10;
    fifo_io_r.rrst_n <= 1'b0;
    #10;
    fifo_io_r.rrst_n <= 1'b1;
    end

endmodule

