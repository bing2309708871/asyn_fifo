interface fifo_if_r(input logic rclk);

    parameter DSIZE = 32;

    logic              rrst_n;
    logic              rinc;
    logic [DSIZE-1:0] rdata;
    logic             rempty;
    logic             arempty;

endinterface
