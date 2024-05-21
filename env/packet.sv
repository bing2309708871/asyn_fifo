// All transaction classes must be extended from the uvm_sequence_item base class.

class packet extends uvm_sequence_item;


  rand bit [31:0] wdata;
  rand bit [31:0] mon_data;
  rand bit        valid;

  `uvm_object_utils_begin(packet)
    `uvm_field_int(wdata, UVM_ALL_ON|UVM_NOCOMPARE|UVM_NOPRINT);
    `uvm_field_int(mon_data, UVM_ALL_ON);
    `uvm_field_int(valid, UVM_ALL_ON);

  `uvm_object_utils_end


  function new(string name = "packet");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

endclass: packet
