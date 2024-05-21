class oMonitor extends uvm_monitor;
  virtual fifo_if_r vif;
  uvm_analysis_port #(packet) analysis_port;

  `uvm_component_utils(oMonitor)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual fifo_if_r)::get(this, "", "vif", vif);
    analysis_port = new("analysis_port", this);
  endfunction: build_phase

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if (vif == null) begin
      `uvm_fatal("CFGERR", "Interface for oMonitor not set");
    end
  endfunction: end_of_elaboration_phase

  virtual task run_phase(uvm_phase phase);
    packet tr;
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    forever begin
      tr = packet::type_id::create("tr", this);
      this.get_packet(tr);
    end
  endtask: run_phase

  virtual task get_packet(packet tr);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    @(negedge vif.rclk);
    if (vif.rinc == 1'b1 && vif.rempty == 1'b0) begin
        tr.mon_data = vif.rdata;
        `uvm_info("Got_Output_Packet", {"\n", tr.sprint()}, UVM_MEDIUM);
        analysis_port.write(tr);
    end
    //@(negedge vif.rclk);
    
  endtask: get_packet
endclass: oMonitor
