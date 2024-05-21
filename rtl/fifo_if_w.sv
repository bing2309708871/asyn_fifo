interface fifo_if_w(input logic wclk);

    parameter DSIZE = 32;

    logic              wrst_n;
    logic              winc;
    logic  [DSIZE-1:0] wdata;
    logic             wfull;
    logic             awfull;


endinterface
