program automatic test;
import uvm_pkg::*;
import test_pkg::*;

initial begin
  $fsdbDumpfile("tb.fsdb");
  $fsdbDumpvars();
  $timeformat(-9, 1, "ns", 10);
  uvm_resource_db#(virtual fifo_if_w)::set("vif_w","",tb.fifo_io_w);
  uvm_resource_db#(virtual fifo_if_r)::set("vif_r","",tb.fifo_io_r);
  run_test("test_base");
end

endprogram

