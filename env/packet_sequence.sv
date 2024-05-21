// The packet_sequence class has been modified to extend from packet_sequence_base class.
// The reason for this change is to simplify development of the body() method of the sequence
// by moving the raising and dropping of objections to the base class's pre_start() and
// post_start() methods.
//
// With this modification, the packet_sequence class's body() method no longer needs to
// raise and drop objections. 


class packet_sequence extends uvm_sequence #(packet);
  `uvm_object_utils(packet_sequence)

  function new(string name = "packet_sequence");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    `ifndef UVM_VERSION_1_1
      set_automatic_phase_objection(1);
    `endif
  endfunction: new


  virtual task pre_start();
    if ((get_parent_sequence() == null) && (starting_phase != null)) begin
      starting_phase.raise_objection(this);
    end
  endtask: pre_start

  virtual task post_start();
    if ((get_parent_sequence() == null) && (starting_phase != null)) begin
      starting_phase.drop_objection(this);
    end
  endtask: post_start

  virtual task body();
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    repeat(300) begin
    `uvm_do(req);
    end

  endtask: body


endclass: packet_sequence
